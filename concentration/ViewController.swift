//
//  ViewController.swift
//  concentration
//
//  Created by HuangMing on 2018/3/31.
//  Copyright © 2018年 Fruit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var concentrationGame = ConcentrationGame(numberOfPairsOfCard: (cardCollectionOutlet.count + 1) / 2)
    
    @IBOutlet weak var flipsOutlet: UILabel!
    var flipCount: Int = 0 {
        didSet {
            flipsOutlet.text = "Flips: \(flipCount)"
        }
    }
    

    
    @IBOutlet var cardCollectionOutlet: [UIButton]!
    
    
    @IBAction func tapCard(_ sender: UIButton) {
        flipCount += 1
        if let chooseCard = cardCollectionOutlet.index(of: sender) {
            concentrationGame.chooseTheCard(at: chooseCard)
            updateCardStatus()
        } else {
            print("choose Not")
        }
        
    }
    
    func updateCardStatus() {
        for index in cardCollectionOutlet.indices {
            let button = cardCollectionOutlet[index]
            let gameCard = concentrationGame.cards[index]
            if gameCard.isFaceUp {
                button.setTitle(emoji(for: gameCard), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = gameCard.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
    var emojiSetting = ["💧","🍐","🍇","🥇","🎧","🎹","🚝","💌","🚹","🚺"]
    
    var emoji = Dictionary<Int,String>()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiSetting.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiSetting.count)))
            emoji[card.identifier] = emojiSetting.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }



}

