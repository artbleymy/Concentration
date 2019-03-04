//
//  ViewController.swift
//  Concentration
//
//  Created by Stanislav on 04.03.2019.
//  Copyright © 2019 Stanislav Kozlov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2 )
    var themes: [Theme] = []
    var currentThemeIndex: Int = 0
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flipLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        themes.append(Theme(for: "Bodyparts", include: ["👅", "👁", "👍", "👄", "👂", "🧠"]))
        themes.append(Theme(for: "Smiles", include: ["😀", "😇", "😍", "🤬", "🤢", "🤠"]))
        themes.append(Theme(for: "Animals", include: ["🐶", "🐻", "🐭", "🦊", "🦁", "🐯"]))
        themes.append(Theme(for: "Sport", include: ["⚽️", "🏒", "🚴‍♂️", "🏉", "🏋️‍♀️", "🥊"]))
        themes.append(Theme(for: "Food", include: ["🍩" ,"🍏" ,"🥕" ,"🌶" ,"🍖" ,"🌽"]))
        themes.append(Theme(for: "Animals", include: ["🚗" ,"🚃" ,"🚦" ,"🚁" ,"✈️" ,"🏍"]))
        
        
    }

    @IBAction func touchCard(_ sender: UIButton) {
        game.flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            
        }
    }
    
    
    @IBAction func newGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2 )
        currentThemeIndex = Int(arc4random_uniform(UInt32(themes.count)))
        emoji = [Int:String]()
        updateViewFromModel()
    }
    
    // MARK: - Update view
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
        flipLabel.text = "Flips :\(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
    }
    
    var emoji = [Int:String]()
    //define dictionary with emojis with random values from theme
    func emoji(for card: Card ) -> String{
        if emoji[card.identifier] == nil, themes[currentThemeIndex].emojiTheme.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(themes[currentThemeIndex].emojiTheme.count)))
            emoji[card.identifier] = themes[currentThemeIndex].emojiTheme.remove(at: randomIndex)
            
        }
        return emoji[card.identifier] ?? "?"
    }
}

