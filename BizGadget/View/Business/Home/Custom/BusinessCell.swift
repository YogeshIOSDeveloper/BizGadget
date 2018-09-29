//
//  BusinessCell.swift
//  BizGadget
//
//  Created by Yogesh Date on 29/09/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit


protocol BusinessDelegateDelegate {
    func didPressDeleteBtn(cell : BusinessCell)
}
protocol BusinessEditDelegate {
    func didPressEditBtn(cell: BusinessCell)
}

class BusinessCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imagePhoto: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    
    var OptionDelegate: BusinessDelegateDelegate?
    var OptionEdit: BusinessEditDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func btnDelete(_ sender: UIButton) {
        OptionDelegate?.didPressDeleteBtn(cell: self)
    }
    
    @IBAction func btnEdit(_ sender: UIButton) {
        OptionEdit?.didPressEditBtn(cell: self)
    }
}
