//
//  ViewController.swift
//  Concentration
//
//  Created by Karel Smejkal on 6/12/18.
//  Copyright © 2018 Karel Smejkal. All rights reserved.
///Users/karelsmejkal/Developer/Concentration/Concentration/Base.lproj/Main.storyboard

import UIKit

class ViewController: UIViewController {
    
    //number of pairs in game ---> private
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    // computed propety - read only, I dont mind someone ask for number of paris, but not let them set it
    var numberOfPairsOfCards: Int {
        return ((cardButtons.count + 1) / 2)
    }
    
    //    private let emojiTheme = [
    //        ["🦇","🐶","🐨","🐊","🐳","🦖","🐼","🐜","🦈","🐯"], //animals
    //        ["🍭","🍪","🍩","🍿","🍫","🍬","🍮","🍰","🍦","🌰"], //sweets
    //        ["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏒"], //sports
    //        ["🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐"], //vehicles
    //        ["📱","💻","🖥","📷","📀","🕹","🖱","⌚️","🎥","📞"], //tech
    //        ["🇨🇿","🇦🇺","🇩🇪","🇧🇷","🇺🇸","🇪🇸","🇨🇭","🇫🇷","🇬🇧","🇲🇽"] //countries
    //    ]
    private let emojiTheme = [
        "🦇🐶🐨🐊🐳🦖🐼🐜🦈🐯", //animals
        "🍭🍪🍩🍿🍫🍬🍮🍰🍦🌰", //sweets
        "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓🏒", //sports
        "🚗🚕🚙🚌🚎🏎🚓🚑🚒🚐", //vehicles
        "📱💻🖥📷📀🕹🖱⌚️🎥📞", //tech
        "🇨🇿🇦🇺🇩🇪🇧🇷🇺🇸🇪🇸🇨🇭🇫🇷🇬🇧🇲🇽" //countries
    ]
    private lazy var emojiChoices = emojiTheme[Int(arc4random_uniform(UInt32(emojiTheme.count)))]
    private var emoji = [Card: String]()
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    {
        didSet{
            updateFlipCountLabel()
        }
    }
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var scoreCountLabel: UILabel!{
        didSet{
            updateScoreCountLabel()
        }
    }
    
    // very important to learn use Optionals (?,!) or use if ---> checking for nil value
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in CardButtons")
        }
    }
    
    private func updateFlipCountLabel(){
        let attributes: [NSAttributedStringKey: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)",
            attributes: attributes)
        
        flipCountLabel.attributedText = attributedString
    }
    
    private func updateScoreCountLabel(){
        let attributes: [NSAttributedStringKey: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Score: \(game.scoreCount)",
            attributes: attributes)
        
        scoreCountLabel.attributedText = attributedString
    }
    
    @IBAction private func beginNewGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        updateTheme()
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        //indicies countable range in array
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        updateFlipCountLabel()
        updateScoreCountLabel()
    }
    
    private func updateTheme() {
        emojiChoices = emojiTheme[Int(arc4random_uniform(UInt32(emojiTheme.count)))]
    }
    
    private func emoji(for card: Card) -> String {
        //can separate if by , in between
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomIndex))
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return  -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
        
    }
}
