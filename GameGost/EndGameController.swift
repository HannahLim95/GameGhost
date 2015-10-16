//
//  EndGameController.swift
//  GameGost
//
//  Created by Hannah Lim on 12-10-15.
//  Copyright (c) 2015 Hannah Lim. All rights reserved.
//
//  Name: Hannah Lim
//  Student ID: 10588973

import UIKit

class EndGameController: UIViewController {
    @IBOutlet weak var labelWinner: UILabel!
    @IBOutlet weak var labelLoser: UILabel!
    
let defaults = NSUserDefaults.standardUserDefaults()
    
    // Shows the labels with the winner and the loser and the cause why the game is ended. 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelWinner.text = "Congratiolations " + GameController.winner! + "! You are the winner. " + defaults.stringForKey("causeGameEnded")!
        labelLoser.text = "I'm sorry " +  GameController.loser! + ". You lost.."
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
