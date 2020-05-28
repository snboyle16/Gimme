//
//  TrendingViewController.swift
//  Gimme
//
//  Created by Stephen Boyle on 4/26/20.
//  Copyright © 2020 Stephen Boyle. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {

    var giveaways = [Giveaway]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var trendingTableView: UITableView!
    
    var currUserID: String?
    var currUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trendingTableView.backgroundColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
        // Do any additional setup after loading the view.
        
//        var uidList = [String]()
//        var expireddates = [Date]()
//        var postedTime = [Date]()
//        let captions: [String] = ["I want to help you all out. I am going to be giving out $100 to 5 people", "In 24 hours, I will be doing a $1,000 giveaway", "I love helping people", "I was inspired by Bill Pulte to give money to people who need it more than I do", "Come getyo moneyyyyy", "I want to help you all out. I am going to be giving out $100 to 5 people", "In 24 hours, I will be doing a $1,000 giveaway", "I love helping people", "I was inspired by Bill Pulte to give money to people who need it more than I do", "Come getyo moneyyyyy", "I was inspired by Bill Pulte to give money to people who need it more than I do", "Come getyo moneyyyyy"]
//        let donationAmount: [Float] = [1000.0, 100.0, 50.0, 250.0, 400.0,300,100,10,600, 800, 40, 50]
//        let maxWinners: [Int] = [3,5, 3,2,1,5,6,3,7,4,7,2]
//
//        for n in 0...11 {
//            uidList.append(UUID().uuidString)
//            expireddates.append(Date())
//            postedTime.append(Date())
//            giveaways.append(Giveaway(userID: UUID().uuidString, postedTime: Date(), expirationTime: Date(), caption: captions[n], donationAmount: donationAmount[n], maxNumWinners: maxWinners[n]))
//        }
//        print("giveaways")
//        print(giveaways)
    }
    
    func setupTableView() {
        
        trendingTableView.delegate = self
        trendingTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return giveaways.count
    }
    
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("FeedPostTableViewCell", owner: self, options: nil)?.first as! FeedPostTableViewCell
        print(cell)
        cell.amountLabel.text = String(format:"%f", giveaways[indexPath.row].giveawayData.donationAmount)
        cell.descriptionLabel.text = giveaways[indexPath.row].giveawayData.caption
        cell.profilePicButton.imageView?.image = UIImage(named: "tony")
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm"
        cell.timeLeft.text = df.string(from: giveaways[indexPath.row].giveawayData.expirationTime)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
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
