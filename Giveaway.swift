//
//  Giveaway.swift
//  Gimme
//
//  Created by Hossein Shirinabadi on 4/25/20.
//  Copyright © 2020 Stephen Boyle. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Firebase

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
    var giveawayRef: DocumentReference? = nil
    
    
    init(userID: String, postedTime: Date, expiredTime: Date, caption: String, donationAmount: Float, maxNumWinners: Int) {
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
        addTodb()
        giveawayRef = db.collection("giveaways").document(giveawayID)
    }
    
    
    init(giveawayID: String) {
        self.giveawayID = giveawayID
        self.userID = ""
        self.postedTime = Date()
        self.expirationTime = Date()
        self.caption = ""
        self.donationAmount =  0.0
        self.maxNumWinners = 0
        self.joinedUsers = []
        self.likedUsers = []
        self.comments = []
        self.winners = []
        giveawayRef = db.collection("giveaways").document(giveawayID)
        giveawayRef?.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                self.userID = dataDescription!["userID"] as! String
                var timestamp = dataDescription!["postedTime"] as! Timestamp
                var date = Date(timeIntervalSince1970: TimeInterval(timestamp.seconds))
                self.postedTime = date
                timestamp = dataDescription!["expirationTime"] as! Timestamp
                date = Date(timeIntervalSince1970: TimeInterval(timestamp.seconds))
                self.expirationTime = date
                self.caption = dataDescription!["caption"] as! String
                self.donationAmount = dataDescription!["donationAmount"] as! Float
                self.maxNumWinners = dataDescription!["maxNumWinners"] as! Int
                self.joinedUsers = dataDescription!["joinedUsers"] as! [String]
                self.likedUsers = dataDescription!["likeUsers"] as! [String]
                self.winners = dataDescription!["winners"] as! [String]
            } else {
                print("Document does not exist")
            }
        }
    }
    
    
    func addJoinedUser(userID: String) {
        joinedUsers.append(userID)
        giveawayRef?.updateData([
            "joinedUsers": FieldValue.arrayUnion([userID])
        ])
        
    }
    
    func addLikedUser(userID: String) {
        likedUsers.append(userID)
        giveawayRef?.updateData([
            "likedUser": FieldValue.arrayUnion([userID])
        ])
    }
    
    
    
    func addComment(comment: Comment) {
        comments.append(comment)
        //update database
        let commentData  = [
            "userID": comment.userID,
            "commentText": comment.commentText,
            "commentDate": Timestamp(date: comment.commentDate),
            "numberOfLikes": comment.numberOfLikes
        ] as [String : Any]
        giveawayRef?.updateData([
            "comments": FieldValue.arrayUnion([commentData])
        ])
    }
    
    func isExpired () -> Bool {
        //how to check expiration
        return true
    }
    
    func pickWinners () {
        //randomly select winners
        if maxNumWinners >= joinedUsers.count {
            let moneyUnit: Float = donationAmount/Float(joinedUsers.count)
            for winnerID in joinedUsers {
                let winnerUser = User(userID: winnerID)
                winnerUser.getMoney(donationMoney: moneyUnit)
            }
            
        } else {
            let moneyUnit: Float = donationAmount/Float(maxNumWinners)
            var joinedUsersCopy: [String] = joinedUsers.shuffled()
            for _ in 0..<maxNumWinners {
                let winnerID: String = joinedUsersCopy.randomElement() ?? "nil"
                let winnerUser = User(userID: winnerID)
                winnerUser.getMoney(donationMoney: moneyUnit)
                
                joinedUsersCopy = joinedUsersCopy.filter { $0 != winnerID }
                joinedUsersCopy = joinedUsersCopy.shuffled()
            }
        }
        //update database
    }
    
    func addTodb() {
        var commentsData: [[String : Any]] = []
        for comment in comments {
            let commentData  = [
                "userID": comment.userID,
                "commentText": comment.commentText,
                "commentDate": Timestamp(date: comment.commentDate),
                "numberOfLikes": comment.numberOfLikes
            ] as [String : Any]
            commentsData.append(commentData)
        }
        
        let giveawayData = [
            "userID": userID,
            "postedTime": Timestamp(date: postedTime),
            "expirationTime": Timestamp(date: expirationTime),
            "caption": caption,
            "maxNumWinners": maxNumWinners,
            "donationAmount": donationAmount,
            "joinedUsers": joinedUsers,
            "likedUsers": likedUsers,
            "comments": commentsData, //need to be fixed
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
