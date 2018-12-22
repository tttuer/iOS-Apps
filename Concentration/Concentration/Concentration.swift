//
//  Concentration.swift
//  Concentration
//
//  Created by Jayyoung Yang on 07/02/2018.
//  Copyright © 2018 Jayyoung Yang. All rights reserved.
//

import Foundation

struct Concentration{
    private(set) var cards = [Card]()
    
    private(set) var flipCount = 0
    
    private(set) var score = 0
    
    private var seenCards: Set<Int> = []
    
    struct Points {
        static let matchBonus = 2
        static let missMatchPenalty = 1
    }
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
//            let faceUpCardIndicies = cards.indices.filter { cards[$0].isFaceUp }
//            return faceUpCardIndicies == 1 ? faceUpCardIndicies.first : nil
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp  {
//                    guard foundIndex == nil else { return nil }
//                    foundIndex = index
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
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) : Choosen index out of range")
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    score += Points.matchBonus
                } else {
                    if seenCards.contains(index) {
                        score -= Points.missMatchPenalty
                    }
                    if seenCards.contains(matchIndex) {
                        score -= Points.missMatchPenalty
                    }
                    seenCards.insert(index)
                    seenCards.insert(matchIndex)
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    mutating func resetGame() {
        for index in cards.indices {
            cards[index].isMatched = false
            cards[index].isFaceUp = false
        }
        flipCount = 0
        score = 0
        seenCards = []
        shuffleCards()
    }
    
//    func chooseCard(at index: Int){
//        if !cards[index].isMatched {
//            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
//                // check if cards match
//                if cards[matchIndex].identifier == cards[index].identifier {
//                    cards[matchIndex].isMatched = true
//                    cards[index].isMatched = true
//                }
//                cards[index].isFaceUp = true
//                indexOfOneAndOnlyFaceUpCard = nil
//            } else {
//                // either no cards or 2 cards are face up
//                for flipDownIndex in cards.indices {
//                     cards[flipDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
//                indexOfOneAndOnlyFaceUpCard = index
//            }
//        }
//    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)) : You must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
//          cards.append(card)
//          cards.append(card)
        }
        //TODO : Shuffle the cards
        shuffleCards()
    }
    
    mutating func shuffleCards(){
        var copyCards = cards
        var shuffledCards = [Card]()
        
        for _ in copyCards {
            let randomIndex = Int(arc4random_uniform(UInt32(copyCards.count)))
            
            shuffledCards += [copyCards[randomIndex]]
            
            copyCards.remove(at: randomIndex)
        }
        
        cards = shuffledCards
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
