//
//  HomeViewController.swift
//  BizGadget
//
//  Created by Yogesh Date on 18/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
        
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var myTable: UITableView!
    
    var aryHome: [String] = ["All","Pizza","Cafe","Ice cream","All","Pizza","Cafe","Ice cream"]
    var aryCategory:[category_data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Owner
        getNotificationName()
        setDelegate()
        getCategory()
    }
    
    func setDelegate()  {
        myTable.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "homeIdentifier")
        collectionView.dataSource = self
        collectionView.delegate = self
        myTable.dataSource = self
        myTable.delegate = self
    }
    
    func getCategory()  {
        PROGRESS_SHOW(view: self.view)
        Webservices.shared.categoryList(success: {
            ary in
            self.aryCategory = ary
            self.collectionView.reloadData()
            PROGRESS_HIDE()
        }, failure: {
            error in
            PROGRESS_ERROR(view: self.view, error: error)
        })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnLeftCLicked(_ sender: UIBarButtonItem) {
       NotificationCenter.default.post(name: NOTIFICATION_MENU_OWNER, object: nil)
    }
    
    func getNotificationName() {
        // Owner
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getNotificationName(notification:)),
                                               name: NOTIFICATION_PROFILE_OWNER,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getNotificationName(notification:)),
                                               name: NOTIFICATION_FEEDBACK_OWNER,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getNotificationName(notification:)),
                                               name: NOTIFICATION_ABOUT_OWNER,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getNotificationName(notification:)),
                                               name: NOTIFICATION_CONTACT_OWNER,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getNotificationName(notification:)),
                                               name: NOTIFICATION_WORK_OWNER,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getNotificationName(notification:)),
                                               name: NOTIFICATION_CONDITION_OWNER,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getNotificationName(notification:)),
                                               name: NOTIFICATION_POLICY_OWNER,
                                               object: nil)
        
    }//
    
    @objc func getNotificationName(notification: NSNotification) {
        
        if notification.name == NOTIFICATION_PROFILE_OWNER {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Customer", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            NotificationCenter.default.removeObserver(NOTIFICATION_PROFILE_OWNER)
            self.navigationController?.pushViewController(newViewController, animated: true)

        }
        if notification.name == NOTIFICATION_FEEDBACK_OWNER {
            let storyboard: UIStoryboard = UIStoryboard(name: "Customer", bundle: nil)
            let feedBack = storyboard.instantiateViewController(withIdentifier: "FeedsViewController") as! FeedsViewController
            self.navigationController?.pushViewController(feedBack, animated: true)
            NotificationCenter.default.removeObserver(NOTIFICATION_FEEDBACK_OWNER)
        }
        if notification.name == NOTIFICATION_ABOUT_OWNER {
            let storyboard: UIStoryboard = UIStoryboard(name: "Customer", bundle: nil)
            let feedBack = storyboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
            self.navigationController?.pushViewController(feedBack, animated: true)
            NotificationCenter.default.removeObserver(NOTIFICATION_ABOUT_OWNER)
        }
        if notification.name == NOTIFICATION_CONTACT_OWNER {
            let storyboard: UIStoryboard = UIStoryboard(name: "Customer", bundle: nil)
            let feedBack = storyboard.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
            self.navigationController?.pushViewController(feedBack, animated: true)
            NotificationCenter.default.removeObserver(NOTIFICATION_CONTACT_OWNER)
        }
        if notification.name == NOTIFICATION_WORK_OWNER {
            let storyboard: UIStoryboard = UIStoryboard(name: "Customer", bundle: nil)
            let feedBack = storyboard.instantiateViewController(withIdentifier: "WorkViewController") as! WorkViewController
            self.navigationController?.pushViewController(feedBack, animated: true)
            NotificationCenter.default.removeObserver(NOTIFICATION_WORK_OWNER)
        }
        if notification.name == NOTIFICATION_CONDITION_OWNER {
            let storyboard: UIStoryboard = UIStoryboard(name: "Customer", bundle: nil)
            let feedBack = storyboard.instantiateViewController(withIdentifier: "TermsConditionViewController") as! TermsConditionViewController
            self.navigationController?.pushViewController(feedBack, animated: true)
            NotificationCenter.default.removeObserver(NOTIFICATION_CONDITION_OWNER)
        }
        if notification.name == NOTIFICATION_POLICY_OWNER {
            let storyboard: UIStoryboard = UIStoryboard(name: "Customer", bundle: nil)
            let feedBack = storyboard.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
            self.navigationController?.pushViewController(feedBack, animated: true)
            NotificationCenter.default.removeObserver(NOTIFICATION_POLICY_OWNER)
        }
        NotificationCenter.default.post(name: NOTIFICATION_MENU_OWNER, object: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btnSegmentClicked(_ sender: YDSegmentedControl) {
        
    }
    
    
    
    // Home Page
}

extension HomeViewController : UICollectionViewDataSource, UICollectionViewDelegate {
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return aryCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "cellCAtegory"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CategoryCollectionViewCell
        let obj = self.aryCategory[indexPath.row]
        cell.lblNmae.text = obj.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedName = aryCategory[indexPath.row]
        print("\n selectedName = \(selectedName.name ?? "Not")")
    }
    
}

extension HomeViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aryHome.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cellIdentifier = "homeIdentifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HomeTableViewCell
        
        
        cell.OptionDelegate = self
        cell.LikeDelegate = self
        cell.FavouriteDelegate = self
        cell.PhoneDelegate = self
        cell.LocationDelegate = self
        cell.ShareDelegate = self
        cell.AddPersonDelegate = self
        
        return cell
    }
}



extension HomeViewController : OptionButtonDelegate,LikeButtonDelegate, FavouriteButtonDelegate, PhoneButtonDelegate, LocationButtonDelegate, ShareButtonDelegate, AddPersonDelegate {
    
    func didPressOptionButton(cell: HomeTableViewCell) {
        if let indexPath = myTable.indexPath(for: cell) {
            print("didPressOptionButton =\(indexPath.row)")
        }
    }
    
    func didPressLikeButton(cell: HomeTableViewCell) {
        if let indexPath = myTable.indexPath(for: cell) {
            print("didPressLikeButton =\(indexPath.row)")
        }
    }
    
    func didPressFavouriteButton(cell: HomeTableViewCell) {
        if let indexPath = myTable.indexPath(for: cell) {
            print("didPressFavouriteButton = \(indexPath.row)")
        }
    }
    
    func didPressPhoneButton(cell: HomeTableViewCell) {
        if let indexpath = myTable.indexPath(for: cell) {
            print("didPressPhoneButton \(indexpath.row)")
        }
    }
    
    func didPressLocationButton(cell: HomeTableViewCell) {
        if let indexPath = myTable.indexPath(for: cell){
            print("didPressLocationButton =\(indexPath.row)")
        }
    }
    
    func didPressShareButton(cell: HomeTableViewCell) {
        if let indexPath = myTable.indexPath(for: cell){
            print("didPressShareButton =\(indexPath.row)")
        }
    }
    
    func didPressAddButton(cell: HomeTableViewCell) {
        if let indexPath = myTable.indexPath(for: cell){
            print("didPressAddButton =\(indexPath.row)")
        }
    }
}




