//
//  GameController.swift
//  GameGost
//
//  Created by Hannah Lim on 01-10-15.
//  Copyright (c) 2015 Hannah Lim. All rights reserved.
//

import UIKit

class GameController: UIViewController {

    @IBOutlet weak var scorePlayer1: UILabel!
    @IBOutlet weak var scorePlayer2: UILabel!
    @IBOutlet weak var labelTurnPlayer: UILabel!
    @IBOutlet weak var guessedWord: UITextField!
    @IBOutlet weak var guessedWordSoFar: UILabel!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    var score1 = Player.score1
    var score2 = Player.score2
    var playerTurn: String?
    var newGame : Game = Game()
    static var loser: String?
    static var winner: String?
    
    // Everytime the view is loaded the scores and the turn of the players and the letters guessed so far have to be shown.
    override func viewDidLoad() {
        super.viewDidLoad()
        printScore()
        playerTurn = defaults.stringForKey("turn")
        labelTurnPlayer.text = "Turn " + playerTurn!
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This function prints the scores of the players. It gets the scores from the player class. If the game is just began and so the score is 0 (nil) it has to print nil. Otherwise the score.
    func printScore(){
        var player1score = String(stringInterpolationSegment: score1)
        scorePlayer1.text = "Score " + Player.name1! + ": " + player1score
        var player2score = String(stringInterpolationSegment: score2)
        scorePlayer2.text = "Score " + Player.name2! + ": " + player2score
    }
    
    // This function checks if the letter guessed is a possible letter for a word or the game has ended. If it is a possible guess the next player is (switchUser())
    @IBAction func buttonCheckLetter(sender: AnyObject) {
        if (checkLetter() == true){
            guessedWordSoFar.text = newGame.word
            addScore()
            print(score1)
            switchUser()
            printScore()
        } else{
            endGame()
        }
    }
    
    func endGame(){
        print("end game")
        if(playerTurn == Player.name1){
            GameController.loser = Player.name1
            GameController.winner = Player.name2
        } else{
            GameController.loser = Player.name2
            GameController.winner = Player.name1
        }
        performSegueWithIdentifier("segueToWinnerLoser", sender: self)
    }
        
    // This function checks if the letter is a possible guess
    func checkLetter() -> Bool{
        var test = guessedWord.text
        let idx = advance(test.startIndex, 0)
        var firstCharachter = test[idx]
        var firstLetter = String(firstCharachter)
        if alphabet.rangeOfString(firstLetter) != nil {
            println("yes")
            newGame.guess(firstLetter)
            if(Lexicon.chosenLanguage == "dutch"){
                if(newGame.languageDutch.dutchLexicon.count == 0){
                    return false
                } else{
                    return true
                }
            } else {
                if(newGame.languageEnglish.englishLexicon.count == 0){
                    return false
                }else {
                    return true
                }
            }
        } else{
            print("tryagain")
            return true
        }
    }
    
    func addScore(){
        if(playerTurn == Player.name1){
            score1 += 10
            Player.score1 += 10
        } else{
            score2 += 10
            Player.score2 += 10
        }
    }
    
    // This function switches the text with the person who's turn it is.
    func switchUser(){
        if(playerTurn == Player.name1){
            playerTurn = Player.name2
        } else{
            playerTurn = Player.name1
        }
        labelTurnPlayer.text = "Turn " + playerTurn!
        var turnPlayer = playerTurn
        defaults.setObject(turnPlayer!, forKey: "turn")
    }
}
