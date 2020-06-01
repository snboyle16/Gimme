//
//  FeedTableViewController.swift
//
//
//  Created by Stephen Boyle on 4/25/20.
//

import UIKit
import CoreData
import Firebase
let storage = Storage.storage()
class FeedTableViewController: UITableViewController {
    
    var giveaways = [Giveaway]()
    var images = [UIImage]()
    var numLikes = [Int]()
    var numJoined = [Int]()
    var numComments = [Int]()
    var userLiked  = [Bool]()
    var userJoined = [Bool]()
    let mySegmentedControl = UISegmentedControl(items: ["Following","For You"])

    var firstLoadDone = false
    override func viewDidLoad() {
        super.viewDidLoad()
//        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
//        navigationItem.leftBarButtonItem = backButton
//        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.navigationBar.topItem?.hidesBackButton = true
//        self.navigationItem.leftBarButtonItem = nil
//        self.navigationItem.hidesBackButton = true
//        self.navigationItem.setHidesBackButton(true, animated: false)
        
        
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        self.tableView?.backgroundColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        
        // Adding a segment control switch at top of the Home page
        
        mySegmentedControl.selectedSegmentIndex = 0
        mySegmentedControl.addTarget(self, action: #selector(FeedTableViewController.indexChanged(_:)), for: .valueChanged)
        navigationItem.titleView = mySegmentedControl
        
        
//        let navImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
//        navImageView.contentMode = .scaleAspectFit
//        let navImage = UIImage(named: "Comment")
//        navImageView.image = navImage
//        navigationItem.titleView = navImageView
        
//         navigationController?.navigationBar.barTintColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 0)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        DispatchQueue.main.async {
//            let feedData = currUser.feedData
//            self.giveaways = feedData.giveaways
//        }
        firstLoadDone = true
        updateFeed_Following()
//        currUser = User(userID: currUserID!)

//        let usernames: [String] = ["tonystark","billgates","marcfisher","tombrady","lionelmessi","jamescorden","davidbeckham","trevornoah","lebronjames","barackobama"]
//          let captions: [String] = ["I want to help you all out. I am going to be giving out $100 to 5 people", "In 24 hours, I will be doing a $1,000 giveaway", "I love helping people", "I was inspired by Bill Pulte to give money to people who need it more than I do", "Come getyo moneyyyyy", "I want to help you all out. I am going to be giving out $100 to 5 people", "In 24 hours, I will be doing a $1,000 giveaway", "I love helping people", "I was inspired by Bill Pulte to give money to people who need it more than I do", "Come getyo moneyyyyy"]
//          let donationAmount: [Float] = [100.0, 1000.0, 50.0, 250.0, 400.0,300,100,10,600, 800]
//          let maxWinners: [Int] = [5,4,3,2,1,5,6,3,7,4]
//
//
//          for i in 0...9 {
//              let user = User(userID: UUID().uuidString, email: usernames[i]+"@gimme.com", username: usernames[i])
//              user.addTodb {
//                  self.currUser?.follow(userID: user.userID)
//                  let currentDate = Date()
//                  var dateComponent = DateComponents()
//                  dateComponent.day = 1
//                  let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
//                  user.addGiveaway(caption: captions[i], donationAmount: donationAmount[i], maxNumWinners: maxWinners[i], expirationTime: futureDate!)
//              }
//          }
        
          
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//       super.viewWillAppear(animated)
//        if firstLoadDone {
//            firstLoadDone = false
//        } else {
//            if (mySegmentedControl.selectedSegmentIndex == 0)  {
//                updateFeed_Following()
//            } else {
//                updateFeed_ForYou()
//            }
//
//        }
//
//    }
    
    func updateFeed_Following() {
        giveaways = []
        images = []
        numComments =  []
        numLikes = []
        numJoined = []
        userLiked = []
        userJoined = []
        self.tableView.reloadData()
        for userID in currUser!.userData.following {
            let userRef = db.collection("users").document(userID)
            userRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data()
                    let giveawayIDs = dataDescription!["giveaways"] as! [String]
                    for giveawayID in giveawayIDs {
                        let giveaway = Giveaway(giveawayID: giveawayID)
                        giveaway.readFromDB { giveawayData in
                            var image: UIImage!
                            let storageRef = storage.reference(withPath: "profile_pictures/\(giveaway.giveawayData.userID).png")
                            storageRef.getData(maxSize: 4*400*400) {  (data,error) in
                                
                                if let data = data {
                                    image = UIImage(data: data)
                                    self.images.append(image)
                                    self.giveaways.append(giveaway)
                                    self.numLikes.append(giveaway.giveawayData.likedUsers.count)
                                    self.numJoined.append(giveaway.giveawayData.joinedUsers.count)
                                    self.numComments.append(giveaway.giveawayData.comments.count)
                                    if (giveaway.giveawayData.joinedUsers.contains(currUser.userID)) {
                                        self.userJoined.append(true)
                                    } else {
                                        self.userJoined.append(false)
                                    }
                                    if (giveaway.giveawayData.likedUsers.contains(currUser.userID)) {
                                        self.userLiked.append(true)
                                    } else {
                                        self.userLiked.append(false)
                                    }
                                    self.tableView.reloadData()
                                } else {
                                    print(error!)
                                }
                                
                            }
                        }
                    }
                } else {
                    print("Document does not exist. inside FeedData class")
                }
            }
        }
    }
    
