//
//  CommentViewController.swift
//  Gimme
//
//  Created by Stephen Boyle on 5/10/20.
//  Copyright © 2020 Stephen Boyle. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {

    @IBOutlet weak var commentView: UIView!
    
    @IBOutlet weak var timeLeft: UILabel!
    @IBOutlet weak var giveAmount: UILabel!
    @IBOutlet weak var descrip: UILabel!
    
    var giveaway: Giveaway!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fadedGreen = UIColor.AppColors.Green.FadedGreen
        let gray = UIColor.AppColors.Gray.BackgroundGray
        commentView.backgroundColor = fadedGreen
        commentView.layer.cornerRadius = 10
        
        timeLeft.font = UIFont(name: "Avenir-Roman", size: 10)
        timeLeft.textColor = .white
//        let df = DateFormatter()
//        df.dateFormat = "yyyy-MM-dd hh:mm"
//        timeLeft.text = df.string(from: giveaway.expirationTime)
        
        giveAmount.font = UIFont(name: "Avenir-Roman", size: 24)
        giveAmount.textColor = .white
//        giveAmount.text = "\(giveaway.donationAmount)"
        
        descrip.font = UIFont(name: "Avenir-Roman", size: 14)
        descrip.textColor = .white
//        descrip.text = giveaway.caption
        
        self.view.backgroundColor = gray
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm"
        timeLeft.text = df.string(from: giveaway.giveawayData.expirationTime)
        giveAmount.text = "\(giveaway.giveawayData.donationAmount)"
        descrip.text = giveaway.giveawayData.caption
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
