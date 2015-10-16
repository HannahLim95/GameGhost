//
//  MenuController.swift
//  GameGost
//
//  Created by Hannah Lim on 15-10-15.
//  Copyright (c) 2015 Hannah Lim. All rights reserved.
//  
//  Name: Hannah Lim
//  Student ID: 10588973

import UIKit

class MenuController: UIViewController {

    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // If a game is playing, performs the segue 'segueBackToGame'.
    @IBAction func goBackToGame(sender: AnyObject) {
        shouldPerformSegueWithIdentifier("segueBackToGame", sender: self)
    }
    
    // Performs segue 'segueRestartGame'
    @IBAction func resartGame(sender: AnyObject) {
        if(defaults.stringForKey("statusGame") == "gameEnded") {
            performSegueWithIdentifier("segueRestartGame", sender: self)
        } else if (defaults.stringForKey("statusGame") == "noGame") {
            performSegueWithIdentifier("segueRestartGame", sender: self)
        } else {
            shouldPerformSegueWithIdentifier("segueRestartGame", sender: self)
        }
    }
    
    // Performs segue 'segueSeeHighscore'.
    @IBAction func seeHighscore(sender: AnyObject) {
        if(defaults.stringForKey("statusGame") == "gameEnded") {
            performSegueWithIdentifier("segueSeeHighscore", sender: self)
        } else if (defaults.stringForKey("statusGame") == "noGame") {
            performSegueWithIdentifier("segueSeeHighscore", sender: self)
        } else {
            shouldPerformSegueWithIdentifier("segueSeeHighscore", sender: self)
        }
    }
    
    // If a game is playing, perfrorms segue. In another case does not perform segue.
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        if(defaults.stringForKey("statusGame") == "gamePlaying") {
            return true
        } else {
            return false
        }
    }
}
