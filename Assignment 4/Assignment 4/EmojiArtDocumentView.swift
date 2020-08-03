//
//  EmojiArtDocumentView.swift
//  Lecture 7: Multithreading EmojiArt
//
//  Created by Mert Arıcan on 10.07.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document: EmojiArtDocument
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(EmojiArtDocument.palette.map { String($0) }, id: \.self) { emoji in
                        Text(emoji)
                            .font(Font.system(size: self.defaultEmojiSize))
                            .onDrag { return NSItemProvider(object: emoji as NSString) }
                    }
                }
            }
            .padding(.horizontal)
            GeometryReader { geometry in
                ZStack {
                    Color.white.overlay(
                        OptionalImage(uiImage: self.document.backgroundImage)
                            .scaleEffect(self.selectedEmojis.count == 0 ? self.zoomScale : self.steadyStateZoomScale)
                            .offset(self.panOffset)
                    )
                        .gesture(self.doubleTapToZoom(in: geometry.size))
                        .gesture(self.tapToSelect(for: nil))
                    ForEach(self.document.emojis) { emoji in
                        ZStack {
                            RoundedRectangle(cornerRadius: 0.0)
                                .stroke(self.getColor(for: emoji), lineWidth: 3.0)
                                .frame(width: self.getFontSize(for: emoji), height: self.getFontSize(for: emoji))
                                .position(self.position(for: emoji, in: geometry.size))
                            Text(emoji.text)
                                .font(animatableWithSize: self.getFontSize(for: emoji))
                                .position(self.position(for: emoji, in: geometry.size))
                                .gesture(self.tapToSelect(for: emoji))
                        }
                        .gesture(self.emojiPanGesture(for: emoji))
                    }
                }
                .clipped()
                .gesture(self.panGesture())
                .gesture(self.zoomGesture())
                .edgesIgnoringSafeArea([.horizontal, .bottom])
                .onDrop(of: ["public.image", "public.text"], isTargeted: nil) { providers, location in
                    var location = CGPoint(x: location.x, y: geometry.convert(location, from: .global).y)
                    location = CGPoint(x: location.x - geometry.size.width/2, y: location.y - geometry.size.height/2)
                    location = CGPoint(x: location.x - self.panOffset.width, y: location.y - self.panOffset.height)
                    location = CGPoint(x: location.x / self.zoomScale, y: location.y / self.zoomScale)
                    return self.drop(providers: providers, at: location)
                }
            }
        }
    }
    
    private func getColor(for emoji: EmojiArt.Emoji) -> Color {
        return self.selectedEmojis.contains { $0.id == emoji.id } ? Color.black : .clear
    }
    
    private func getFontSize(for emoji: EmojiArt.Emoji) -> CGFloat {
        if selectedEmojis.count > 0 {
            return emoji.fontSize * steadyStateZoomScale
        } else {
            return emoji.fontSize * zoomScale
        }
    }
    
    @State private var steadyStateZoomScale: CGFloat = 1.0
    @GestureState private var gestureZoomScale: CGFloat = 1.0
    
    private var zoomScale: CGFloat {
        steadyStateZoomScale * gestureZoomScale
    }
    
    private func zoomGesture() -> some Gesture {
        MagnificationGesture()
            .updating($gestureZoomScale) { latestGestureScale, gestureZoomScale, transaction in
                self.selectedEmojis.forEach { self.document.scaleEmoji($0, by: latestGestureScale / gestureZoomScale) }
                gestureZoomScale = latestGestureScale
        }
        .onEnded { finalGestureScale in
            if self.selectedEmojis.count == 0 {
                self.steadyStateZoomScale *= finalGestureScale
            }
        }
    }
    
    @State private var selectedEmojis = Set<EmojiArt.Emoji>()
    
    private func tapToSelect(for emoji: EmojiArt.Emoji?) -> some Gesture {
        TapGesture()
            .onEnded {
                guard let emoji = emoji else { self.selectedEmojis = Set<EmojiArt.Emoji>(); return }
                if let index = self.selectedEmojis.firstIndex(where: {$0.id == emoji.id}) {
                    self.selectedEmojis.remove(at: index)
                } else {
                    self.selectedEmojis.insert(emoji)
                }
        }
    }
    
    private func doubleTapToZoom(in size: CGSize) -> some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation {
                    self.zoomToFit(self.document.backgroundImage, in: size)
                }
        }
    }
    
    @State private var steadyStatePanOffset: CGSize = .zero
    @GestureState private var gesturePanOffset: CGSize = .zero
    
    private var panOffset: CGSize {
        (steadyStatePanOffset + gesturePanOffset) * (selectedEmojis.count == 0 ? zoomScale : steadyStateZoomScale)
    }
    
    private func panGesture() -> some Gesture {
        DragGesture()
            .updating($gesturePanOffset) { latestDragGestureValue, gesturePanOffset, transaction in
                gesturePanOffset = latestDragGestureValue.translation / self.zoomScale
        }
        .onEnded { finalDragGestureValue in
            self.steadyStatePanOffset = self.steadyStatePanOffset + (finalDragGestureValue.translation / self.zoomScale)
        }
    }
    
    @GestureState private var gesturePanOffsetForEmoji: CGSize = .zero
    
    // MARK: - Extra Credit
    
    private func emojiPanGesture(for emoji: EmojiArt.Emoji?) -> some Gesture {
        DragGesture()
            .updating($gesturePanOffsetForEmoji) { latestDragGestureValue, gesturePanOffsetForEmoji, transaction in
                if let emoji = emoji, !self.selectedEmojis.contains(where: { (selectedEmoji) in selectedEmoji.id == emoji.id }) {
                    self.document.moveEmoji(emoji, by: (latestDragGestureValue.translation / self.zoomScale) - gesturePanOffsetForEmoji)
                } else {
                    self.selectedEmojis.forEach {
                        self.document.moveEmoji($0, by: (latestDragGestureValue.translation / self.zoomScale) - gesturePanOffsetForEmoji)
                    }
                }
                gesturePanOffsetForEmoji = (latestDragGestureValue.translation / self.zoomScale)
        }
    }
    
    private func zoomToFit(_ image: UIImage?, in size: CGSize) {
        if let image = image, image.size.width > 0, image.size.height > 0 {
            let hZoom = size.width / image.size.width
            let vZoom = size.height / image.size.height
            steadyStatePanOffset = .zero
            self.steadyStateZoomScale = min(hZoom, vZoom)
        }
    }
    
    private func position(for emoji: EmojiArt.Emoji, in size: CGSize) -> CGPoint {
        var location = emoji.location
        if selectedEmojis.count > 0 {
            location = CGPoint(x: location.x * steadyStateZoomScale, y: location.y * steadyStateZoomScale)
            location = CGPoint(x: location.x + size.width/2, y: location.y + size.height/2)
            location = CGPoint(x: location.x + panOffset.width, y: location.y + panOffset.height)
            return location
        } else {
            location = CGPoint(x: location.x * zoomScale, y: location.y * zoomScale)
            location = CGPoint(x: location.x + size.width/2, y: location.y + size.height/2)
            location = CGPoint(x: location.x + panOffset.width, y: location.y + panOffset.height)
        }
        return location
    }
    
    private func drop(providers: [NSItemProvider], at location: CGPoint) -> Bool {
        var found = providers.loadFirstObject(ofType: URL.self) { url in
            self.document.setBackgroundURL(url)
        }
        if !found {
            found = providers.loadObjects(ofType: String.self) { string in
                self.document.addEmoji(string, at: location, size: self.defaultEmojiSize)
            }
        }
        return found
    }
    
    private let defaultEmojiSize: CGFloat = 40
    
}
