//
//  LandingViewController.swift
//  Gimme
//
//  Created by Stephen Boyle on 4/25/20.
//  Copyright © 2020 Stephen Boyle. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var gimmeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let dummydata = DummyData()
        print("here")
        let fadedGreen = UIColor.AppColors.Green.FadedGreen
        let backgroundGray = UIColor.AppColors.Gray.BackgroundGray
        let fadedPurp = UIColor.AppColors.Purple.FadedPurp
        signUpButton.backgroundColor = fadedPurp
        signUpButton.setTitleColor(backgroundGray, for: .normal)
        signUpButton.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 48)
        
        loginButton.backgroundColor =  fadedGreen
        loginButton.setTitleColor(backgroundGray, for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 48)
        
        self.view.backgroundColor = backgroundGray
        
//        navigationController?.navigationBar.barTintColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 0)
        navigationController?.navigationBar.isHidden = true
        
        
        gimmeLabel.textColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1)
        gimmeLabel.font = UIFont(name: "Avenir-Roman", size: 90)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        performSegue(withIdentifier: "toSignIn", sender: nil)
    }
    
    
    @IBAction func loginPressed(_ sender: Any) {
        performSegue(withIdentifier: "toLogIn", sender: self)
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
