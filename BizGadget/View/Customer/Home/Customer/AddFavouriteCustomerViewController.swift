//
//  EditDeleteViewController.swift
//  BizGadget
//
//  Created by Yogesh Date on 20/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

protocol SelectedOptionDelegate {
    func didSelectedOption(name:String, index:Int)
}

class AddFavouriteCustomerViewController: UIViewController {
//cell
    
    var feedId:Int?
    
    @IBOutlet weak var viewFirst: UIView!
    @IBOutlet weak var viewCreateNew: UIView!
    @IBOutlet weak var viewNewOne: UIView!
    
    var index:Int?
    var SelectedDelegate: SelectedOptionDelegate?
    var aryFavourites=[Favourite]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(feedId ?? 0)
        viewFirst.isHidden = false
        viewNewOne.isHidden = true
        viewCreateNew.isHidden = true
        
        viewCreateNew.layer.cornerRadius = 12
        viewNewOne.layer.cornerRadius = 12
        viewFirst.layer.cornerRadius = 12
        
        self.myTable.dataSource = self
        self.myTable.delegate = self
        self.favouriteList()
    }

    func favouriteList()  {
        Webservices.shared.FavouritesList(success: {
            aryFavourute in
            self.aryFavourites = aryFavourute
            self.myTable.reloadData()
        }, failure: {
            error in
        })
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
    
    @IBAction func btnAddExisting(_ sender: BizGadgetButton) {
        viewFirst.isHidden = true
        viewNewOne.isHidden = false
        viewCreateNew.isHidden = true
    }
    
    
    @IBAction func btnCreateNew(_ sender: Any) {
        viewFirst.isHidden = true
        viewNewOne.isHidden = true
        viewCreateNew.isHidden = false
    }
    
    @IBOutlet weak var textName: UITextField!
    @IBAction func btnCreate(_ sender: Any) {
        
        if textName.text == ""{
            Alert.showAlert(message: "Enter Favourite name", viewController: self)
        } else {
            self.createFavourite()
        }
        
    }
    
    @IBOutlet weak var myTable: UITableView!
    @IBAction func btnOKClicked(_ sender: Any) {
        
    }
    
    
    
    @IBAction func btnEditProfile(_ sender: UIButton) {
        self.SelectedDelegate?.didSelectedOption(name: ACTION_EDIT, index: index ?? -1)
        //self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDeleteProfileClicked(_ sender: UIButton) {
        self.SelectedDelegate?.didSelectedOption(name: ACTION_DELETE, index: index ?? -1)
        //self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func createFavourite()  {
        
        let userId = UserDefaults.standard.integer(forKey: "user_id")
        PROGRESS_SHOW(view: self.viewFirst)
        Webservices.shared.createFavourite(name: self.textName.text!,
                                           user_id: userId,
                                           success: {
                                            success in
                                            PROGRESS_HIDE()
                                            
                                            let alert = UIAlertController(title: nil, message: "Favourite create successfully", preferredStyle: .alert)
                                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                                                action  in
                                                self.dismiss(animated: true, completion: nil)
                                            }))
                                            self.present(alert, animated: true, completion:nil)
                                            
                                            
        }, failure: {
            error in
            PROGRESS_ERROR(view: self.view, error: error)
        })
    }
    
    //set as favourite successfully
    func setFavourite(feedId:Int, favouriteId:Int)  {
        
        PROGRESS_SHOW(view: self.view)
        Webservices.shared.setFavourite(feedId: feedId,
                                        favouriteId: favouriteId,
                                        success: {
                                            success in
                                            PROGRESS_HIDE()
                                            let alert = UIAlertController(title: nil, message: "set as favourite successfully", preferredStyle: .alert)
                                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                                                action  in
                                                self.dismiss(animated: true, completion: nil)
                                            }))
                                            self.present(alert, animated: true, completion:nil)
                                            
        }, failure: {
            error in
            PROGRESS_ERROR(view: self.view, error: error)
        })
    }
    //setFavourite
    
}


extension AddFavouriteCustomerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aryFavourites.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let obj = self.aryFavourites[indexPath.row]
        cell.textLabel?.text = obj.name ?? "nil"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objFavourite = self.aryFavourites[indexPath.row]
        print("Name = \(objFavourite.name ?? "nil" )")
        
        self.setFavourite(feedId:feedId ?? 0, favouriteId:objFavourite.id  ?? 0)
    }
}
