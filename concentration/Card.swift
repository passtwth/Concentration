//
//  Card.swift
//  concentration
//
//  Created by HuangMing on 2018/3/31.
//  Copyright © 2018年 Fruit. All rights reserved.
//

import Foundation

struct Card: Hashable {
    var hashValue: Int {
        return identifier
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var doIdentifier = 0
    private static func uniqueIdentifier() -> Int {
        doIdentifier += 1
        return doIdentifier
    }
    
    init() {
        self.identifier = Card.uniqueIdentifier()
    }
}
