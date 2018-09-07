//
//  CustomerHomeViewController.swift
//  BizGadget
//
//  Created by Yogesh Date on 13/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class CustomerHomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    
    var isNotification: Bool = false
    var aryHome: [String] = ["All","Pizza", "Cafe", "Ice cream","All","Pizza", "Cafe", "Ice cream"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Customer
        tableAdding()
        setDelegate()
        getNotification()
    }

    func tableAdding()  {
        homeTableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "homeIdentifier")
        homeTableView.dataSource = self
        homeTableView.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK : - Left Menue
    @IBAction func btn_LeftClicked(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: NOTIFICATION_MENU, object: nil)
    }
    
    func getNotification() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getNotification(notification:)),
                                               name: NOTIFICATION_PROFILE,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getNotification(notification:)),
                                               name: NOTIFICATION_FEEDBACK,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getNotification(notification:)),
                                               name: NOTIFICATION_ABOUT,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getNotification(notification:)),
                                               name: NOTIFICATION_CONTACT,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getNotification(notification:)),
                                               name: NOTIFICATION_WORK,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getNotification(notification:)),
                                               name: NOTIFICATION_CONDITION,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getNotification(notification:)),
                                               name: NOTIFICATION_POLICY,
                                               object: nil)
        
    }//
    
    @objc func getNotification(notification: NSNotification) {
        
        if notification.name == NOTIFICATION_PROFILE {
            performSegue(withIdentifier: "segueProfile", sender: nil)
            NotificationCenter.default.removeObserver(NOTIFICATION_PROFILE)
        }
        if notification.name == NOTIFICATION_FEEDBACK {
            performSegue(withIdentifier: "segueFeeds", sender: nil)//
            NotificationCenter.default.removeObserver(NOTIFICATION_FEEDBACK)
        }
        if notification.name == NOTIFICATION_ABOUT {
            performSegue(withIdentifier: "segueAbout", sender: nil)
            NotificationCenter.default.removeObserver(NOTIFICATION_ABOUT)
        }
        if notification.name == NOTIFICATION_CONTACT {
            performSegue(withIdentifier: "segueContact", sender: nil)
            NotificationCenter.default.removeObserver(NOTIFICATION_CONTACT)
        }
        if notification.name == NOTIFICATION_WORK {
            performSegue(withIdentifier: "segueWork", sender: nil)
            NotificationCenter.default.removeObserver(NOTIFICATION_WORK)
        }
        if notification.name == NOTIFICATION_CONDITION {
            performSegue(withIdentifier: "segueTerms", sender: nil)
            NotificationCenter.default.removeObserver(NOTIFICATION_CONDITION)
        }
        if notification.name == NOTIFICATION_POLICY {
            performSegue(withIdentifier: "seguePrivacy", sender: nil)
            NotificationCenter.default.removeObserver(NOTIFICATION_POLICY)
        }
        NotificationCenter.default.post(name: NOTIFICATION_MENU, object: nil)
    }//seguePrivacy
    
    
    
    
    // MARK :- intrest and favourites Button Drower
    @IBOutlet weak var viewIntrests: UIView!
    @IBOutlet weak var tableIntrests: UITableView!
    @IBOutlet weak var intrestesHight: NSLayoutConstraint!
    
    @IBOutlet weak var viewFavourites: UIView!
    @IBOutlet weak var tableFavorites: UITableView!
    @IBOutlet weak var favouritesHight: NSLayoutConstraint!

    var aryIntrest: [String] = ["All","Pizza", "Cafe", "Ice cream"]
    var aryFavourites: [String] = ["All","Pizza", "Cafe", "Ice cream"]
    var intrestesClicked:Bool = true
    var favouriteClicked: Bool = true
    
    func dropShadow(view: UIView, scale: Bool = true) {
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.shadowRadius = 2
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func setDelegate()  {
        tableIntrests.dataSource = self
        tableIntrests.delegate = self
        tableFavorites.dataSource = self
        tableFavorites.delegate = self
        intrestesHight.constant = 00
        favouritesHight.constant = 00
        dropShadow(view: viewIntrests)
        dropShadow(view: viewFavourites)
    }
    
    func intrestDrower()  {
        if intrestesClicked {
            self.intrestesHight.constant = 150
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        } else {
            self.intrestesHight.constant = 00
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
        intrestesClicked = !intrestesClicked
    }
    
    func favouritesDrower()  {
        if favouriteClicked {
            self.favouritesHight.constant = 150
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        } else {
            self.favouritesHight.constant = 00
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
        favouriteClicked = !favouriteClicked
    }
    
    @IBAction func btnIntrestClicked(_ sender: UIButton) {
        if !favouriteClicked {
            favouritesDrower()
        }
        intrestDrower()
    }
    
    @IBAction func btnFavouriteClicked(_ sender: UIButton) {
        if !intrestesClicked {
          intrestDrower()
        }
        favouritesDrower()
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueAddfied" {
            
        }
    }
    
    @IBAction func btnFlotingClicked(_ sender: BizGadgetButton) {
        performSegue(withIdentifier: "segueAddfied", sender: self)
    }
    
}// end class








extension CustomerHomeViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == homeTableView {
            return 115
        } else if tableView == tableIntrests {
            return 30
        } else {
            return 30
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == homeTableView {
            return aryHome.count
        } else if tableView == tableIntrests {
            return aryIntrest.count
        } else {
            return aryFavourites.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == homeTableView {
            
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
        } else if tableView == tableIntrests {
            let cellIdentifier = "IntrestCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            cell.textLabel?.text = self.aryIntrest[indexPath.row]
            
            return cell
            
        } else {
            
            let cellIdentifier = "FavouritesCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            cell.textLabel?.text = self.aryFavourites[indexPath.row]
            
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == homeTableView {
             let name = aryHome[indexPath.row]
            print("Home Data =\(name)")
        } else if tableView == tableIntrests {
            let name = aryIntrest[indexPath.row]
            self.intrestDrower()
            print("Name = \(name)")
        } else {
            let name = aryFavourites[indexPath.row]
            self.favouritesDrower()
            print("Name = \(name)")
        }
    }
}






extension CustomerHomeViewController : OptionButtonDelegate,LikeButtonDelegate, FavouriteButtonDelegate, PhoneButtonDelegate, LocationButtonDelegate, ShareButtonDelegate, AddPersonDelegate {
    
    func didPressOptionButton(cell: HomeTableViewCell) {
        
        if let indexPath = homeTableView.indexPath(for: cell) {
            print("didPressOptionButton =\(indexPath.row)")
            let editPopUp = self.storyboard?.instantiateViewController(withIdentifier: "EditDeleteViewController") as! EditDeleteViewController
            editPopUp.index = indexPath.row
            editPopUp.SelectedDelegate = self //SelectedOptionDelegate
            self.present(editPopUp, animated: true, completion: nil)
        }
    }
    
    func didPressLikeButton(cell: HomeTableViewCell) {
        if let indexPath = homeTableView.indexPath(for: cell) {
            print("didPressLikeButton =\(indexPath.row)")
        }
    }
    
    func didPressFavouriteButton(cell: HomeTableViewCell) {
        if let indexPath = homeTableView.indexPath(for: cell) {
            print("didPressFavouriteButton = \(indexPath.row)")
        }
    }
    
    func didPressPhoneButton(cell: HomeTableViewCell) {
        if let indexpath = homeTableView.indexPath(for: cell) {
            print("didPressPhoneButton \(indexpath.row)")
        }
    }
    
    func didPressLocationButton(cell: HomeTableViewCell) {
        if let indexPath = homeTableView.indexPath(for: cell){
            print("didPressLocationButton =\(indexPath.row)")
        }
    }
    
    func didPressShareButton(cell: HomeTableViewCell) {
        if let indexPath = homeTableView.indexPath(for: cell){
            print("didPressShareButton =\(indexPath.row)")
        }
    }
    
    func didPressAddButton(cell: HomeTableViewCell) {
        if let indexPath = homeTableView.indexPath(for: cell){
            print("didPressAddButton =\(indexPath.row)")
        }
    }
}




extension CustomerHomeViewController: SelectedOptionDelegate {
    
    func didSelectedOption(name: String, index: Int) {
        if name == ACTION_DELETE {
            print("\n\n Option = \(name) , Index =\(index)")
        }
        
        if name == ACTION_EDIT {
            print("\n\n Option = \(name), Index =\(index)")
        }
    }
    
    
    
}



