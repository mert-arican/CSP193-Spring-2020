//
//  Array+RandomElement.swift
//  Assignment 3
//
//  Created by Mert Arıcan on 5.07.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    mutating func popRandomElement() -> Element? {
        if let randomElement = self.randomElement() {
            let index = self.firstIndex(matching: randomElement)!
            return self.remove(at: index)
        }
        return nil
    }
}
