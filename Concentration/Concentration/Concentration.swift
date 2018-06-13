//
//  Concentration.swift
//  Concentration
//
//  Created by Karel Smejkal on 6/13/18.
//  Copyright © 2018 Karel Smejkal. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].indentifier == cards[index].indentifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                //either no or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            // thanks to the structure I can put 2 copies of card to array
            cards.append(card)
            cards.append(card)
        }
        // TODO: Shuffle the cards
        var lastCard = cards.count - 1
        
        while lastCard > 0 {
            let rand = Int(arc4random_uniform(UInt32(cards.count - 1 )))

            cards.swapAt(lastCard, rand)
            
            lastCard -= 1
        }
    }
}
