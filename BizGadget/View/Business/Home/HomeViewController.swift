//
//  HomeViewController.swift
//  BizGadget
//
//  Created by Yogesh Date on 18/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
        
    @IBOutlet weak var myTable: UITableView!
    
    var aryHome=[Feed]()
    var aryCategory:[category_data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Owner
        getNotificationName()
        setDelegate()
        getCategory()
        getAllTags()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    func getAllTags()  {
        
        let key = UserDefaults.standard.string(forKey: "authkey")
        guard let authKey = key else {
            return
        }
        let param:[String:String]=["AuthToken":authKey]
        
        PROGRESS_SHOW(view: self.view)
        Webservices.shared.businessFeeds(headerParam: param,
                                              success: {
                                                success in
                                                self.aryHome = success
                                                self.myTable.reloadData()
                                                PROGRESS_HIDE()
        }, failure: {
            error in
            PROGRESS_ERROR(view: self.view, error: error)
        })
        
    }
    func setDelegate()  {
        myTable.register(UINib(nibName: "BusinessCell", bundle: nil), forCellReuseIdentifier: "cellBusiness")
        myTable.dataSource = self
        myTable.delegate = self
    }
    
    func getCategory()  {

        guard let auth = GlobalData.shared.user?.accuracy else {
            return
        }
        let headerParam = ["AuthToken":auth]
        PROGRESS_SHOW(view: self.view)
        Webservices.shared.categoryList(header: headerParam,
                                        success: {
            ary in
            self.aryCategory = ary
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
    
    // Home Page

    @IBAction func btnAddClicked(_ sender: BizGadgetButton) {
        performSegue(withIdentifier: "segueAddfied", sender: self)
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
            
        let cellIdentifier = "cellBusiness"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BusinessCell
        let objName = aryHome[indexPath.row]
        cell.lblTitle.text = objName.detail ?? "null"
        cell.lblDate.text = objName.date ?? "null"
        var strLogo:String = IMAGE_URL+"\(objName.logo ?? " ")"
        strLogo.removeLast(11)
        print("STR =\(strLogo)")
        cell.imagePhoto.sd_setImage(with: URL(string:strLogo), placeholderImage: UIImage(named: "placeholder.png"))


        cell.OptionDelegate = self
        cell.OptionEdit = self

        
        return cell
    }
}



extension HomeViewController : BusinessDelegateDelegate,BusinessEditDelegate {
    
    func didPressDeleteBtn(cell : BusinessCell) {
        if let indexPath = myTable.indexPath(for: cell) {
            print("didPressFavouriteButton = \(indexPath.row)")
        
        
            let alert = UIAlertController(title: "Are you sure, you want to delete?",
                                          message:nil,
                                          preferredStyle: .alert)
        
            alert.addAction(UIAlertAction(title: "Yes",
                                          style: .default,
                                          handler: {
                                            handler in
                                            let name = self.aryHome[indexPath.row]
                                            self.deleteBusiness(id: name.id ?? 0)
            }))
            alert.addAction(UIAlertAction(title: "No",
                                          style: .default,
                                          handler: {
                                            handler in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func didPressEditBtn(cell: BusinessCell) {
        if let indexPath = myTable.indexPath(for: cell) {
            print("didPressFavouriteButton = \(indexPath.row)")
        }
    }
    
    func deleteBusiness(id:Int) {
        
        PROGRESS_SHOW(view: self.view)
        Webservices.shared.deleteBusinessFeed(id: id,
                                              success: {
                                                success in
                                                PROGRESS_HIDE()
                                                Alert.showAlert(message: "Delete successfully", viewController: self)
        }, failure: {
            error in
            PROGRESS_ERROR(view: self.view, error: error)
        })
    }
    
}




