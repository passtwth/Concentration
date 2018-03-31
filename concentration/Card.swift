//
//  Card.swift
//  concentration
//
//  Created by HuangMing on 2018/3/31.
//  Copyright © 2018年 Fruit. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var doIdentifier = 0
    static func uniqueIdentifier() -> Int {
        doIdentifier += 1
        return doIdentifier
    }
    
    init() {
        self.identifier = Card.uniqueIdentifier()
    }
}
