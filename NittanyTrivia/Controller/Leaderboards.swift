//
//  Leaderboards.swift
//  NittanyTrivia
//
//  Created by Shahzeb Ahmed on 8/13/20.
//  Copyright © 2020 Shahzeb Ahmed. All rights reserved.
//

import Foundation
import UIKit
import Firebase
let questionChecker = QuestionChecker()//contains logic to check answers to questions

class Leaderboards: UIViewController {
    var topPlayers: [LeaderboardsUser] = []
    @IBOutlet weak var leaderboardsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        leaderboardsTable.dataSource = self
        getLeaderboard()
    }
    
    func getLeaderboard(){
        self.topPlayers = []
        var leaderboardRef = db.collection("Users")
                   .order(by: "points", descending: true)
                   .limit(to: 10)
               leaderboardRef.getDocuments { (querySnapshot, err) in
                   print(querySnapshot)
                   if let error = err{
                       print(err)
                   }//end of if
                   else{
                      
                       if let querySnapshot = querySnapshot {
                           for document in querySnapshot.documents{
                            let userEmail = document.data()["email"] as! String
                            let userPoints = document.data()["points"] as! Int
                            var user = LeaderboardsUser(email: userEmail , points: userPoints)
                            self.topPlayers.append(user)
                              // print(document.data()["email"])
                               // print(document.data()["points"])
                              // print(document.data().count)
                            DispatchQueue.main.async{
                                self.leaderboardsTable.reloadData()
                               
                            }
                           }//end of for
                       }//end of if optional binding
                   // print(self.topPlayers)
                   }//end of else
               }//end of getDocuments
    }//end of getleaderboard
    
    
    
}
extension Leaderboards: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DispatchQueue.main.async()  {
        print(self.topPlayers)
        }
        return self.topPlayers.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let leaderboardsCell = tableView.dequeueReusableCell(withIdentifier: "leaderboardsCell", for: indexPath)

        let user = self.topPlayers[indexPath.row]
        leaderboardsCell.textLabel?.text =  String(user.points) + " " + user.email
        leaderboardsCell.backgroundColor = UIColor.gray
        leaderboardsCell.clipsToBounds = true
        leaderboardsCell.layer.cornerRadius = 40
        
        return leaderboardsCell
    }
    
    
}
