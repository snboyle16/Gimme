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
        let fadedGreen = UIColor.AppColors.Green.FadedGreen
        let backgroundGray = UIColor.AppColors.Gray.BackgroundGray
        
        self.view.backgroundColor = backgroundGray
//        navigationController?.setNavigationBarHidden(false, animated: true)
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
       
        loginButton.frame = CGRect(x: 0, y: 0, width: 235, height: 75)
        loginButton.backgroundColor = .white
        loginButton.backgroundColor = fadedGreen
//        loginButton.layer.cornerRadius = 35
        loginButton.setTitleColor(backgroundGray, for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 48)
        
        
        loginLabel.textColor = fadedGreen
        loginLabel.font = UIFont(name: "Avenir-Roman", size: 48)
        
        usernameLabel.textColor = fadedGreen
        usernameLabel.font = UIFont(name: "Avenir-Roman", size: 18)
        
        passwordLabel.textColor = fadedGreen
        passwordLabel.font = UIFont(name: "Avenir-Roman", size: 18)
        
        usernameTF.layer.borderWidth = 1.0
        usernameTF.layer.borderColor = fadedGreen.cgColor
        usernameTF.backgroundColor = backgroundGray
        usernameTF.font = UIFont(name: "Avenir-Roman", size: 20)
        usernameTF.textColor = fadedGreen
        usernameTF.clipsToBounds = true
        usernameTF.layer.cornerRadius = 10.0
        
        passwordTF.layer.borderWidth = 1.0
        passwordTF.layer.borderColor = fadedGreen.cgColor
        passwordTF.backgroundColor = backgroundGray
        passwordTF.font = UIFont(name: "Avenir-Roman", size: 20)
        passwordTF.textColor = fadedGreen
        passwordTF.clipsToBounds = true
        passwordTF.layer.cornerRadius = 10.0
        
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        print("helllo")
        if let email = usernameTF.text, let password = passwordTF.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                
//              guard let strongSelf = self else { return }
//              // ...
//                print(authResult as Any)
                let fbcurrUser = Auth.auth().currentUser
                
                print(fbcurrUser?.uid ?? "  hi ")
                currUser = User(userID: fbcurrUser?.uid ?? "")
                self?.performSegue(withIdentifier: "toTab", sender: nil)
            }
        }
//        print(currUser.feedData.giveaways.count)
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
