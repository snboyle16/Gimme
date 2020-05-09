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
    }
}
