//
//  ViewController.swift
//  Concentration
//
//  Created by Karel Smejkal on 6/12/18.
//  Copyright © 2018 Karel Smejkal. All rights reserved.
///Users/karelsmejkal/Developer/Concentration/Concentration/Base.lproj/Main.storyboard

import UIKit

class ViewController: UIViewController {

    // swift is strongly type language -> everything has to have type, altough it can guess type
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices: Array<String> = ["👻","🎃","👻","🎃"]
    
    // very important to learn use Optionals (?,!) or use if ---> checking for nil value
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        } else {
            print("Chosen card was not in CardButtons")
        }
        
    }
    

    //write code as you would read it in english --> no.1 requirement
    //func name(external var, internal var, return type)
    func flipCard(withEmoji emoji: String, on button: UIButton){
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
        }
    }
    
    
}

