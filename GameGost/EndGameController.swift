//
//  EndGameController.swift
//  GameGost
//
//  Created by Hannah Lim on 12-10-15.
//  Copyright (c) 2015 Hannah Lim. All rights reserved.
//

import UIKit

class EndGameController: UIViewController {
    @IBOutlet weak var labelWinner: UILabel!
    @IBOutlet weak var labelLoser: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        labelWinner.text = "The winner is " + GameController.winner!
        labelLoser.text = "The loser is " +  GameController.loser!

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
