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
    @IBOutlet weak var gamesLogView: UIView!
    
    override func viewDidLoad() {
        
        UserDefaults.standard.setValue(appDelegate.email, forKey: "email")
        getGameLogs()//this function is located in game.swift and modifies currentUserGameLogs and is located within game.swift file
        gamesLogView.isHidden = true
        
        
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
        
            

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            if  currentUserGameLogs != nil && currentUserGameLogs != []{
                self.gamesLogTable.reloadData()
                self.gamesLogView.isHidden = false
            }
           
        })
            
        
       
    
    }//viewDidLoad
    
    
    @IBAction func competeButtonPressed(_ sender: Any) {
        deleteGameLogs()
    }
    
    @IBAction func survivalButtonPressed(_ sender: Any) {
        deleteGameLogs()
    }
    @IBAction func cancelGamesLogTable(_ sender: UIButton) {
        gamesLogView.isHidden = true
        deleteGameLogs()
        
    }
    
    @IBAction func leaderboardPressed(_ sender: UIButton) {
        if  currentUserGameLogs != nil && currentUserGameLogs != []{
            deleteGameLogs()
        }
        sender.tintColor = UIColor.gray
    }
    
    @IBAction func storePressed(_ sender: UIButton) {
        if  currentUserGameLogs != nil && currentUserGameLogs != []{
            deleteGameLogs()
        }
    }
    
    @IBAction func homePressed(_ sender: UIButton) {
        if  currentUserGameLogs != nil && currentUserGameLogs != []{
            deleteGameLogs()
        }
    }
    
    @IBAction func helpPagePressed(_ sender: UIButton){
        if  currentUserGameLogs != nil && currentUserGameLogs != []{
            deleteGameLogs()
        }
    }
    

    
  
}
extension HomePage: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currentUserGameLogs = currentUserGameLogs{
            return currentUserGameLogs.count + 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameLog", for: indexPath)
        cell.backgroundColor = UIColor(named: "topViewColor")
        if (indexPath.row == 0){
            return cell
        }
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor =  UIColor(named: "celebritiesColor")?.cgColor
        
        let gameLog = currentUserGameLogs?[indexPath.row - 1]
        let enemyName = gameLog?["enemy"] as! String
        let enemyScore = gameLog?["enemyQuestionsAnswered"] as! Int
        let userScore = gameLog?["questionsAnswered"] as! Int
        if (enemyScore >  userScore){
            cell.textLabel?.textColor = UIColor.red
            cell.textLabel?.text = "You lost a game" + " and earned 0 points"
        }
        else if(userScore > enemyScore){
            cell.textLabel?.textColor = UIColor.green
            cell.textLabel?.text = "You won a game by" + " and earned 20 points"
        }
        else{
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.text = "You drew a game by " + " and earned 10 points"

        }
        
        return cell
    }
    
    
}

