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
    var currentGames = [Any]()
    let enemyClickedOn: String = "" //will contain the user's
    override func viewDidLoad(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate//creates a delegate of the UIapplication and downcasts it to be of type AppDelegate which will allow access to google sign in info variables in the appdelegate class.
        gamesTable.dataSource = self
        gamesTable.delegate = self
        
               let currentUser = db.collection("Users").document(appDelegate.email)
               currentUser.getDocument { (document , error) in
                self.currentGames = document?.get("versus.games") as! [Any]
                DispatchQueue.main.async{
                    self.gamesTable.reloadData()
                }
        }
    }
}

extension VersusList: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
            print(self.currentGames)
            var currentGame = self.currentGames[indexPath.row] as! NSDictionary
        cell.textLabel?.text = "enemy: " + (currentGame["enemy"] as! String) + "     " + "Your score: " + (String(currentGame["questionsAnswered"] as! Int)) + "/10"
        return cell
    }
    
}

extension VersusList: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print (indexPath.row)
    }

}

