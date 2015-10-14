//
//  GameController.swift
//  GameGost
//
//  Created by Hannah Lim on 01-10-15.
//  Copyright (c) 2015 Hannah Lim. All rights reserved.
//
//Name: Hannah Lim
//Student ID: 10588973

import UIKit

class GameController: UIViewController {

    @IBOutlet weak var labelScorePlayer1: UILabel!
    @IBOutlet weak var labelScorePlayer2: UILabel!
    @IBOutlet weak var labelTurnPlayer: UILabel!
    @IBOutlet weak var textFieldGuessLetter: UITextField!
    @IBOutlet weak var labelWordFragment: UILabel!
    @IBOutlet weak var labelTryAgain: UILabel!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    var playerTurn: String?
    var newGame : Game = Game()
    static var loser: String?
    static var winner: String?
    
    // Everytime the view is loaded the scores and the turn of the players and the letters guessed so far have to be shown.
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTurnPlayer.text = "Turn " + defaults.stringForKey("turn")!
        printScore()
        labelWordFragment.text = defaults.stringForKey("word")
        print(defaults.stringForKey("language"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This function checks if the letter guessed is a possible letter for a word or the game has ended. If it is a possible guess the next player is (switchUser())
    @IBAction func buttonCheckLetter(sender: AnyObject) {
        labelTryAgain.text = ""
        if (checkLetter() == true){
            labelWordFragment.text = newGame.word
            textFieldGuessLetter.text = ""
            newGame.addScore()
            printScore()
            newGame.getTurn()
            labelTurnPlayer.text = "Turn " + defaults.stringForKey("turn")!
        } else{
            if(textFieldGuessLetter.text != ""){
                let idx = advance(textFieldGuessLetter.text.startIndex, 0)
                var firstCharachter = textFieldGuessLetter.text[idx]
                var firstLetter = String(firstCharachter)
                if(alphabet.rangeOfString(firstLetter) == nil){
                    labelTryAgain.text = "Try again!"
                } else {
                    endGame()
                }
            } else{
                labelTryAgain.text = "Try again!"
            }
        }
    }
    
    // This function checks if the letter is a possible guess
    func checkLetter() -> Bool{
        if(textFieldGuessLetter.text != "") {
            let idx = advance(textFieldGuessLetter.text.startIndex, 0)
            var firstCharachter = textFieldGuessLetter.text[idx]
            var firstLetter = String(firstCharachter)
            if(alphabet.rangeOfString(firstLetter) != nil){
                var fistLettterLowerCase = firstLetter.lowercaseString
                newGame.guess(fistLettterLowerCase)
                if(newGame.gameEnded() == true){
                    return false
                } else{
                    return true
                }
            } else{
                return false
            }
        } else{
            return false
        }
    }

    // This function prints the scores of the players. It gets the scores from the player class. If the game is just began and so the score is 0 (nil) it has to print nil. Otherwise the score.
    func printScore(){
        var scorePlayer1 = String(stringInterpolationSegment: defaults.integerForKey("playerScore1"))
        labelScorePlayer1.text = "Score " + defaults.stringForKey("playerName1")! + ": " + scorePlayer1
        var scorePlayer2 = String(stringInterpolationSegment: defaults.integerForKey("playerScore2"))
        labelScorePlayer2.text = "Score " + defaults.stringForKey("playerName2")! + ": " + scorePlayer2
    }
    
    func getWinner() -> Bool {
        if(defaults.stringForKey("turn") == Player.name1){
            return true
        } else{
            return false
        }
    }
    
    func endGame(){
        if(newGame.getWinner() == true){
            GameController.loser = Player.name1
            GameController.winner = Player.name2
        } else{
            GameController.loser = Player.name2
            GameController.winner = Player.name1
        }
        defaults.setObject("gameEnded", forKey: "statusGame")
        performSegueWithIdentifier("segueToWinnerLoser", sender: self)
    }
}
