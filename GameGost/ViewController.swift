//
//  ViewController.swift
//  GameGost
//
//  Created by Hannah Lim on 30-09-15.
//  Copyright (c) 2015 Hannah Lim. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var namePlayer1: UITextField!
    @IBOutlet weak var namePlayer2: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func namesCorrect(sender: AnyObject) {
        Player1.name = namePlayer1.text
        Player2.name = namePlayer2.text
    }

    @IBAction func chosenLanguage(sender: UISegmentedControl) {
//        if sender.selectedSegmentIndex == 0{
//            Lexicon.language = "Dutch"
//        } else{
//            Lexicon.language = "English"
//        }
    }

}