    func updateFeed_ForYou() {
        giveaways = []
        images = []
        numComments =  []
        numLikes = []
        numJoined = []
        userLiked = []
        userJoined = []
        self.tableView.reloadData()
        db.collection("giveaways").order(by: "username").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let dataDescription = document.data()
                    let userID = dataDescription["userID"]  as? String
                    if (userID != currUser.userID && !currUser.userData.following.contains(userID ?? "")) {
                        let giveawayID = document.documentID
                        let giveaway = Giveaway(giveawayID: giveawayID)
                        giveaway.readFromDB { giveawayData in
                            var image: UIImage!
                            let storageRef = storage.reference(withPath: "profile_pictures/\(giveaway.giveawayData.userID).png")
                            storageRef.getData(maxSize: 4*400*400) {  (data,error) in
                                
                                if let data = data {
                                    image = UIImage(data: data)
                                    self.images.append(image)
                                    self.giveaways.append(giveaway)
                                    self.numLikes.append(giveawayData.likedUsers.count)
                                    self.numJoined.append(giveawayData.joinedUsers.count)
                                    self.numComments.append(giveawayData.comments.count)
                                    if (giveawayData.joinedUsers.contains(currUser.userID)) {
                                        self.userJoined.append(true)
                                    } else {
                                        self.userJoined.append(false)
                                    }
                                    if (giveawayData.likedUsers.contains(currUser.userID)) {
                                        self.userLiked.append(true)
                                    } else {
                                        self.userLiked.append(false)
                                    }
                                    self.tableView.reloadData()
                                } else {
                                    print(error!)
                                }
                                
                            }
                        }
                    }
                    
                }
            }
        }
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.updateFeed_Following()
        }
        if sender.selectedSegmentIndex == 1 {
            self.updateFeed_ForYou()
            
        }
        
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return giveaways.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
//        clickedGiveaway = giveaways[indexPath.row]
        
        performSegue(withIdentifier: "openComment", sender: self)
//        let giveaway = giveaways[indexPath.row]
        print(numLikes)
        print(userLiked)
        print("Double click")
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fadedGreen = UIColor.AppColors.Green.FadedGreen
        let backgroundGray = UIColor.AppColors.Gray.BackgroundGray
//        let fadedPurp = UIColor.AppColors.Purple.FadedPurp
        let cell = Bundle.main.loadNibNamed("FeedPostTableViewCell", owner: self, options: nil)?.first as! FeedPostTableViewCell
        
//        print(cell)
        
        let gimme = giveaways[indexPath.row].giveawayData
        
        cell.amountLabel.text = "$" + String(format:"%.2f", gimme.donationAmount)
        cell.amountLabel.font = UIFont(name: "Avenir-Roman", size: 24)
        cell.amountLabel.textColor = .white
        
        cell.usernameLabel.text = "@" + gimme.username
        cell.usernameLabel.font = UIFont(name: "Avenir-Roman", size: 16)
        cell.usernameLabel.textColor = .white
        
        cell.descriptionLabel.text = gimme.caption
        cell.descriptionLabel.font = UIFont(name: "Avenir-Roman", size: 18)
        cell.descriptionLabel.textColor = .white
        
