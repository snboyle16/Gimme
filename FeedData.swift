//
//  FeedData.swift
//  Gimme
//
//  Created by Hossein Shirinabadi on 4/25/20.
//  Copyright © 2020 Stephen Boyle. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Firebase


class FeedData {
    
    var user: User
    var giveaways: [Giveaway]
    
    init(user: User) {
        self.user = user
        giveaways = []
//        updateFeed()
    }
//    func readDb() {
//        let userRef = db.collection("users").document(userID)
////        var doc: DocumentSnapshot
//        userRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let data = document.data()
//                self.following = data!["following"] as! [String]
//            } else {
//                print("Document does not exist. inside FeedData class")
//            }
//        }
//    }
//    func updateFeed() {
//        //pull the data from database
////        var giveawayIDs: [String] = []
//        for user in user.userData.following? {
//            var giveawayIDs: [String] = []
//            let userRef = db.collection("users").document(user)
//            userRef.getDocument { (document, error) in
//                if let document = document, document.exists {
//                    let dataDescription = document.data()
//                    giveawayIDs = dataDescription!["giveaways"] as! [String]
//                } else {
//                    print("Document does not exist. inside FeedData class")
//                }
//            }
//            for giveawayID in giveawayIDs {
//                giveaways.append(Giveaway(giveawayID: giveawayID))
//            }
//        }
////        for giveawayID in giveawayIDs {
////            giveaways.append(Giveaway(giveawayID: giveawayID))
////        }
//    }
}
