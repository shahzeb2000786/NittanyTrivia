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
        getQuestion(numOfQuestions: 10)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
           print(questionsToAskUser)
            print(randomEnemy["email"])
            
        }
    
    }

}

