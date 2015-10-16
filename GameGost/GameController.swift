//
//  GameController.swift
//  GameGost
//
//  Created by Hannah Lim on 01-10-15.
//  Copyright (c) 2015 Hannah Lim. All rights reserved.
//
//  Name: Hannah Lim
//  Student ID: 10588973

import UIKit

class GameController: UIViewController {

    @IBOutlet weak var labelScorePlayer1: UILabel!
    @IBOutlet weak var labelScorePlayer2: UILabel!
    @IBOutlet weak var labelTurnPlayer: UILabel!
    @IBOutlet weak var textFieldGuessLetter: UITextField!
    @IBOutlet weak var labelWordFragment: UILabel!
    @IBOutlet weak var labelTryAgain: UILabel!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var newGame : Game = Game()
    static var loser: String?
    static var winner: String?
    
    // When the view is loaded shows the turn and the scores of the players and the word that is guessed so far.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets view depending if the keyboard is shown or hiden.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
        
        labelTurnPlayer.text = "Turn " + defaults.stringForKey("turn")! 
        printScore()
        labelWordFragment.text = defaults.stringForKey("word")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Sets view if keyboard is shwon.
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y -= keyboardSize.height
        }
    }
    
    // Sets view if keyboard is hidden.
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y += keyboardSize.height
        }
    }
    
    // If button 'OK' is pressed by a player, checks if the entered guess by the player is a valid guess. If it is a valid guess, the game goes on. If it is not a valid guess the game is ended.
    @IBAction func buttonCheckLetter(sender: AnyObject) {
        // Checks the entered guess.
        newGame.playGame(textFieldGuessLetter.text)
        
        // Sets the textfield where the player can enter a guess to an empty string.
        textFieldGuessLetter.text = ""
        
        // Prints the turn and the scores of the players and the word guessed so far.
        labelTurnPlayer.text = "Turn " + defaults.stringForKey("turn")!
        printScore()
        labelWordFragment.text = defaults.stringForKey("word")
        
        // If the status of the game is 'gameEnded', performs a segue to the winner screen.
        if(defaults.stringForKey("statusGame") == "gameEnded") {
            performSegueWithIdentifier("segueToWinnerLoser", sender: self)
        }
    }

    // Prints the scores of the players.
    func printScore() {
        // Sets the scores that are integers to a string.
        var scorePlayer1 = String(stringInterpolationSegment: defaults.integerForKey("playerScore1"))
        var scorePlayer2 = String(stringInterpolationSegment: defaults.integerForKey("playerScore2"))
        
        // Changes the label with the scores to the new scores. 
        labelScorePlayer1.text = "Score " + defaults.stringForKey("playerName1")! + ": " + scorePlayer1
        labelScorePlayer2.text = "Score " + defaults.stringForKey("playerName2")! + ": " + scorePlayer2
    }
}