//        cell.profilePicButton.imageView?.image = images[indexPath.row]
        
        cell.profilePicButton.setImage(images[indexPath.row], for: .normal)
        cell.profilePicButton.imageView?.layer.cornerRadius = cell.profilePicButton.bounds.height/2.0
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm"
        
        cell.timeLeft.text = df.string(from: gimme.expirationTime)
        cell.timeLeft.font = UIFont(name: "Avenir-Roman", size: 12)
        cell.timeLeft.textColor = .white
        
        cell.backGroundLabel.layer.masksToBounds = true
        cell.backGroundLabel.layer.cornerRadius = 15
        cell.backGroundLabel.backgroundColor = fadedGreen
        cell.contentView.sendSubviewToBack(cell.backGroundLabel)
        cell.contentView.backgroundColor = backgroundGray
        
        cell.numJoinLabel.textColor = .white
        cell.numCommentLabel.textColor = .white
        cell.numLikeLabel.textColor = .white
        
        cell.numJoinLabel.text = String(numJoined[indexPath.row])
        cell.numCommentLabel.text = String(numComments[indexPath.row])
        cell.numLikeLabel.text = String(numLikes[indexPath.row])
        
        
        changeButtonImage(button: cell.commentButton, color: .white)
        changeButtonImage(button: cell.likeButton, color: .white)
        changeButtonImage(button: cell.shareButton, color: .white)
        changeButtonImage(button: cell.joinButton, color: .white)
        
        
        if (userLiked[indexPath.row]) {
            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            changeButtonImage(button: cell.likeButton, color: .red)
            
        } else {
            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)

        }
        
        if (userJoined[indexPath.row]) {
            cell.joinButton.setImage(UIImage(systemName: "plus.square.fill"), for: .normal)
            
        } else {
            cell.joinButton.setImage(UIImage(systemName: "plus.square"), for: .normal)
        }
            
        
        
        
        
        
        //design cell
        cell.cellDelegate = self

        return cell
    }
    
    func changeButtonImage(button: UIButton, color: UIColor) {
        let imageView = button.imageView
        imageView?.image = button.imageView?.image?.withRenderingMode(.alwaysTemplate)
        imageView?.tintColor = color
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightOfRow = self.calculateHeight(inString: giveaways[indexPath.row].giveawayData.caption)
        if (heightOfRow > 144) {
            return heightOfRow * (heightOfRow / 144)
        } else {
            return 144 + heightOfRow * (heightOfRow / 144)
        }
    }
    
    func calculateHeight(inString:String) -> CGFloat {
        let messageString = inString
        let attributes : [NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont(name: "Avenir-Roman", size: 18)!]

        let attributedString = NSAttributedString(string: messageString, attributes: attributes)

        let rect = attributedString.boundingRect(with: CGSize(width: 300, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

        let requredSize = rect
        return requredSize.height
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "openComment" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let vc = segue.destination as! CommentViewController
                print(giveaways[indexPath.row].giveawayData)
                vc.giveaway = giveaways[indexPath.row]
            }
        }
    }

}
extension FeedTableViewController: CustomCellDelegate {
    
    func customcell(cell: FeedPostTableViewCell, didTappedThe button: UIButton?) {
        guard let indexPath = tableView.indexPath(for: cell) else  { return }
        let selectedGiveaway = self.giveaways[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as? FeedPostTableViewCell
        let newButton = cell!.contentView.viewWithTag(button?.tag ?? -1) as! UIButton
        
        switch button?.tag {
        case 4:
            print("comment pressed")
        case 1:
            
            if (userLiked[indexPath.row]) {
                numLikes[indexPath.row] -= 1
                cell?.numLikeLabel.text = String(numLikes[indexPath.row])
//                selectedGiveaway.addLikedUser(userID: currUser.userID)
//                self.tableView.reloadData()
                newButton.setImage(UIImage(systemName: "heart"), for: .normal)
                changeButtonImage(button: newButton, color: .white)
                userLiked[indexPath.row] = false
                print("disliked")
                
                
                
            } else {
                currUser.likeGiveaway(giveawayID: selectedGiveaway.giveawayID)
                numLikes[indexPath.row] += 1
                cell?.numLikeLabel.text = String(numLikes[indexPath.row])
//                self.tableView.reloadData()
                newButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                changeButtonImage(button: newButton, color: .red)
                userLiked[indexPath.row] = true
                print("liked")
                
            }
        case 2:
            if (userJoined[indexPath.row]) {
                numJoined[indexPath.row] -= 1
                cell?.numJoinLabel.text = String(numJoined[indexPath.row])
//                self.tableView.reloadData()
                newButton.setImage(UIImage(systemName: "plus.square"), for: .normal)
                userJoined[indexPath.row] = false
                print("user disjoined")
                
            } else {
                currUser.joinGiveaway(giveawayID: selectedGiveaway.giveawayID)
                numJoined[indexPath.row] += 1
                cell?.numJoinLabel.text = String(numJoined[indexPath.row])
                newButton.setImage(UIImage(systemName: "plus.square.fill"), for: .normal)
                userJoined[indexPath.row] = true
                print("user joined")
                
                // unjoin giveaway
            }
            
            
        case 3:
            print("share pressed")
        case .none:
            print("whatever")
        case .some(_):
            print("henlo")
        }
    }
    
    
}
