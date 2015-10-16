//
//  HighscoreController.swift
//  GameGost
//
//  Created by Hannah Lim on 12-10-15.
//  Copyright (c) 2015 Hannah Lim. All rights reserved.
//
//  Name: Hannah Lim
//  Student ID: 10588973

import UIKit

class HighscoreController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableViewHighscore: UITableView!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // If the status of the game is 'gameEnded', makes the new highscore and set the status game to 'noGame'.
        if(defaults.stringForKey("statusGame") == "gameEnded") {
            makeHighscore()
            defaults.setObject("noGame", forKey: "statusGame")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Adds the scores from the current players to the highscore list.
    func makeHighscore() {
        if(defaults.dictionaryForKey("highscore") == nil) {
            let firstHighscore: Dictionary<String, Int> = [defaults.stringForKey("playerName1")! : defaults.integerForKey("playerScore1"), defaults.stringForKey("playerName2")! : defaults.integerForKey("playerScore2")]
            defaults.setObject(firstHighscore, forKey: "highscore")
        } else {
            var allHighscores = defaults.dictionaryForKey("highscore")! as! Dictionary<String, Int>
        println("errornietdaar")
            allHighscores[defaults.stringForKey("playerName1")!] = defaults.integerForKey("playerScore1")
            allHighscores[defaults.stringForKey("playerName1")!] = defaults.integerForKey("playerScore1")
            defaults.setObject(allHighscores, forKey: "highscore")
        }
    }
    
    // Count the rows necessary in the tableview depending on the count of highscores in the highscore list.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(defaults.dictionaryForKey("highscore")?.count == nil){
            return 0
        } else{
            return defaults.dictionaryForKey("highscore")!.count
        }
    }
    
    // Returns the tableview with the highscore of all the players ever played.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("chaos")
        // Gets cell in the tableview.
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        // Sort the highscore list from highest to lowest score.
        var listHighscores = defaults.dictionaryForKey("highscore")!
        let sortedHighscoreList = (listHighscores as NSDictionary).keysSortedByValueUsingSelector("compare:")
        var highscoreListHighToLow = sortedHighscoreList.reverse()
        var namesForHighscores = highscoreListHighToLow[indexPath.row] as! String
        
        // Sets the cell with name and highscore.
        cell.textLabel!.text = namesForHighscores
        var scoreForHighscore = String(stringInterpolationSegment: defaults.dictionaryForKey("highscore")![namesForHighscores]!)
        cell.detailTextLabel?.text = scoreForHighscore
        return cell
    }
    
    // If 'Menu' is pressed by the players and a game is playing, perform segue 'segueFromHighscoreToMenu'. In another case perform segue 'segueFromHighscoreToStart'.
    @IBAction func buttonGetOutHighscore(sender: AnyObject) {
        if(defaults.stringForKey("statusGame") == "playingGame") {
            performSegueWithIdentifier("segueFromHighscoreToMenu", sender: self)
        } else {
            performSegueWithIdentifier("segueFromHighscoreToStart", sender: self)
        }
    }
}
