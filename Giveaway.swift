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
    
    var giveawayData: GiveawayData
    var giveawayID: String
    
    init(userID: String, username: String, postedTime: Date, expirationTime: Date, caption: String, donationAmount: Float, maxNumWinners: Int) {
        self.giveawayID = UUID.init().uuidString
        self.giveawayData = GiveawayData(userID: userID, username: username, postedTime: postedTime, expirationTime: expirationTime, caption: caption, maxNumWinners: maxNumWinners, donationAmount: donationAmount)
        addTodb()
    }
    
    init(giveawayID: String) {
        self.giveawayID = giveawayID
        self.giveawayData = GiveawayData()
    }
    
    func addJoinedUser(userID: String) {
        giveawayData.joinedUsers.append(userID)
        let giveawayRef = db.collection("giveaways").document(giveawayID)
        giveawayRef.updateData([
            "joinedUsers": FieldValue.arrayUnion([userID])
        ])
    }
    
    func addLikedUser(userID: String) {
        giveawayData.likedUsers.append(userID)
        let giveawayRef = db.collection("giveaways").document(giveawayID)
        giveawayRef.updateData([
            "likedUsers": FieldValue.arrayUnion([userID])
        ])
    }
    
    
    func addComment(comment: Comment) {
        giveawayData.comments.append(comment)
        //update database
        let giveawayRef = db.collection("giveaways").document(giveawayID)
        let commentData  = [
            "userID": comment.userID,
            "username": comment.username,
            "commentText": comment.commentText,
            "commentDate": Timestamp(date: comment.commentDate),
            "numberOfLikes": comment.numberOfLikes
        ] as [String : Any]
        giveawayRef.updateData([
            "comments": FieldValue.arrayUnion([commentData])
        ])
    }
    
    func isExpired () -> Bool {
        //how to check expiration
        return true
    }
    
    func pickWinners () {
        //randomly select winners
        var winners = [String]()
        if giveawayData.maxNumWinners >= giveawayData.joinedUsers.count {
            let moneyUnit: Float = giveawayData.donationAmount/Float(giveawayData.joinedUsers.count)
            for winnerID in giveawayData.joinedUsers {
                winners.append(winnerID)
                let winnerUser = User(userID: winnerID)
                winnerUser.getMoney(donationMoney: moneyUnit)
            }
            
        } else {
            let moneyUnit: Float = giveawayData.donationAmount/Float(giveawayData.maxNumWinners)
            var joinedUsers: [String] = giveawayData.joinedUsers.shuffled()
            for _ in 0..<giveawayData.maxNumWinners {
                let winnerID: String = joinedUsers.randomElement() ?? "nil"
                winners.append(winnerID)
                let winnerUser = User(userID: winnerID)
                winnerUser.getMoney(donationMoney: moneyUnit)
                
                joinedUsers = joinedUsers.filter { $0 != winnerID }
                joinedUsers = joinedUsers.shuffled()
            }
        }
        //update database
        let giveawayRef = db.collection("giveaways").document(giveawayID)
        giveawayRef.updateData(["winners": winners])
    }
    
    func addTodb() {
        var commentsData: [[String : Any]] = []
        for comment in giveawayData.comments {
            let commentData  = [
                "userID": comment.userID,
                "username": comment.username,
                "commentText": comment.commentText,
                "commentDate": Timestamp(date: comment.commentDate),
                "numberOfLikes": comment.numberOfLikes
            ] as [String : Any]
            commentsData.append(commentData)
        }
        
        let giveaway_data = [
            "userID": giveawayData.userID,
            "username": giveawayData.username,
            "postedTime": Timestamp(date: giveawayData.postedTime),
            "expirationTime": Timestamp(date: giveawayData.expirationTime),
            "caption": giveawayData.caption,
            "maxNumWinners": giveawayData.maxNumWinners,
            "donationAmount": giveawayData.donationAmount,
            "joinedUsers": giveawayData.joinedUsers,
            "likedUsers": giveawayData.likedUsers,
            "comments": commentsData, //need to be fixed
            "winners": giveawayData.winners
            ] as [String : Any]
        db.collection("giveaways").document(giveawayID).setData(giveaway_data)
            {err in
            if let err = err {
                print("Error adding giveaway: \(err)")
            }
            }
        }
    func readFromDB(completion: @escaping (GiveawayData) -> Void) {
        let giveawayRef = db.collection("giveaways").document(giveawayID)
        giveawayRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                self.giveawayData.userID = dataDescription!["userID"] as! String
                self.giveawayData.username = dataDescription!["username"] as! String
                var timestamp = dataDescription!["postedTime"] as! Timestamp
                var date = Date(timeIntervalSince1970: TimeInterval(timestamp.seconds))
                self.giveawayData.postedTime = date
                timestamp = dataDescription!["expirationTime"] as! Timestamp
                date = Date(timeIntervalSince1970: TimeInterval(timestamp.seconds))
                self.giveawayData.expirationTime = date
                self.giveawayData.caption = dataDescription!["caption"] as! String
                self.giveawayData.maxNumWinners = dataDescription!["maxNumWinners"] as! Int
                self.giveawayData.donationAmount = dataDescription!["donationAmount"] as! Float
                self.giveawayData.joinedUsers = dataDescription!["joinedUsers"] as! [String]
//                let  likedUsers = dataDescription!["likedUsers"] as! [String]
//                for like in likedUsers {
//                    self.giveawayData.likedUsers.append(like)
//                }
                self.giveawayData.likedUsers = dataDescription!["likedUsers"] as! [String]
                self.giveawayData.winners = dataDescription!["winners"] as! [String]
                
                let commentsData = dataDescription!["comments"] as! [[String : Any]]
                var comments: [Comment] = []
                for comment in commentsData {
                    comments.append(Comment(userID: comment["userID"] as! String,username: comment["username"] as! String, commentText: comment["commentText"] as! String, commentDate: comment["commentDate"] as! Date, numberOfLikes: comment["numberOfLikes"] as! Int))
                }
                self.giveawayData.comments = comments
                completion(self.giveawayData)

            } else {
                print("Document does not exist. inside FeedData class")
            }
        }
    }
}
