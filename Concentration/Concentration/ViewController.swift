//
//  ViewController.swift
//  Concentration
//
//  Created by Karel Smejkal on 6/12/18.
//  Copyright © 2018 Karel Smejkal. All rights reserved.
///Users/karelsmejkal/Developer/Concentration/Concentration/Base.lproj/Main.storyboard

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    // computed propety - read only
    var numberOfPairsOfCards: Int {
        get {
            return (cardButtons.count + 1 / 2)
        }
    }
    
    let emojiTheme = [
        ["🦇","🐶","🐨","🐊","🐳","🦖","🐼","🐜","🦈","🐯"], //animals
        ["🍭","🍪","🍩","🍿","🍫","🍬","🍮","🍰","🍦","🌰"], //sweets
        ["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏒"], //sports
        ["🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐"], //vehicles
        ["📱","💻","🖥","📷","📀","🕹","🖱","⌚️","🎥","📞"], //tech
        ["🇨🇿","🇦🇺","🇩🇪","🇧🇷","🇺🇸","🇪🇸","🇨🇭","🇫🇷","🇬🇧","🇲🇽"] //countries
    ]
    lazy var emojiChoices = emojiTheme[Int(arc4random_uniform(UInt32(emojiTheme.count)))]
    var emoji = [Int: String]()
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // very important to learn use Optionals (?,!) or use if ---> checking for nil value
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in CardButtons")
        }
    }
    
    @IBAction func beginNewGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateTheme()
        updateViewFromModel()
    }
    
    
    func updateViewFromModel() {
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
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.scoreCount)"
    }
    
    func updateTheme() {
        emojiChoices = emojiTheme[Int(arc4random_uniform(UInt32(emojiTheme.count)))]
    }
    
    func emoji(for card: Card) -> String {
        //can separate if by , in between
        if emoji[card.indentifier] == nil, emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.indentifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.indentifier] ?? "?"
    }
}

