//
//  Game.swift
//  GameGost
//
//  Created by Hannah Lim on 02-10-15.
//  Copyright (c) 2015 Hannah Lim. All rights reserved.
//
//  Name: Hannah Lim
//  Student ID: 10588973

import Foundation

class Game{
    let defaults = NSUserDefaults.standardUserDefaults()
    var word = ""
    
    var dutchLexicon: Lexicon = Lexicon(language: "dutch")
    var englishLexicon: Lexicon = Lexicon(language: "english")
    
    var alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    var firstLetterLowerCase = ""
    
    // Resets the scores of the players and sets the word to an empty string.
    func resetGame() {
        defaults.setObject(0, forKey: "playerScore1")
        defaults.setObject(0, forKey: "playerScore2")
        defaults.setObject("", forKey: "word")
    }
    
    // Plays the game of one turn and gets as input the guess from the player.
    func playGame(guessPlayer: String) {
        // If the guess is a correct letter, looks if the guess leads to a win or lose.
        if(checkIfLetter(guessPlayer) == true) {
            guess(firstLetterLowerCase)
            
            // If the game is not ended, adds the score to the player who has guessed and gets the turn of the next player. If the game is ended, sets the status of the game to 'gameEnded' and gets te winner and loser of the game.
            checkGameEnded()
            if(defaults.stringForKey("statusGame") != "gameEnded"){
                addScore()
                getTurn()
            } else {
                gameEnded()
            }
        }
    }
    
    // Checks if the first character of the string in the input is a letter and returns a boolean if the guess is a letter or not.
    func checkIfLetter(guessPlayer: String) ->  Bool {
        // The guess can not be an empty string.
        if(guessPlayer != "") {
            // Gets the first character of the entered guess and sets it to a string.
            let indexFirstCharacter = advance(guessPlayer.startIndex, 0)
            var firstCharachter = guessPlayer[indexFirstCharacter]
            var firstCharacterString = String(firstCharachter)
            
            // Checks if the first character is a member of the alphabet.
            if(alphabet.rangeOfString(firstCharacterString) != nil){
                firstLetterLowerCase = firstCharacterString.lowercaseString
                return true
            } else {
                return false
            }
            
        } else {
            return false
        }
    }
    
    
    // Checks if the letter is a valid guess.
    func guess(guessedLetter: String) {
        // Adds the guessed letter to the word guessed so far.
        word = defaults.stringForKey("word")!
        word += guessedLetter
        defaults.setObject(word, forKey: "word")
        
        // Runs through the lexicon to filter the lexicon depending on the word guessed so far.
        if(defaults.stringForKey("language") == "dutch") {
            dutchLexicon.filter(word)
        } else {
            englishLexicon.filter(word)
        }
    }
    
    // Checks if the game is finished and returns a boolean true if the game is ended. Otherwise it returns true.
    func checkGameEnded() {
        if(defaults.stringForKey("language") == "dutch") {
            checkGameEnded2(dutchLexicon)
        } else {
            checkGameEnded2(englishLexicon)
        }
    }
    
    func checkGameEnded2 (lexicon : Lexicon) {
        // Counts the words left in the lexicon and matches it to the status of the game.
        if(lexicon.count() == 0) {
            defaults.setObject("Because a wrong letter was entered", forKey: "causeGameEnded")
            defaults.setObject("gameEnded", forKey: "statusGame")
        } else if(lexicon.count() == 1) {
            var wordGuessedToLose = lexicon.result()
            defaults.setObject("Because a word is guessed", forKey: "causeGameEnded")
            defaults.setObject("gameEnded", forKey: "statusGame")
        }
    }
    
    // Adds points to the player who entered a guess.
    func addScore() {
        if(defaults.stringForKey("turn") == defaults.stringForKey("playerName1")) {
            var playerScore1 = defaults.integerForKey("playerScore1")
            playerScore1 += 10
            defaults.setObject(playerScore1, forKey: "playerScore1")
        } else {
            var playerScore2 = defaults.integerForKey("playerScore2")
            playerScore2 += 10
            defaults.setObject(playerScore2, forKey: "playerScore2")
        }
    }
    
    // Sets the turn from the player.
    func getTurn() {
        if(defaults.stringForKey("turn") == defaults.stringForKey("playerName1")) {
            defaults.setObject(defaults.stringForKey("playerName2"), forKey: "turn")
        } else {
            defaults.setObject(defaults.stringForKey("playerName1"), forKey: "turn")
        }
    }
    
    func gameEnded() {
        if(getWinnerAndLoser() == true){
            GameController.loser = defaults.stringForKey("playerName1")!
            GameController.winner = defaults.stringForKey("playerName2")!
        } else{
            GameController.loser = defaults.stringForKey("playerName2")!
            GameController.winner = defaults.stringForKey("playerName1")!
        }
    }
    
    // Returns a boolean indicating which player has won the game.
    func getWinnerAndLoser() -> Bool {
        if(defaults.stringForKey("turn") == defaults.stringForKey("playerName1")!) {
            return true
        } else {
            return false
        }
    }
}