//
//  Concentration.swift
//  Concentration
//
//  Created by Stanislav on 04.03.2019.
//  Copyright © 2019 Stanislav Kozlov. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFacedUpCard: Int?
    
    var flipCount: Int
    
    var score: Int
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFacedUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    score -= 1
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFacedUpCard = nil
            } else {
                //no cards or 2 cards face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFacedUpCard = index
                
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        
        flipCount = 0
        score = 0
        
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        
        //TODO: Shuffle the cards
        var shuffleCards = [Card]()
        for _ in 0..<cards.count {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count - 1)))
            shuffleCards.append(cards.remove(at: randomIndex))
            
        }
        
        cards = shuffleCards
        
    }
}
