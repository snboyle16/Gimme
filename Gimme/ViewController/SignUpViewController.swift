//
//  SignUpViewController.swift
//  Gimme
//
//  Created by Stephen Boyle on 4/25/20.
//  Copyright © 2020 Stephen Boyle. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
//        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
        // Do any additional setup after loading the view.
        
        signInLabel.textColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1)
        signInLabel.font = UIFont(name: "Avenir-Roman", size: 48)
        
        emailTF.layer.borderWidth = 1.0
        emailTF.layer.borderColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1).cgColor
        emailTF.backgroundColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
        emailTF.font = UIFont(name: "Avenir-Roman", size: 20)
        emailTF.textColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1)
        emailTF.clipsToBounds = true
        emailTF.layer.cornerRadius = 10.0
        
        usernameTF.layer.borderWidth = 1.0
        usernameTF.layer.borderColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1).cgColor
        usernameTF.backgroundColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
        usernameTF.font = UIFont(name: "Avenir-Roman", size: 20)
        usernameTF.textColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1)
        usernameTF.clipsToBounds = true
        usernameTF.layer.cornerRadius = 10.0
        
        passwordTF.layer.borderWidth = 1.0
        passwordTF.layer.borderColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1).cgColor
        passwordTF.backgroundColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
        passwordTF.font = UIFont(name: "Avenir-Roman", size: 20)
        passwordTF.textColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1)
        passwordTF.clipsToBounds = true
        passwordTF.layer.cornerRadius = 10.0
        
        signinButton.frame = CGRect(x: 0, y: 0, width: 235, height: 75)
        signinButton.backgroundColor = .white
        signinButton.backgroundColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1)
        signinButton.layer.cornerRadius = 35
        signinButton.setTitleColor(UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1), for: .normal)
        signinButton.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 36)
        
        emailLabel.textColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1)
        emailLabel.font = UIFont(name: "Avenir-Roman", size: 18)
        
        usernameLabel.textColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1)
        usernameLabel.font = UIFont(name: "Avenir-Roman", size: 18)
        
        passwordLabel.textColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1)
        passwordLabel.font = UIFont(name: "Avenir-Roman", size: 18)
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        
        // validation for email and password
        
        if let email = emailTF.text, let password = passwordTF.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                
                
            }
        }
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           // Pass the selected object to the new view controller.
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

class PaypalViewController: UIViewController {
    
    
    @IBOutlet weak var PaypalImage: UIImageView!
    @IBOutlet weak var paypalMeLabel: UILabel!
    @IBOutlet weak var paypalMeTF: UITextField!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
    //        navigationController?.setNavigationBarHidden(false, animated: true)
            navigationController?.navigationBar.barTintColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
            // Do any additional setup after loading the view.
            paypalMeTF.layer.borderWidth = 1.0
            paypalMeTF.layer.borderColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1).cgColor
            paypalMeTF.backgroundColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
            paypalMeTF.font = UIFont(name: "Avenir-Roman", size: 20)
            paypalMeTF.textColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1)
            paypalMeTF.clipsToBounds = true
            paypalMeTF.layer.cornerRadius = 10.0
        
        
            paypalMeLabel.textColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1)
            paypalMeLabel.font = UIFont(name: "Avenir-Roman", size: 18)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               // Get the new view controller using segue.destination.
               // Pass the selected object to the new view controller.
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
