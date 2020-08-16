//
//  Versus.swift
//  NittanyTrivia
//
//  Created by Shahzeb Ahmed on 8/15/20.
//  Copyright © 2020 Shahzeb Ahmed. All rights reserved.
//

import Foundation
import UIKit

class Versus: UIViewController{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate//creates a delegate of the UIapplication and downcasts it to be of type AppDelegate which will allow access to google sign in info variables in the appdelegate class.
    
    override func viewDidLoad(){
        super.viewDidLoad()
        var currentGames = [Any]()
        let currentUser = db.collection("Users").document(appDelegate.email)
        currentUser.getDocument { (document , error) in
            currentGames = document?.get("games") as! [Any]
        }
        currentGames.append(["isChallenger": false, "enemy": "Shahzeb", "questionsAnswered": 8, "enemyQuestionsAnswered": 7])
        currentUser.updateData(["games" : currentGames])
    }
    
}
