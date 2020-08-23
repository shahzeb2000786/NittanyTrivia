//
//  gameCell.swift
//  NittanyTrivia
//
//  Created by Shahzeb Ahmed on 8/23/20.
//  Copyright © 2020 Shahzeb Ahmed. All rights reserved.
//

import UIKit

class gameCell: UITableViewCell {

    @IBOutlet weak var enemyIndicatorView: UIView!
    @IBOutlet weak var gameCellView: UIView!
    @IBOutlet weak var opponentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        opponentLabel.numberOfLines = 1;
        opponentLabel.minimumScaleFactor = 0.5
        opponentLabel.adjustsFontSizeToFitWidth = true
    
        
        gameCellView.layer.cornerRadius = gameCellView.frame.size.height/3

        let margins = CGRect(x: 0, y: 0, width: 10, height: 0)
        gameCellView.frame.insetBy(dx: 2.0, dy: 2.0)
        
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
