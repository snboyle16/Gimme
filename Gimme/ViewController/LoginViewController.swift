//
//  LoginViewController.swift
//  Gimme
//
//  Created by Stephen Boyle on 4/25/20.
//  Copyright © 2020 Stephen Boyle. All rights reserved.
//

import UIKit
import Firebase
var currUser: User!
var currUserID: String!
class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
//    var userID: String!
    
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
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = usernameTF.text, let password = passwordTF.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if (error != nil) {
                    print("wrong username or password")
                    return
                }
                if let fbcurrUser = Auth.auth().currentUser {
                    currUserID = fbcurrUser.uid
                    currUser = User(userID: currUserID)
                    currUser.readFromDB { userdata in
                        self.performSegue(withIdentifier: "toTab", sender: nil)
                    }
                    
                }
            }
        }
    }

    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let dest = segue.destination as? UITabBarController {
////            for i in 0...4 {
//                if let feedTab = dest.viewControllers?[0] as? FeedTableViewController {
//                    feedTab.currUserID = self.userID
//                }
////            }
//
//        }
    }
    
//    func readUserData() {
//        let userRef = db.collection("users").document(currUser.userID)
//        userRef.getDocument { (document,error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data()
//                currUser.username = dataDescription!["username"] as! String
//                currUser.email = dataDescription!["email"] as! String
//                currUser.giveaways = dataDescription!["giveaways"] as! [String]
//                currUser.gimmes = dataDescription!["gimmes"] as! [String]
//                currUser.followers = dataDescription!["followers"] as! [String]
//                currUser.following = dataDescription!["following"] as! [String]
//                currUser.money = dataDescription!["money"] as! Float
//
//            } else {
//                print("Document does not exist. inside User class")
//            }
//        }
//    }
//
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
