//
//  Player.swift
//  NittanyTrivia
//
//  Created by Shahzeb Ahmed on 8/13/20.
//  Copyright © 2020 Shahzeb Ahmed. All rights reserved.
//

import Foundation

//struct User {
//    var email: String
//    var firstName: String
//    var fullName: String
//    var lives: Int
//    var points: Int
//    var coins: Int
//    var gems: Int
//}

struct LeaderboardsUser {//struct which contains relevant user info to put on leaderboard
   var email: String
   var firstName: String
   var lastName: String
   var points: Int
}

struct Profile {
    var name: String
    var wins: Int
    var losses: Int
    var draws: Int
    var winPercentage: Float
    var points: Int
    var coins: Int
    var gems: Int
}
var currentUserProfile = Profile(name: "John Smith", wins: 0, losses: 0, draws: 0,  winPercentage: 10, points: 10, coins: 10, gems: 1 )





func getUserProfileInfo(){
    let userProfileRef = db.collection("Users").document(appDelegate.email)
    userProfileRef.getDocument { (user, error) in
        if let error = error {
            print(error)
        }//if
        else{
            if let user = user{
                currentUserProfile.name = user.get("firstName") as! String
                currentUserProfile.wins = user.get("versus.wins") as! Int
                currentUserProfile.losses = user.get("versus.losses") as! Int
                currentUserProfile.draws = user.get("versus.draws") as! Int
                currentUserProfile.winPercentage = (user.get("versus.wins") as! Float)/((user.get("versus.losses") as! Float) + (user.get("versus.wins") as! Float))
                currentUserProfile.points = user.get("points") as! Int
                currentUserProfile.coins = user.get("coins") as! Int
                currentUserProfile.gems = user.get("gems") as! Int
            }//if
        }//else
    }//getDocument
   
}//getUserProfileInfo
