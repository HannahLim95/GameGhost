//
//  Player1.swift
//  GameGost
//
//  Created by Hannah Lim on 01-10-15.
//  Copyright (c) 2015 Hannah Lim. All rights reserved.
//
//Name: Hannah Lim
//Student ID: 10588973

import Foundation

class Player{
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    // Name and score from player 1
    static var name1: String?
    static var score1 = 0
    
    // Name and score from player 2
    static var name2: String?
    static var score2 = 0
    
    func setName(){
        defaults.setObject(Player.name1, forKey:"playerName1")
        defaults.setObject(Player.name2, forKey: "playerName2")
    }
    
    func setScore(){
        defaults.setObject(Player.score1, forKey: "playerScore1")
        defaults.setObject(Player.score2, forKey: "playerScore2")
    }
}


