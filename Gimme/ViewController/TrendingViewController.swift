//
//  TrendingViewController.swift
//  Gimme
//
//  Created by Stephen Boyle on 4/26/20.
//  Copyright © 2020 Stephen Boyle. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var trendingTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        trendingTableView.backgroundColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
        // Do any additional setup after loading the view.
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
