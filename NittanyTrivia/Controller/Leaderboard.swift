//
//  Leaderboard.swift
//  NittanyTrivia
//
//  Created by Shahzeb Ahmed on 7/22/20.
//  Copyright © 2020 Shahzeb Ahmed. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class Leaderboard: UIViewController {

    @IBOutlet weak var firstPlace: UILabel!
    @IBOutlet weak var secondPlace: UILabel!
    @IBOutlet weak var thirdPlace: UILabel!
    @IBOutlet weak var fourthPlace: UILabel!
    @IBOutlet weak var fifthPlace: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstPlace.layer.cornerRadius = 40
        secondPlace.layer.cornerRadius = 40
        thirdPlace.layer.cornerRadius = 40
        fourthPlace.layer.cornerRadius = 40
        fifthPlace.layer.cornerRadius = 40
        
        firstPlace.adjustsFontSizeToFitWidth = true
        var leaderBoardLabels = [firstPlace!, secondPlace!,thirdPlace!,fourthPlace!,fifthPlace!]

        var leaderboardRef = db.collection("Users")
            .order(by: "points", descending: true)
            .limit(to: 5)
        leaderboardRef.getDocuments { (querySnapshot, err) in
            print(querySnapshot)
            if let error = err{
                print(err)
            }//end of if
            else{
                var topFivePlayers = Array<Any>()
                if let querySnapshot = querySnapshot {
                    for document in querySnapshot.documents{
                        topFivePlayers.append(document.data()["email"])
                        print(document.data()["email"])
                         print(document.data()["points"])
                        print(document.data().count)
                    }//end of for
                    DispatchQueue.main.async {
                        self.setLeaderboard(players: topFivePlayers, leaderBoardLabels: leaderBoardLabels)
                    }//end of DispatchQueue
                }//end of if optional binding
            }//end of else
        }//end of getDocuments
    }//end of viewDidLoad
    

}

//extension below deals with setting the leaderboard values
extension Leaderboard {
    //setLeaderboard sets the leaderboard label values and is executed inside the view didload of the view controller
    func setLeaderboard(players: Array<Any>, leaderBoardLabels: [UILabel]){
        let numberOfPlayers = players.count
        for playerNumber in 0...players.count-1{
            leaderBoardLabels[playerNumber].text = players[playerNumber] as! String
        }
    }
}
