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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var leaderboardRef = db.collection("Users")
            .order(by: "points", descending: true)
            .limit(to: 5)
        
        leaderboardRef.getDocuments { (querySnapshot, err) in
            print(querySnapshot)
            if let error = err{
                print(err)
            }//end of if
            else{
                if let querySnapshot = querySnapshot {
                    for document in querySnapshot.documents{
                        print(document.data())
                    }//end of for
                }//end of if optional binding
            }//end of else
        }//end of getDocuments
    }//end of viewDidLoad
    

}
