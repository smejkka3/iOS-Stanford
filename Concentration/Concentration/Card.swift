//
//  Card.swift
//  Concentration
//
//  Created by Karel Smejkal on 6/13/18.
//  Copyright © 2018 Karel Smejkal. All rights reserved.
//

import Foundation

//struct makes copy of the object, class passes reference
struct Card : Hashable {
    var hashValue: Int {return indentifier }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.indentifier == rhs.indentifier
    }
    
    var isFaceUp = false
    var isMatched = false
    var seenBefore = false
    private var indentifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.indentifier = Card.getUniqueIdentifier()
    }
    
}
