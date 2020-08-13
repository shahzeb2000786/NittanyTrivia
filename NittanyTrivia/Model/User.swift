//
//  Player.swift
//  NittanyTrivia
//
//  Created by Shahzeb Ahmed on 8/13/20.
//  Copyright © 2020 Shahzeb Ahmed. All rights reserved.
//

import Foundation

struct User {
    var coins: Int
    var email: String
    var firstName: String
    var gems: Int
    var fullName: String
    var lives: Int
    var points: Int
    
}
struct LeaderboardsUser {//struct which contains relevant user info to put on leaderboard
   var email: String
   var points: Int
}
