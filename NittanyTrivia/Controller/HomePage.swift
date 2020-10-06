//
//  HomePage.swift
//  NittanyTrivia
//
//  Created by Shahzeb Ahmed on 7/25/20.
//  Copyright © 2020 Shahzeb Ahmed. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn



class HomePage: UIViewController {
let appDelegate = UIApplication.shared.delegate as! AppDelegate//creates a delegate of the UIapplication and downcasts it to be of type AppDelegate which will allow access to google sign in info variables in the appdelegate class.
    
    
    @IBOutlet weak var competeButton: UIButton!
    @IBOutlet weak var survivalButton: UIButton!
    @IBOutlet weak var coinsLabel: UIButton!
    @IBOutlet weak var livesLabel: UIButton!
    
    @IBOutlet weak var gamesLogTable: UITableView!
    
    override func viewDidLoad() {
        
        UserDefaults.standard.setValue(appDelegate.email, forKey: "email")
        getGameLogs()//this function is located in game.swift and modifies currentUserGameLogs
        gamesLogTable.dataSource = self

        
        super.viewDidLoad()
        navigationItem.hidesBackButton = true


        competeButton.layer.cornerRadius = 40
        survivalButton.layer.cornerRadius = 40
        
        
        coinsLabel.titleLabel?.numberOfLines = 1
        coinsLabel.titleLabel?.adjustsFontSizeToFitWidth = true
        coinsLabel.titleLabel?.minimumScaleFactor = 0.5
        coinsLabel.isHidden = true
        livesLabel.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.gamesLogTable.isHidden = false
        }
    
    }//viewDidLoad
    
    

    @IBAction func cancelGamesLogTable(_ sender: UIButton) {
        gamesLogTable.isHidden = true
        //gamesLogDelete
    }
    
    @IBAction func leaderboardPressed(_ sender: UIButton) {
        sender.tintColor = UIColor.gray
    }
    
    @IBAction func storePressed(_ sender: UIButton) {
        
    }
    
    @IBAction func homePressed(_ sender: UIButton) {
    }
    
    @IBAction func helpPagePressed(_ sender: UIButton){
    }
    

    
  
}
extension HomePage: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currentUserGameLogs = currentUserGameLogs{
            return currentUserGameLogs.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameLog")
        
        
        let gameLog = currentUserGameLogs?[indexPath.row]
        let enemyScore = gameLog?["enemyQuestionsAnswered"] as! Int
        let userScore = gameLog?["questionsAnswered"] as! Int
        if (enemyScore >  userScore){
            cell?.textLabel?.textColor = UIColor.red
            cell?.textLabel?.text = "You lost by " + String(enemyScore - userScore) + " points"
        }
        else if(userScore > enemyScore){
            cell?.textLabel?.textColor = UIColor.green
            cell?.textLabel?.text = "You won by " + String(userScore - enemyScore) + " points"
        }
        else{
            cell?.textLabel?.textColor = UIColor.gray
            cell?.textLabel?.text = "You drew by scoring: " + String(userScore) + " points"

        }
        return cell!
    }
    
    
}

