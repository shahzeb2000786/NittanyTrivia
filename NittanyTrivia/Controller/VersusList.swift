//
//  VersusList.swift
//  NittanyTrivia
//
//  Created by Shahzeb Ahmed on 8/16/20.
//  Copyright © 2020 Shahzeb Ahmed. All rights reserved.
//

import Foundation

import UIKit

   
class VersusList: UIViewController {
    @IBOutlet weak var gamesTable: UITableView!
    @IBOutlet weak var popUpView: UIView!
    
    var currentGames = [Any]()
    let enemyClickedOn: String = ""//the name of the opponent of the game that the person clicked on
    override func viewDidLoad(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate//creates a delegate of the UIapplication and downcasts it to be of type AppDelegate which will allow access to google sign in info variables in the appdelegate class.
        popUpView.isHidden = true
        gamesTable.dataSource = self
        gamesTable.delegate = self
        gamesTable.register(UINib(nibName: "gameCell", bundle: nil), forCellReuseIdentifier: "gameCell")
        
               let currentUser = db.collection("Users").document(appDelegate.email)
               currentUser.getDocument { (document , error) in
                self.currentGames = document?.get("versus.games") as! [Any]
                self.currentGames.reverse() //reverses games list so recent games are shown first
                DispatchQueue.main.async{
                    self.gamesTable.reloadData()
                }
        }
    }
    
    @IBAction func cancelPopUp(_ sender: Any) {
        popUpView.isHidden = true
    }
    
    
    @IBAction func toPlayScreen(_ sender: Any) {
         self.performSegue(withIdentifier: "toVersusScreen", sender: UITableViewCell.self)
    }
    
}

extension VersusList: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentGames.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (60)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! gameCell
            print(self.currentGames)
            var currentGame = self.currentGames[indexPath.row] as! NSDictionary
        
        cell.opponentLabel.text = (currentGame["enemy"] as! String)// + "     " + "Your score: " + (String(currentGame["questionsAnswered"] as! Int)) + "/10"
        if (currentGame["isChallenger"] as! Bool == false){//detects a game sent by another player
            cell.gameCellView.layer.borderWidth = 1.5
            cell.gameCellView.layer.borderColor = UIColor.red.cgColor
        }
        else{
            cell.gameCellView.layer.borderWidth = 1.5
            cell.gameCellView.layer.borderColor = UIColor.green.cgColor
        }
        cell.layer.masksToBounds = true
        cell.separatorInset = UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
        return cell
    }
    
    
}


extension VersusList: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = gamesTable.cellForRow(at: indexPath) as! gameCell
        let colorOfSelected =  cell.gameCellView.layer.borderColor!
        
        var currentGame = self.currentGames[indexPath.row] as! NSDictionary
        

        print(currentGame["id"])
        currentGameID = currentGame["id"] as? Int
        if UIColor(cgColor: colorOfSelected) == UIColor.red{
            self.performSegue(withIdentifier: "toVersusScreen", sender: UITableViewCell.self)

        }
        else{
            popUpView.isHidden = false
        }
        

    }

}

