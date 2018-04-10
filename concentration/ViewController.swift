//
//  ViewController.swift
//  concentration
//
//  Created by HuangMing on 2018/3/31.
//  Copyright © 2018年 Fruit. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {

    private lazy var concentrationGame = ConcentrationGame(numberOfPairsOfCard: numberPairs)
    
    private var numberPairs: Int {
        return (visibleCard.count + 1) / 2
    }
    
    @IBOutlet private weak var flipsOutlet: UILabel!
    
    private(set) var flipCount: Int = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.strokeWidth: 5.0, .strokeColor: UIColor.green]
        let traitString = traitCollection.verticalSizeClass == .compact ? "Flips:\n\(flipCount)" : "Flips: \(flipCount)"
        let attributedText = NSAttributedString(string: traitString, attributes: attributes)
        flipsOutlet.attributedText = attributedText
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateFlipCountLabel()
    }

    
    @IBOutlet private var cardCollectionOutlet: [UIButton]!
    
    private var visibleCard: [UIButton]! {
        return cardCollectionOutlet?.filter{ !$0.superview!.isHidden }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCardStatus()

    }
    
    @IBAction private func tapCard(_ sender: UIButton) {
        flipCount += 1
        if let chooseCard = visibleCard.index(of: sender) {
            concentrationGame.chooseTheCard(at: chooseCard)
            updateCardStatus()
        } else {
            print("choose Not")
        }
        
    }
    
    private func updateCardStatus() {
        if visibleCard != nil {
            for index in visibleCard.indices {
                let button = visibleCard[index]
                let gameCard = concentrationGame.cards[index]
                if gameCard.isFaceUp {
                    //button.setTitle(emoji(for: gameCard), for: .normal)
                    let attributedString = NSAttributedString(string: emoji(for: gameCard), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 40)])
                    button.setAttributedTitle(attributedString, for: .normal)
                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    
                } else {
                    //button.setTitle("", for: .normal)
                    button.setAttributedTitle(nil, for: .normal)
                    button.backgroundColor = gameCard.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
                    button.isEnabled = gameCard.isMatched ? false : true
                }
            }
        }
    }
    
    var theme: String? {
        didSet {
            emojiSetting = theme ?? ""
            emoji = [:]
            updateCardStatus()
        }
    }
    private var emojiSetting = "💧🍐🍇🥇🎧🎹🚝💌🚹🚺"
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiSetting.count > 0 {
            let randomStringIndex = emojiSetting.index(emojiSetting.startIndex, offsetBy: emojiSetting.count.arc4random)
            
            emoji[card] = String(emojiSetting.remove(at: randomStringIndex))
        }
        
        return emoji[card] ?? "?"
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else  {
            return 0
        }
        
    }
}

