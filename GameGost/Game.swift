//
//  Game.swift
//  GameGost
//
//  Created by Hannah Lim on 02-10-15.
//  Copyright (c) 2015 Hannah Lim. All rights reserved.
//

import Foundation

class Game{
    
    var turn: String?
    var word = ""
    var gameEnd = false
    var languageDutch: Lexicon = Lexicon(language: "dutch")
    var languageEnglish: Lexicon = Lexicon(language: "english")
    
    // method guess, this method takes a string as input, representing the letter that the current player has guessed. It uses the Lexicon instance to decide
    func guess(guessedLetter: String){
        word += guessedLetter
        if(Lexicon.chosenLanguage == "dutch"){
            self.languageDutch.filter(word)
        } else{
            self.languageEnglish.filter(word)
        }
    }
    
    // method turn, this method returns a boolean indicating which player is up for guessing.
    func getTurn() {
        if(turn == "player1"){
            turn = "player2"
        } else {
            turn = "player1"
        }
    }
    
    // method ended, this method returns a boolean indicating if the game has ended.
    func gameEnded() -> Bool {
        if(Lexicon.chosenLanguage == "dutch"){
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
        if(turn == "player1"){
            return true
        } else{
            return false
        }
    }

}