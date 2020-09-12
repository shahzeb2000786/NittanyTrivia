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
    @IBOutlet weak var coinsLabel: UIButton!
    @IBOutlet weak var livesLabel: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.hidesBackButton = true

        print(appDelegate.email)
        competeButton.layer.cornerRadius = 40
        survivalButton.layer.cornerRadius = 40
        
        
        coinsLabel.titleLabel?.numberOfLines = 1
        coinsLabel.titleLabel?.adjustsFontSizeToFitWidth = true
        coinsLabel.titleLabel?.minimumScaleFactor = 0.5
        coinsLabel.isHidden = true
        livesLabel.isHidden = true
        
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
