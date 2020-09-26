//
//  Settings.swift
//  NittanyTrivia
//
//  Created by Shahzeb Ahmed on 9/25/20.
//  Copyright © 2020 Shahzeb Ahmed. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import Firebase

class Settings: UIViewController{
    @IBOutlet weak var signOutButton: UIButton!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate//creates a delegate of the UIapplication and downcasts it to be of type AppDelegate which will allow access to google sign in info variables in the appdelegate class.
    override func viewDidLoad(){
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        signOutButton.layer.cornerRadius = signOutButton.frame.height / 4
    }
    @IBAction func signOutUser(_ sender: UIButton) {
        appDelegate.fullName = ""
        appDelegate.email = ""
        appDelegate.givenName = ""
        appDelegate.userId = ""

        do {
            GIDSignIn.sharedInstance().signOut()
            
            appDelegate.userDefaults.setValue(nil, forKey: "email")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
           
              self.performSegue(withIdentifier: "toSignInScreen", sender: self)
            })
           
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }//catch
        
    }
}
