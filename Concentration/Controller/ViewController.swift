//
//  ViewController.swift
//  Concentration
//
//  Created by Stanislav on 04.03.2019.
//  Copyright © 2019 Stanislav Kozlov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
            return (cardButtons.count + 1) / 2
    }
    private var themes: [Theme] = []
    private var currentTheme: [String] = []
    private var emoji = [Int:String]()
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var flipLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        themes.append(Theme(for: "Bodyparts", include: ["👅", "👁", "👍", "👄", "👂", "🧠"]))
        themes.append(Theme(for: "Smiles", include: ["😀", "😇", "😍", "🤬", "🤢", "🤠"]))
        themes.append(Theme(for: "Animals", include: ["🐶", "🐻", "🐭", "🦊", "🦁", "🐯"]))
        themes.append(Theme(for: "Sport", include: ["⚽️", "🏒", "🚴‍♂️", "🏉", "🏋️‍♀️", "🥊"]))
        themes.append(Theme(for: "Food", include: ["🍩" ,"🍏" ,"🥕" ,"🌶" ,"🍖" ,"🌽"]))
        themes.append(Theme(for: "Animals", include: ["🚗" ,"🚃" ,"🚦" ,"🚁" ,"✈️" ,"🏍"]))
        
        startGame()
        
    }

    @IBAction private func touchCard(_ sender: UIButton) {
        game.flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            
        }
    }
    
    
    @IBAction private func newGame(_ sender: UIButton) {
        startGame()
    }
    
    //MARK: - Start new game
    private func startGame() {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2 )
        currentTheme = themes[themes.count.arc4random].emojiTheme
        emoji = [Int:String]()
        updateViewFromModel()
    }
    
    
    // MARK: - Update view
    private func updateViewFromModel() {
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
    
    
    //define dictionary with emojis with random values from theme
    func emoji(for card: Card ) -> String{
        if emoji[card.identifier] == nil, currentTheme.count > 0 {
            emoji[card.identifier] = currentTheme.remove(at: currentTheme.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    
    
}
//MARK:  - extend Int class for getting random Int value
extension Int{
    var arc4random: Int {
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
        
    }
}
