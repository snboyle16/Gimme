//
//  Structures.swift
//  Gimme
//
//  Created by Hossein Shirinabadi on 4/25/20.
//  Copyright © 2020 Stephen Boyle. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Firebase

struct Comment {
    var userID: String
    var commentText: String
    var commentDate: Date
    var numberOfLikes: Int
}
