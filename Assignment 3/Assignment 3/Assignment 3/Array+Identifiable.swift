//
//  Array+Identifiable .swift
//  Lecture 4 Grid + enum + Optionals
//
//  Created by Mert Arıcan on 27.06.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
