//
//  Card.swift
//  Concentration
//
//  Created by Jayyoung Yang on 07/02/2018.
//  Copyright © 2018 Jayyoung Yang. All rights reserved.
//

import Foundation

 struct Card: Hashable {
    var hashValue: Int { return identifier }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
