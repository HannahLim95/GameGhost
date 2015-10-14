//
//  Game.swift
//  GameGost
//
//  Created by Hannah Lim on 02-10-15.
//  Copyright (c) 2015 Hannah Lim. All rights reserved.
//
//Name: Hannah Lim
//Student ID: 10588973

import Foundation

class Game{
//    var turn: String?
    var word = ""
    var gameEnd = false
    var languageDutch: Lexicon = Lexicon(language: "dutch")
    var languageEnglish: Lexicon = Lexicon(language: "english")
    var newLexicon : Lexicon = Lexicon(language: Lexicon.chosenLanguage!)
    
    let defaults = NSUserDefaults.standardUserDefaults()
    // method guess, this method takes a string as input, representing the letter that the current player has guessed. It uses the Lexicon instance to decide
    func guess(guessedLetter: String){
        word = defaults.stringForKey("word")!
        word += guessedLetter
        if(defaults.stringForKey("language") == "dutch"){
            self.languageDutch.filter(word)
        } else{
            self.languageEnglish.filter(word)
        }
        defaults.setObject(word, forKey: "word")
        if(newLexicon.count() == 1){
            newLexicon.result()
        }
    }
    
    // method turn, this method returns a boolean indicating which player is up for guessing.
    func getTurn() {
        if(defaults.stringForKey("turn") == defaults.stringForKey("playerName1")){
            defaults.setObject(Player.name2, forKey: "turn")
//            turn = defaults.stringForKey("turn")!
        } else {
            defaults.setObject(Player.name1, forKey: "turn")
//            turn = defaults.stringForKey("turn")!
        }
    }

    func addScore(){
        if(defaults.stringForKey("turn") == Player.name1){
            Player.score1 += 10
        } else{
            Player.score2 += 10
        }
        defaults.setObject(Player.score1, forKey: "playerScore1")
        defaults.setObject(Player.score2, forKey: "playerScore2")
    }
    
    // method ended, this method returns a boolean indicating if the game has ended.
    func gameEnded() -> Bool {
        if(defaults.stringForKey("language") == "dutch"){
            if(self.languageDutch.count() == 0){
                return true
            }
            else{
                return false
            }
                // als het een volledig woord is ook true teruggeven
        } else{
            if(self.languageEnglish.count() == 0){
                return true
            } else{
                return false
            }
        }
    }

    // method winner, this method returns a boolean indicating which player has won the game. This method can obviously only make sense if ended returns true.
    func getWinner() -> Bool {
        findCauseWinner()
        if(defaults.stringForKey("turn") == Player.name1){
            return true
        } else{
            return false
        }
    }
    
    func findCauseWinner(){

        
        
        
    }
    
    

    
}