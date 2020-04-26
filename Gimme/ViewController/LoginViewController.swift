//
//  LoginViewController.swift
//  Gimme
//
//  Created by Stephen Boyle on 4/25/20.
//  Copyright © 2020 Stephen Boyle. All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
//        navigationController?.setNavigationBarHidden(false, animated: true)
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
       
        
        loginButton.frame = CGRect(x: 0, y: 0, width: 235, height: 75)
        loginButton.backgroundColor = .white
        loginButton.backgroundColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1)
        loginButton.layer.cornerRadius = 35
        loginButton.setTitleColor(UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1), for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 36)
        
        
        loginLabel.textColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1)
        loginLabel.font = UIFont(name: "Avenir-Roman", size: 48)
        
        usernameLabel.textColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1)
        usernameLabel.font = UIFont(name: "Avenir-Roman", size: 18)
        
        passwordLabel.textColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1)
        passwordLabel.font = UIFont(name: "Avenir-Roman", size: 18)
        
        usernameTF.layer.borderWidth = 1.0
        usernameTF.layer.borderColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1).cgColor
        usernameTF.backgroundColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
        usernameTF.font = UIFont(name: "Avenir-Roman", size: 20)
        usernameTF.textColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1)
        
        passwordTF.layer.borderWidth = 1.0
        passwordTF.layer.borderColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1).cgColor
        passwordTF.backgroundColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
        passwordTF.font = UIFont(name: "Avenir-Roman", size: 20)
        passwordTF.textColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        if let email = usernameTF.text, let password = passwordTF.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
//              guard let strongSelf = self else { return }
//              // ...
//                print(authResult as Any)
                
            }
        }
        print("success")
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
