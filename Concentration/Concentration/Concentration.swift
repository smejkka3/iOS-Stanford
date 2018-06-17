//
//  Concentration.swift
//  Concentration
//
//  Created by Karel Smejkal on 6/13/18.
//  Copyright © 2018 Karel Smejkal. All rights reserved.
//

import Foundation

// copiing only when when its changing
struct Concentration {
    private(set) var cards = [Card]()
    
    // for var with set swift already know that it is mutating
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        // using computer property
        get {
                return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
            }
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards [index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
//        }
        // default name of local is newValue
        set {
            for index in cards.indices {
                // true if index of oneAndOnlyFaceUp equals newValue
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    var scoreCount = 0
    // swift is strongly type language -> everything has to have type, altought it can guess type
    private(set) var flipCount = 0
//  {
//        didSet {
//            updateFlipCountLabel()
//        }
//    }
//
//    private func updateFlipCountLabel() {
//        let attributes: [NSAttributedStringKey: Any] = [
//            .strokeWidth: 5.0,
//            .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
//        ]
//        let attributedString = NSAttributedString(string: "Flips: \(flipCount)",
//            attributes: attributes)
//
//        flipCountLabel.attributedText = attributedString
//    }
    
    // function is not marked mutable so it is assumed that it is not mutable
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): Chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    scoreCount += 2
                } else {
                    if cards[index].seenBefore == true {
                        scoreCount -= 1
                    }
                }
                cards[index].isFaceUp = true
                // indexOfOneAndOnlyFaceUpCard = nil ---> already done in computer property

                cards[index].seenBefore = true
            } else {
                //either no or 2 cards are face up
//                for flipDownIndex in cards.indices {
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
//                ----- > all of this also done in computer property
                indexOfOneAndOnlyFaceUpCard = index
            }
            flipCount += 1
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): You must have atleast one pair of cards")
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
    extension Collection {
        var oneAndOnly: Element? {
            return count == 1 ? first : nil
        }
}
