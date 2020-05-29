//
//  ProfileViewController.swift
//  Gimme
//
//  Created by Stephen Boyle on 4/26/20.
//  Copyright © 2020 Stephen Boyle. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profImage: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var toggleSwitch: UISegmentedControl!
    @IBOutlet weak var profTableView: UITableView!
    
//    var currUserID: String?
//    var currUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topView.backgroundColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
        self.view.backgroundColor = UIColor(red: 0.427, green: 0.565, blue: 0.788, alpha: 1)
        
        userNameLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        userNameLabel.font = UIFont(name: "Avenir-Roman", size: 16)
        // Do any additional setup after loading the view.
        
        profTableView.backgroundColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
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
