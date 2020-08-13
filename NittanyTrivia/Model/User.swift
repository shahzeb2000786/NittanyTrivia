//
//  Player.swift
//  NittanyTrivia
//
//  Created by Shahzeb Ahmed on 8/13/20.
//  Copyright © 2020 Shahzeb Ahmed. All rights reserved.
//

import Foundation

struct User {
    coins: Int
    email: String
    firstName: String
    gems: Int
    fullName: String
    lives: Int
    points: Int
    
}

struct LeaderboardUser {//struct which contains relevant user info to put on leaderboard
    email: String
    points: Int
}
