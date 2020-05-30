//
//  User.swift
//  Gimme
//
//  Created by Hossein Shirinabadi on 4/25/20.
//  Copyright © 2020 Stephen Boyle. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Firebase


let db = Firestore.firestore()

class User {
    
    var userData: UserData
    var userID: String
    var profilePic: UIImage?

    
    init(userID: String, email: String, username: String) {
        self.userID = userID
        self.userData = UserData(username: username, email: email)
        profilePic = UIImage(named: "tony")
    }
    
    init(userID: String) {
        self.userID = userID
        //read data user from database needs to be fixed
        profilePic = UIImage(named: "tony")
        self.userData = UserData()
    }
    
    func addGiveaway(caption: String, donationAmount: Float, maxNumWinners: Int, expirationTime: Date)  {
        let currentTime = Date()
        let giveaway = Giveaway(userID: userID,username: userData.username, postedTime: currentTime, expirationTime: expirationTime, caption: caption, donationAmount: donationAmount, maxNumWinners: maxNumWinners)

        userData.giveaways.append(giveaway.giveawayID)
        //update database
        let userRef = db.collection("users").document(userID)
        userRef.updateData([
            "giveaways": FieldValue.arrayUnion([giveaway.giveawayID])
        ])
    }
    
    func joinGiveaway(giveawayID: String) {
        let gimme = Giveaway(giveawayID: giveawayID)
        gimme.addJoinedUser(userID: self.userID)
        
        userData.joinedGimmes.append(giveawayID)
        //update database
        let userRef = db.collection("users").document(userID)
        userRef.updateData([
            "joinedGimmes": FieldValue.arrayUnion([giveawayID])
        ])
    }
    
    func likeGiveaway(giveawayID: String) {
        let gimme = Giveaway(giveawayID: giveawayID)
        gimme.addLikedUser(userID: self.userID)
    }
    
    func addComment(giveawayID: String, commentText: String) {
        let giveaway = Giveaway(giveawayID: giveawayID)
        let currentDate = Date()
        let comment = Comment(userID: self.userID, username: userData.username, commentText: commentText, commentDate: currentDate, numberOfLikes: 0)
        giveaway.addComment(comment: comment)
    }
    
    func follow(userID: String) {
        userData.following.append(userID)
        //update database
        let selfRef = db.collection("users").document(self.userID)
        selfRef.updateData([
            "following": FieldValue.arrayUnion([userID])
        ])
        let userRef = db.collection("users").document(userID)
        userRef.updateData([
            "followers": FieldValue.arrayUnion([self.userID])
        ])
    }
    
    
    func getMoney(donationMoney: Float) {
        userData.money += donationMoney
        let userRef = db.collection("users").document(userID)
        userRef.updateData([
            "money": userData.money
        ])
    }
    
    func giveMoney(donationMoney: Float) {
        userData.money -= donationMoney
        let userRef = db.collection("users").document(userID)
        userRef.updateData([
            "money": userData.money
        ])
    }
    
    func addPayPalLink (paypal: String) {
        userData.paypal = paypal
    }
    
    func addTodb(completion: @escaping () -> Void) {
        let userdata = [
            "username": userData.username,
            "email": userData.email,
            "paypal": userData.paypal,
            "giveaways": userData.giveaways,
            "gimmes": userData.gimmes,
            "joinedGimmes": userData.joinedGimmes,
            "followers": userData.followers,
            "following": userData.following,
            "money": userData.money
            ] as [String : Any]
        db.collection("users").document(userID).setData(userdata)
        {err in
            if let err = err {
                print("Error adding user: \(err)")
            }
            completion()
        }
    }
    
    func readFromDB(completion: @escaping (UserData) -> Void) {
        let userRef = db.collection("users").document(userID)
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                self.userData.username = dataDescription!["username"] as! String
                self.userData.email = dataDescription!["email"] as! String
//                self.userData.paypal = dataDescription!["paypal"] as! String
                self.userData.giveaways = dataDescription!["giveaways"] as! [String]
                self.userData.gimmes = dataDescription!["gimmes"] as! [String]
                self.userData.joinedGimmes = dataDescription!["joinedGimmes"] as! [String]
                self.userData.followers = dataDescription!["followers"] as! [String]
                self.userData.following = dataDescription!["following"] as! [String]
                self.userData.money = dataDescription!["money"] as! Float
                completion(self.userData)

            } else {
                print("Document does not exist. inside FeedData class")
            }
        }
    }
    
    
    
}
