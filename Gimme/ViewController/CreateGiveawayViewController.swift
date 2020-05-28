//
//  CreateGiveawayViewController.swift
//  Gimme
//
//  Created by Stephen Boyle on 4/25/20.
//  Copyright © 2020 Stephen Boyle. All rights reserved.
//

import UIKit
import Firebase

class CreateGiveawayViewController: UIViewController {
    
    @IBOutlet weak var importImage: UIImageView!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var endOfGiveaway: UIDatePicker!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var numOfWinnersLabel: UILabel!
    @IBOutlet weak var numWinnersTF: UITextField!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var amountofMoneyTF: UITextField!
    
    var currUserID: String?
    var currUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
        
        descriptionLabel.textColor = UIColor.white
        
        descriptionTV.textColor = UIColor.white
        descriptionTV.backgroundColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
        
        descriptionTV.layer.borderWidth = 2.0
        descriptionTV.layer.borderColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1).cgColor
        descriptionTV.font = UIFont(name: "Avenir-Roman", size: 15)
        descriptionTV.clipsToBounds = true
        descriptionTV.layer.cornerRadius = 10.0
        
        numWinnersTF.layer.borderWidth = 2.0
        numWinnersTF.layer.borderColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1).cgColor
        numWinnersTF.backgroundColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
        numWinnersTF.font = UIFont(name: "Avenir-Roman", size: 20)
        numWinnersTF.textColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1)
        numWinnersTF.clipsToBounds = true
        numWinnersTF.layer.cornerRadius = 10.0
        
        
        amountofMoneyTF.attributedPlaceholder = NSAttributedString(string: "$0.00",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1)])
        amountofMoneyTF.addTarget(self, action: #selector(myTextFieldDidChange(_:)), for: .editingChanged)
        amountofMoneyTF.layer.borderWidth = 2.0
        amountofMoneyTF.layer.borderColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1).cgColor
        amountofMoneyTF.backgroundColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
        amountofMoneyTF.font = UIFont(name: "Avenir-Roman", size: 20)
        amountofMoneyTF.textColor = UIColor(red: 0.427, green: 0.788, blue: 0.651, alpha: 1)
        amountofMoneyTF.clipsToBounds = true
        amountofMoneyTF.layer.cornerRadius = 10.0
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func myTextFieldDidChange(_ textField: UITextField) {

        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }
    
    
    @IBAction func postPressed(_ sender: Any) {
        let giveawayAmount: Float = Float(amountofMoneyTF.text!)!
        let numWinners: Int = Int(numWinnersTF.text!)!

        let giveaway = Giveaway(userID: currUserID!, postedTime: Date(), expirationTime: endOfGiveaway.date, caption: descriptionTV.text, donationAmount: giveawayAmount, maxNumWinners: numWinners)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension String {

    // formatting text for currency textField
    func currencyInputFormatting() -> String {

        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2

        var amountWithPrefix = self

        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")

        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))

        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }

        return formatter.string(from: number)!
    }
}
