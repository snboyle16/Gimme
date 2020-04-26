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
    
    var userID: String
    var giveaways: [Giveaway]
    var following: [String]
    
    init(userID: String) {
        self.userID = userID
        giveaways = []
        following = []
        updateFeed()
    }
    func readDb() {
        let userRef = db.collection("users").document(userID)
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                self.following = dataDescription!["following"] as! [String]
            } else {
                print("Document does not exist. inside FeedData class")
            }
        }
    }
    func updateFeed() {
        //pull the data from database
        
        readDb()
        var giveawayIDs: [String] = []
        for user in following {
            let userRef = db.collection("users").document(user)
            userRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data()
                    giveawayIDs += dataDescription!["giveaways"] as! [String]
                } else {
                    print("Document does not exist. inside FeedData class")
                }
            }
        }
        for giveawayID in giveawayIDs {
            giveaways.append(Giveaway(giveawayID: giveawayID))
        }
    }
}
