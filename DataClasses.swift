//
//  DataClasses.swift
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
    var username: String
    var name: String
    var email: String
    var profilePic: UIImage?
//    var feedData: FeedData
    var giveaways: [String]
    var gimmes: [String]
    var following: [String]
    var followers: [String]
    var userRef: DocumentReference? = nil

    
    init(name: String, username: String, email: String) {
        self.name = name
        self.username = username
        self.email = email
        profilePic = UIImage(named: "defaultProfilePic")
        giveaways = []
        gimmes = []
        following = []
        followers = []
//        feedData = FeedData()
        userID = UUID.init().uuidString
        addTodb()
        userRef = db.collection("users").document(userID)
    }
    
    func addGiveaway(giveawayID: String)  {
        giveaways.append(giveawayID)
        //update database
        userRef?.updateData([
            "giveaways": FieldValue.arrayUnion([giveawayID])
        ])
    }
    
    func addGimme (giveawayID: String) {
        gimmes.append(giveawayID)
        //update database
        userRef?.updateData([
            "gimmes": FieldValue.arrayUnion([giveawayID])
        ])
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
    
    func addTodb() {
        let userData = [
            "username": username,
            "name": name,
            "email": email,
            "giveaways": giveaways,
            "gimmes": gimmes,
            "following": following,
            "followers": followers
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

class Giveaway {
    
    var giveawayID: String
    var userID: String
    var postedTime: Date
    var expirationTime: Date
    var caption: String
    var maxNumWinners: Int
    var donationAmount: Float
    var joinedUsers: [String]
    var likedUsers: [String]
    var comments: [Comment]
    var winners: [String]
    
    init (userID: String, postedTime: Date, expiredTime: Date, caption: String, donationAmount: Float, maxNumWinners: Int) {
        self.userID = userID
        self.postedTime = postedTime
        self.expirationTime = expiredTime
        self.caption = caption
        self.donationAmount = donationAmount
        self.maxNumWinners = maxNumWinners
        giveawayID = UUID.init().uuidString
        joinedUsers = []
        likedUsers = []
        comments = []
        winners = []
    }
    
    func addJoinedUser(user: User) {
        joinedUsers.append(user.username)
    }
    
    func addLikedUser(user: User) {
        likedUsers.append(user.username)
    }
    
    func addComment(comment: Comment) {
        comments.append(comment)
    }
    
    func isExpired () -> Bool {
        //how to check expiration
        return true
    }
    
    func pickWinner () {
        //randomly select winners
    }
    
    func addTodb() {
        let giveawayData = [
            "userID": userID,
            "postedTime": Timestamp(date: postedTime),
            "expirationTime": Timestamp(date: expirationTime),
            "caption": caption,
            "maxNumWinners": maxNumWinners,
            "donationAmount": donationAmount,
            "joinedUsers": joinedUsers,
            "likedUsers": likedUsers,
            //"comments": comments, //need to be fixed
            "winners": winners
            ] as [String : Any]
        db.collection("giveaways").document(giveawayID).setData(giveawayData)
            {err in
            if let err = err {
                print("Error adding user: \(err)")
            } else {
                print("Document added successfully")
            }
        }
    }
 
}

struct Comment {
    var username: String
    var commentText: String
    var commentDate: Date
    var numberOfLikes: Int
}

//class FeedData {
//    var user: User
//    var giveaways: [Giveaway]
//
//
//    init() {
//        giveaways = []
//        updateFeed()
//    }
//
//    func updateFeed() {
//        //pull the data from database
//
//        for user in user.following {
//            //pull the data from data base
//            for giveaway in User.giveaways {
//                if !giveaway.isExpired() {
//                    giveaways.append(giveaway)
//                }
//            }
//        }
//        sortGiveaways()
//    }
//
//    func sortGiveaways () {
//        giveaways.sorted(by: { $0.postedTime > $1.postedTime})
//    }
//}


// Update one field, creating the document if it does not exist.
//db.collection("cities").document("BJ").setData([ "capital": true ], merge: true)

//another way to update
//let washingtonRef = db.collection("cities").document("DC")
//
//// Set the "capital" field of the city 'DC'
//washingtonRef.updateData([
//    "capital": true
//]) { err in
//    if let err = err {
//        print("Error updating document: \(err)")
//    } else {
//        print("Document successfully updated")
//    }
//}

// Atomically remove a region from the "regions" array field.
//washingtonRef.updateData([
  //  "regions": FieldValue.arrayRemove(["east_coast"])
//])

