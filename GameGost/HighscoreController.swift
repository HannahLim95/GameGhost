//
//  HighscoreController.swift
//  GameGost
//
//  Created by Hannah Lim on 12-10-15.
//  Copyright (c) 2015 Hannah Lim. All rights reserved.
//

import UIKit

class HighscoreController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let defaults = NSUserDefaults.standardUserDefaults()
    @IBOutlet weak var tableViewHighscore: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewHighscore.registerClass(UITableViewCell.self, forCellReuseIdentifier:"cell")
        self.tableViewHighscore.dataSource = self
        makeHighscore()

        // Do any additional setup after loading the view.
    }
    
    func makeHighscore(){
        if(defaults.dictionaryForKey("highscore") == nil){
            let firstHighscore: Dictionary<String, Int> = [Player.name1! : Player.score1, Player.name2! : Player.score2]
            defaults.setObject(firstHighscore, forKey: "highscore")
            var test = defaults.dictionaryForKey("highscore")
        } else{
            var allHighscores = defaults.dictionaryForKey("highscore")! as! Dictionary<String, Int>
            print(allHighscores)
            //allHighscores[Player.name1!] = Player.score1
            //allHighscores[Player.name2!] = Player.score2
            defaults.setObject(allHighscores, forKey: "highscore")
            var test2 = defaults.dictionaryForKey("highscore")
            print(test2)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaults.dictionaryForKey("highscore")!.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableViewHighscore.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        var listHighscores = defaults.dictionaryForKey("highscore")! as! Dictionary<String, String>
        //var takeHighscore = listHighscores[indexPath.row] as String
        //cell.textLabel!.text = takeHighscore
        return cell
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
