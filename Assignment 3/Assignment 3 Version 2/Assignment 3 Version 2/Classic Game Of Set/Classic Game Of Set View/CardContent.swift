//
//  Diamond.swift
//  Assignment 3 Version 2
//
//  Created by Mert Arıcan on 3.07.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import SwiftUI

struct CardContent: Shape {
    
    let card: Card
    
    // MARK: - Main drawing function
    
    func path(in rect: CGRect) -> Path {
        let shading = card.getFeatureOfACard(with: FeatureLabels.shading) as! CardShading
        return shading != .straped ? draw(the: card, in: rect) : drawStripes(at: draw(the: card, in: rect), in: rect)
    }
    
    // MARK: - Helper drawing functions
    
    private func getDrawingPoints(in rect: CGRect) -> [CGPoint] {
        // Finds and returns points that are ready to use with drawing methods below.
        let size = rect.size
        let width = size.width
        let numberOfObjects = CGFloat((card.getFeatureOfACard(with: FeatureLabels.numberOfShapes) as! NumberOfShapes).rawValue)
        let totalWidth = (width*numberOfObjects*(Ratios.objectWidthRatio)*2) + ((numberOfObjects-1) * (width*Ratios.verticalOffSetRatio))
        let x = (width - totalWidth) / 2
        var array = [CGPoint]()
        for index in 0..<Int(numberOfObjects) {
            let positionX = x + (CGFloat(index) * ((2*Ratios.objectWidthRatio*width))) + ((CGFloat(index)*width*Ratios.verticalOffSetRatio))
            array.append(CGPoint(x: positionX, y: rect.midY))
        }
        return array
    }
    
    private func drawOval(at point: CGPoint, in size: CGSize) -> Path {
        let width = size.width ;  let height = size.height
        let rect = Path(roundedRect: CGRect(x: point.x, y: point.y-(height*Ratios.objectHeightRatio), width: width*2*Ratios.objectWidthRatio, height: height*2*Ratios.objectHeightRatio), cornerRadius: 50.0)
        return rect
    }
    
    private func drawDiamond(at point: CGPoint, in size: CGSize) -> Path {
        let width = size.width ; let height = size.height
        let objectWidth = width * Ratios.objectWidthRatio
        let objectHeight = height * Ratios.objectHeightRatio
        let x2 = point.x + objectWidth ; let y2 = point.y - objectHeight
        let x3 = point.x + 2 * objectWidth ; let y3 = point.y
        let x4 = x2 ; let y4 = point.y + objectHeight
        var diamond = Path()
        diamond.move(to: point)
        diamond.addLine(to: CGPoint(x: x2, y: y2))
        diamond.addLine(to: CGPoint(x: x3, y: y3))
        diamond.addLine(to: CGPoint(x: x4, y: y4))
        diamond.closeSubpath()
        return diamond
    }
    
    private func drawSquiggle(at point: CGPoint, in size: CGSize) -> Path {
        let width = size.width ;  let height = size.height
        let t1 = CGPoint(x: point.x, y: point.y - (8*Ratios.k*height))
        let c1 = CGPoint(x: point.x - (1.5*Ratios.k*width) + (width*Ratios.objectWidthRatio), y: point.y - (4*Ratios.k*height))
        let c2 = CGPoint(x: c1.x, y: point.y)
        let t2 = CGPoint(x: point.x, y: point.y + 10*Ratios.k*height)
        let t3 = CGPoint(x: point.x+(2*Ratios.objectWidthRatio*width), y: t2.y)
        let c3 = CGPoint(x: point.x + (Ratios.objectWidthRatio*width), y: point.y + (Ratios.objectHeightRatio*height))
        let c4 = CGPoint(x: point.x + (1.5*Ratios.k*width) + (width*Ratios.objectWidthRatio), y: point.y + (4*Ratios.k*height))
        let c5 = CGPoint(x: c4.x, y: point.y)
        let t4 = CGPoint(x: point.x + (2*width*Ratios.objectWidthRatio), y: point.y - (8*Ratios.k*height))
        let c6 = CGPoint(x: c3.x, y: point.y - (Ratios.objectHeightRatio*height))
        var path = Path()
        path.move(to: t1)
        path.addCurve(to: t2, control1: c1, control2: c2)
        path.addQuadCurve(to: t3, control: c3)
        path.addCurve(to: t4, control1: c4, control2: c5)
        path.addQuadCurve(to: t1, control: c6)
        return path
    }
    
    private func draw(the card: Card, in rect: CGRect) -> Path {
        // Draws the all content of a card in given 'rect'.
        var path = Path()
        let points = getDrawingPoints(in: rect)
        let shape = card.getFeatureOfACard(with: FeatureLabels.shape) as! CardShape
        switch shape {
        case .diamond:
            path = drawShapes(at: points, in: rect.size, using: drawDiamond)
        case .oval:
            path = drawShapes(at: points, in: rect.size, using: drawOval)
        case .squiggle:
            path = drawShapes(at: points, in: rect.size, using: drawSquiggle)
        }
        return path
    }
    
    private func drawShapes(at points: [CGPoint], in size: CGSize, using method:(CGPoint, CGSize) -> Path) -> Path {
        // Draws the content of a card using appropriate drawing method.
        let paths = points.compactMap({ (point) -> Path in method(point, size) })
        var card = Path()
        paths.forEach { card.addPath($0) }
        return card
    }
    
    private func drawStripes(at object: Path, in rect: CGRect) -> Path {
        // Draws stripes on given path.
        var object = object
        let k = rect.size.height / 20
        let x = rect.minX ; let y = rect.minY
        for index in 0..<20 {
            object.move(to: CGPoint(x: x, y: y + (CGFloat(index)*k) ) )
            object.addLine(to: CGPoint(x: x + (rect.width), y: y + (CGFloat(index)*k) ) )
        }
        return object
    }
    
}

// MARK: - Struct for holding drawing ratios.

struct Ratios {
    
    static let verticalOffSetRatio: CGFloat = 0.1093
    static let objectWidthRatio: CGFloat = 0.0937
    static let objectHeightRatio: CGFloat = 0.4
    static let k: CGFloat = 0.0208
    
}
