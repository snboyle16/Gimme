////
////  readUserData.swift
////  Gimme
////
////  Created by Hossein Shirinabadi on 4/26/20.
////  Copyright © 2020 Stephen Boyle. All rights reserved.
////
//
//import Foundation
//import UIKit
//import CoreData
//import Firebase
//
//class readUserData {
//    var userID: String
//    init(userID: String){
//        self.userID = userID
//    }
//    func readDb (completion: @escaping (userData) -> ()) {
//        let userRef = db.collection("users").document(userID)
//        
//        userRef.getDocument { (document,error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data()
//                let username = dataDescription!["username"] as! String
//                let email = dataDescription!["email"] as! String
//                let giveaways = dataDescription!["giveaways"] as! [String]
//                let gimmes = dataDescription!["gimmes"] as! [String]
//                let followers = dataDescription!["followers"] as! [String]
//                let following = dataDescription!["following"] as! [String]
//                let money = dataDescription!["money"] as! Float
//                
//                completion(userData(username: username, email: email, giveaways: giveaways, gimmes: gimmes, followers: followers, following: following, money: money))
//            }
//        }
//    }
//}
//
