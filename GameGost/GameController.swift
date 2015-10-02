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
    var score1 = Player1.score
    var score2 = Player2.score
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var player1score = String(stringInterpolationSegment: score1)
        var player2score = String(stringInterpolationSegment: score2)
        scorePlayer1.text = "Score " + Player1.name! + ": " + player1score
        scorePlayer2.text = "Score " + Player2.name! + ":" + player2score
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Function print who's turn it is.
    
    // Function shows score. By getting the old score from the Players class and adding it with the new score, and sending it back to the Players class.
    
    // Function show lettres form players. By getting the letters from the Players class.
    
    // Function check word. By getting the dictonairy from the Lexicon class.

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
