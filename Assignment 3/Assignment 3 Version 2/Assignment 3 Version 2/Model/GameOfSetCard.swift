//
//  FeatureProtocol.swift
//  Assignment 3 Version 2
//
//  Created by Mert Arıcan on 9.07.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import Foundation

protocol FeatureProtocol: Hashable {
    // All features must conform to this protocol before getting used with model.
    associatedtype Feature where Feature: Hashable
    var feature: Feature { get }
    var featureLabel: String { get }
}

struct Card: Identifiable {
    // Card struct has a dictionary property that holds the feature values as type-erased values
    // and associates them with feature labels given in 'FeatureLabels' struct
    // Card can have any feature as long as that feature is 'Hashable'
    var id: Int
    var isSelected = false
    var isMatch: MatchState = .normal
    private var allFeatures: [String:AnyHashable]
    
    init(allFeatures: [String:AnyHashable], id: Int) {
        self.allFeatures = allFeatures
        self.id = id
    }
    
    func getFeatureOfACard(with label: String) -> AnyHashable {
        return allFeatures[label]!
    }
}
