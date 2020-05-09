//
//  FeedTableViewController.swift
//
//
//  Created by Stephen Boyle on 4/25/20.
//

import UIKit
import UIKit
import CoreData
import Firebase

class FeedTableViewController: UITableViewController {
    
    var giveaways = [Giveaway]()
    var currUserID: String?
    var currUser: User?
    var firstLoadDone = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        self.tableView?.backgroundColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
        
        
        firstLoadDone = true
        
        currUser = User(userID: currUserID!)
        currUser!.readFromDB { userdata in
            self.updateFeed()
        }
        
//         navigationController?.navigationBar.barTintColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 0)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        DispatchQueue.main.async {
//            let feedData = currUser.feedData
//            self.giveaways = feedData.giveaways
//        }
<<<<<<< HEAD
=======
        var uidList = [String]()
        var expireddates = [Date]()
        var postedTime = [Date]()
        let captions: [String] = ["I want to help you all out. I am going to be giving out $100 to 5 people", "In 24 hours, I will be doing a $1,000 giveaway", "I love helping people", "I was inspired by Bill Pulte to give money to people who need it more than I do", "Come getyo moneyyyyy", "I want to help you all out. I am going to be giving out $100 to 5 people", "In 24 hours, I will be doing a $1,000 giveaway", "I love helping people", "I was inspired by Bill Pulte to give money to people who need it more than I do", "Come getyo moneyyyyy", "I was inspired by Bill Pulte to give money to people who need it more than I do", "Come getyo moneyyyyy"]
        let donationAmount: [Float] = [1000.0, 100.0, 50.0, 250.0, 400.0,300,100,10,600, 800, 40, 50]
        let maxWinners: [Int] = [3,5, 3,2,1,5,6,3,7,4,7,2]
        
        for n in 0...11 {
            uidList.append(UUID().uuidString)
            expireddates.append(Date())
            postedTime.append(Date())
            giveaways.append(Giveaway(userID: UUID().uuidString, postedTime: Date(), expiredTime: Date(), caption: captions[n], donationAmount: donationAmount[n], maxNumWinners: maxWinners[n]))
        }
        print("giveaways")
        print(giveaways)
        
>>>>>>> ca0fd6c89835972572d61cf5aa0a4c6c31d1370e
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        if firstLoadDone {
            firstLoadDone = false
        } else {
            updateFeed()
        }

    }
    
    func updateFeed() {
        giveaways = []
        for userID in currUser!.userData.following {
            let userRef = db.collection("users").document(userID)
            userRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data()
                    let giveawayIDs = dataDescription!["giveaways"] as! [String]
                    for giveawayID in giveawayIDs {
                        let giveaway = Giveaway(giveawayID: giveawayID)
                        giveaway.readFromDB { giveawayData in
                            self.giveaways.append(giveaway)
                            self.tableView.reloadData()
                        }
                    }
                } else {
                    print("Document does not exist. inside FeedData class")
                }
            }
        }
    }
    

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
<<<<<<< HEAD
//        print("count: ")
//        print(giveaways.count)
=======
>>>>>>> ca0fd6c89835972572d61cf5aa0a4c6c31d1370e
        return giveaways.count
    }
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("FeedPostTableViewCell", owner: self, options: nil)?.first as! FeedPostTableViewCell
        cell.amountLabel.text = String(format:"%f", giveaways[indexPath.row].giveawayData.donationAmount)
        cell.descriptionLabel.text = giveaways[indexPath.row].giveawayData.caption + "\n" + giveaways[indexPath.row].giveawayData.userID
        cell.profilePicButton.imageView?.image = UIImage(named: "tony")
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm"
        cell.timeLeft.text = df.string(from: giveaways[indexPath.row].giveawayData.expirationTime)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
