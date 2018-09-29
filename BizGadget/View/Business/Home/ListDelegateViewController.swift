//
//  ListDelegateViewController.swift
//  BizGadget
//
//  Created by Yogesh Date on 08/09/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

protocol SelectedListDelegate {
    func didSelectedIndexPath(index:Int, name:String)
}
class ListDelegateViewController: UIViewController {

    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var listPicker: UIPickerView!
    
    var aryList=[String]()
    var selectedPath: Int?
    var SelectedList: SelectedListDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listPicker.delegate = self
        listPicker.dataSource = self
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

    @IBAction func btnCancelClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnOkClicked(_ sender: UIButton) {
        self.SelectedList?.didSelectedIndexPath(index: selectedPath ?? 0, name: aryList[selectedPath ?? 0])
        self.dismiss(animated: true, completion: nil)
    }
    
    
}



extension ListDelegateViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.aryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.aryList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPath = row
        
    }
    
    
    
}
