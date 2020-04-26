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
        signUpButton.backgroundColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1)
        signUpButton.setTitleColor(UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1), for: .normal)
        signUpButton.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 48)
        
        loginButton.backgroundColor = UIColor(red: 0.427, green: 0.565, blue: 0.788, alpha: 1)
        loginButton.setTitleColor(UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1), for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 48)
        
        self.view.backgroundColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 0)
        
        
        
        gimmeLabel.textColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1)
        gimmeLabel.font = UIFont(name: "Avenir-Roman", size: 90)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
//        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    
    @IBAction func loginPressed(_ sender: Any) {
//        navigationController?.pushViewController(LoginViewController(), animated: true)
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
