//
//  FeedPostTableViewCell.swift
//  Gimme
//
//  Created by Stephen Boyle on 4/25/20.
//  Copyright © 2020 Stephen Boyle. All rights reserved.
//

import UIKit

//Protocol declaration
protocol CustomCellDelegate:class {
    func customcell(cell:FeedPostTableViewCell, didTappedThe button:UIButton?)
}

class FeedPostTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePicButton: UIButton!
    
    @IBOutlet weak var timeLeft: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var backGroundLabel: UILabel!
    
    //Delegate property as weak
    weak var cellDelegate:CustomCellDelegate?
    
    @IBAction func joinPressed(_ sender: Any) {
        cellDelegate?.customcell(cell: self, didTappedThe: sender as?UIButton)
    }
}
