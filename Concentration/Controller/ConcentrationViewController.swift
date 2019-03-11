//
//  ViewController.swift
//  Concentration
//
//  Created by Stanislav on 04.03.2019.
//  Copyright © 2019 Stanislav Kozlov. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {

    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
            return (cardButtons.count + 1) / 2
    }
    private var currentTheme: String = "😈👺🎃👿☠️👽🤖"
    private var emoji = [Card:String]()
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var flipLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//
//        startGame()
//
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
        updateViewFromModel()
    }
    
    
    // MARK: - Update view
    private func updateViewFromModel() {
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: .normal)
                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    
                } else {
                    button.setTitle("", for: .normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                }
            }
            updateFlipCountLabel()
            scoreLabel.text = "Score: \(game.score)"
        }
    }
    
    private func updateFlipCountLabel () {
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.strokeWidth : 5.0,
            NSAttributedString.Key.strokeColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips :\(game.flipCount)", attributes: attributes)
        flipLabel.attributedText = attributedString
    }
    
    
    var theme: String? {
        didSet {
            currentTheme = theme ?? ""
            emoji = [ : ]
            updateViewFromModel()
        }
    }
    //define dictionary with emojis with random values from theme
    func emoji(for card: Card ) -> String{
        if emoji[card] == nil, currentTheme.count > 0 {
            let randomStringIndex = currentTheme.index(currentTheme.startIndex, offsetBy: currentTheme.count.arc4random)
            emoji[card] = String(currentTheme.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
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
