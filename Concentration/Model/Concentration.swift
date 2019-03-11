//
//  Concentration.swift
//  Concentration
//
//  Created by Stanislav on 04.03.2019.
//  Copyright © 2019 Stanislav Kozlov. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFacedUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp  }.oneAndOnly
//
//            var foundIndex: Int?
//            for index in cards.indices{
//                if cards[index].isFaceUp{
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    var flipCount: Int = 0
    
    private(set) var score: Int = 0
    
    mutating func chooseCard(at index: Int){
        
        assert(cards.indices.contains(index),"Concentration.chooseCard(as:\(index)):chosen index not in the card")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFacedUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    score -= 1
                }
                cards[index].isFaceUp = true
            } else {
                //no cards or 2 cards face up
                indexOfOneAndOnlyFacedUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        
        
        assert(numberOfPairsOfCards > 0, "Concentration.chooseCard(as:\(numberOfPairsOfCards)):you must have at least one pair of cards")
        
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

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
