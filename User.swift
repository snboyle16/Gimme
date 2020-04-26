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
    
    var userID: String
    var money: Float
    var username: String
    var email: String
    var profilePic: UIImage?
    var feedData: FeedData
    var giveaways: [String]
    var gimmes: [String]
    var following: [String]
    var followers: [String]
    var userRef: DocumentReference? = nil

    
    init(userID: String, email: String, username: String) {
        self.username = username
        self.email = email
        self.userID = userID
        profilePic = UIImage(named: "defaultPic")
        giveaways = []
        gimmes = []
        following = []
        followers = []
        feedData = FeedData(userID: userID)
        money = 0.0
        addTodb()
        userRef = db.collection("users").document(userID)
    }
    
    
    init(username: String, email: String) {
        self.username = username
        self.email = email
        userID = UUID.init().uuidString
        profilePic = UIImage(named: "defaultPic")
        giveaways = []
        gimmes = []
        following = []
        followers = []
        feedData = FeedData(userID: userID)
        money = 0.0
        addTodb()
        userRef = db.collection("users").document(userID)
    }
    
    init(userID: String) {
        self.userID = userID
        username = ""
        email = ""
        profilePic = UIImage(named: "defaultPic")
        giveaways = []
        gimmes = []
        following = []
        followers = []
        feedData = FeedData(userID: userID)
        userRef = db.collection("users").document(userID)
        money = 0.0
        userRef?.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                self.username = dataDescription!["username"] as! String
                self.email = dataDescription!["email"] as! String
                self.giveaways = dataDescription!["giveaways"] as! [String]
                self.gimmes = dataDescription!["gimmes"] as! [String]
                self.followers = dataDescription!["followers"] as! [String]
                self.following = dataDescription!["following"] as! [String]
                self.money = dataDescription!["moeny"] as! Float
            } else {
                print("Document does not exist. inside User class")
            }
        }
    }
    
    func addGiveaway(caption: String, donationAmount: Float, maxNumWinners: Int, expirationTime: Date)  {
        let currentTime = Date()
        let giveaway = Giveaway(userID: userID, postedTime: currentTime, expiredTime: expirationTime, caption: caption, donationAmount: donationAmount, maxNumWinners: maxNumWinners)

        giveaways.append(giveaway.giveawayID)
        //update database
        userRef?.updateData([
            "giveaways": FieldValue.arrayUnion([giveaway.giveawayID])
        ])
    }
    
    func joinGiveaway (giveawayID: String) {
        let gimme = Giveaway(giveawayID: giveawayID)
        gimme.addJoinedUser(userID: self.userID)
        
        gimmes.append(giveawayID)
        //update database
        userRef?.updateData([
            "gimmes": FieldValue.arrayUnion([giveawayID])
        ])
    }
    
    func likeGiveaway(giveawayID: String) {
        let gimme = Giveaway(giveawayID: giveawayID)
        gimme.addLikedUser(userID: self.userID)
    }
    
    func addComment(giveawayID: String, commentText: String) {
        let giveaway = Giveaway(giveawayID: giveawayID)
        let currentDate = Date()
        let comment = Comment(userID: self.userID, commentText: commentText, commentDate: currentDate, numberOfLikes: 0)
        giveaway.addComment(comment: comment)
    }
    
    func follow(userID: String) {
        followers.append(userID)
        //update database
        userRef?.updateData([
            "following": FieldValue.arrayUnion([userID])
        ])
    }
    
    func getfollowed(userID: String) {
        following.append(userID)
        //update database
        userRef?.updateData([
            "followers": FieldValue.arrayUnion([userID])
        ])
    }
    
    func getMoney(donationMoney: Float) {
        self.money += donationMoney
        userRef?.updateData([
            "money": self.money
        ])
    }
    
    func giveMoney(donationMoney: Float) {
        self.money -= donationMoney
        userRef?.updateData([
            "money": self.money
        ])
    }
    
    func addTodb() {
        let userData = [
            "username": username,
            "email": email,
            "giveaways": giveaways,
            "gimmes": gimmes,
            "following": following,
            "followers": followers,
            "money": money
            ] as [String : Any]
        db.collection("users").document(userID).setData(userData)
        {err in
            if let err = err {
                print("Error adding user: \(err)")
            } else {
                print("Document added successfully")
            }
        }
    }
    
}
