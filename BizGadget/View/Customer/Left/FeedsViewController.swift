//
//  FeedsViewController.swift
//  BizGadget
//
//  Created by Yogesh Date on 17/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class FeedsViewController: UIViewController {

    @IBOutlet weak var myTable: UITableView!
    
    var aryFeeds: [String] = ["All","Pizza", "Cafe", "Ice cream","All","Pizza", "Cafe", "Ice cream"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTable.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "homeIdentifier")
        self.myTable.dataSource = self
        self.myTable.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnFeedsClicked(_ sender: UIButton) {
        
    }

}



extension FeedsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return aryFeeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIfentifier = "homeIdentifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIfentifier, for: indexPath) as! HomeTableViewCell
        
        
        return cell
    }
    
    
}

