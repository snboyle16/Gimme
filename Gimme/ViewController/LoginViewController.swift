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

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
