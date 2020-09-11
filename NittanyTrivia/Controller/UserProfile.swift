//
//  Profile.swift
//  NittanyTrivia
//
//  Created by Shahzeb Ahmed on 8/31/20.
//  Copyright © 2020 Shahzeb Ahmed. All rights reserved.
//

import Foundation
import UIKit


class UserProfile: UIViewController{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var lossesLabel: UILabel!
    @IBOutlet weak var drawsLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var winPercentage: UIProgressView!
 
    
    
    @IBOutlet weak var pointsView: UIView!

    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        pointsView.layer.cornerRadius = 40

        
        getUserProfileInfo()//changes global profile variable, which is located in User.swift
        print(currentUserProfile.winPercentage)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.nameLabel.text = currentUserProfile.name
            self.winsLabel.text = String(currentUserProfile.wins)
            self.lossesLabel.text = String(currentUserProfile.losses)
            self.drawsLabel.text = String(currentUserProfile.draws)
            self.pointsLabel.text = String(currentUserProfile.points)
            self.winPercentage.progress = currentUserProfile.winPercentage
//            self.coinsLabel.text = String(currentUserProfile.coins) + "💰"
//            self.gemsLabel.text = String(currentUserProfile.gems) + "💎"
        }//DispatchQueue
    }//viewDidLoad
}//UserProfile
