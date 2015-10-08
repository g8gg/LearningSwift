//
//  Player.swift
//  Ratings
//
//  Created by freeda.ma on 15/10/8.
//  Copyright © 2015年 FPSS 1999-2015. All rights reserved.
//

import Foundation

struct Player {
    var name: String?
    var game: String?
    var rating: Int
    
    init(name: String?, game: String?, rating: Int) {
        self.name = name
        self.game = game
        self.rating = rating
    }
}