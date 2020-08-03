//
//  Array+Only.swift
//  Lecture 4 Grid + enum + Optionals
//
//  Created by Mert Arıcan on 27.06.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
