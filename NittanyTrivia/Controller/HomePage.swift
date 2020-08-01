//
//  HomePage.swift
//  NittanyTrivia
//
//  Created by Shahzeb Ahmed on 7/25/20.
//  Copyright © 2020 Shahzeb Ahmed. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn



class HomePage: UIViewController {
let appDelegate = UIApplication.shared.delegate as! AppDelegate//creates a delegate of the UIapplication and downcasts it to be of type AppDelegate which will allow access to google sign in info variables in the appdelegate class.
    
    
    @IBOutlet weak var competeButton: UIButton!
    @IBOutlet weak var survivalButton: UIButton!
    @IBOutlet weak var coinsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        competeButton.layer.cornerRadius = 40
        survivalButton.layer.cornerRadius = 40
        
        
        coinsButton.titleLabel?.numberOfLines = 1
        coinsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        coinsButton.titleLabel?.minimumScaleFactor = 0.5
        
        
        print (appDelegate.email)
    
    }
    
    @IBAction func leaderboardPressed(_ sender: UIButton) {
        sender.tintColor = UIColor.gray
    }
    
    @IBAction func storePressed(_ sender: UIButton) {
      
    }
    
    @IBAction func homePressed(_ sender: UIButton) {
    }
    
    @IBAction func helpPagePressed(_ sender: UIButton){
    }
    

}
