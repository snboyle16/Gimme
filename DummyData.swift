//
//  DummyData.swift
//  Gimme
//
//  Created by Hossein Shirinabadi on 4/25/20.
//  Copyright © 2020 Stephen Boyle. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Firebase



class DummyData {
    let demoUserID: String = "FKYd4mjedIdsQXRwIsynQhx93YL2"
    let demoUserEmail: String = "sboyle9338@gmail.com"
    
    let donorUsers = [
        "tonystark",
        "billgates",
        "jeffbezos",
        "markzuckerberg",
        "elonmusk"
    ]
    
    let giveawayCaption = "Giving away some money cuz I'm rich"
    let donationAmount: Float = 100.0
    let numWinners = 5
    let expirationTime = Date(timeIntervalSinceNow: 86400.0)
    var users: [User] = []
    
    init() {
        addDonorUsers()
        addGiveaway()
        addDemoUser()
    }
    
    func addDemoUser() {
        let demoUser = User(userID: demoUserID, email: demoUserEmail, username: "stephen")
        for user in users {
            demoUser.follow(userID: user.userID)
        }
    }
    
    func addDonorUsers() {
        for user in donorUsers {
            users.append(User(username: user, email: user+"@icloud.com"))
        }
    }
    
    func addGiveaway() {
        for user in users {
            user.addGiveaway(caption: giveawayCaption, donationAmount: donationAmount, maxNumWinners: numWinners, expirationTime: expirationTime)
        }
        
    }
    
}



