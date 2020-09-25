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
        let defaults = UserDefaults.standard
        defaults.setValue(true, forKey: "hasSignedIn")
        let hasSignedIn = defaults.value(forKey: "hasSignedIn")
        

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
    
    }//viewDidLoad
    
    
    
//    func showMyAlert() {
//        let screenRect = UIScreen.main.bounds
//            let screenWidth = screenRect.size.width
//            let screenHeight = screenRect.size.height
//
//            // split screen
//            let windowRect = self.view.window?.frame
//            let windowWidth = windowRect?.size.width
//            let windowHeight = windowRect?.size.height
//
//        let testFrame = CGRect(x: 0, y: 100, width: 100, height: 100)
//        var testView : UIView = UIView(frame: testFrame)
//        testView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
//
//
//        var alert = (Bundle.main.loadNibNamed("gameInfoAlert", owner: self, options: nil)? [0]) as! gameInfoAlert
//
//        print (alert)
//        self.view.addSubview(alert as! UIView)
//
//
//    }
    
    
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
