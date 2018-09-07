//
//  HomeTableViewCell.swift
//  BizGadget
//
//  Created by Yogesh Date on 13/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

protocol OptionButtonDelegate {
    func didPressOptionButton(cell : HomeTableViewCell)
}
protocol LikeButtonDelegate {
    func didPressLikeButton(cell: HomeTableViewCell)
}
protocol FavouriteButtonDelegate {
    func didPressFavouriteButton(cell: HomeTableViewCell)
}
protocol PhoneButtonDelegate {
    func didPressPhoneButton(cell : HomeTableViewCell)
}
protocol LocationButtonDelegate {
    func didPressLocationButton(cell: HomeTableViewCell)
}
protocol ShareButtonDelegate {
    func didPressShareButton(cell: HomeTableViewCell)
}
protocol AddPersonDelegate {
    func didPressAddButton(cell: HomeTableViewCell)
}

class HomeTableViewCell: UITableViewCell {

    var OptionDelegate: OptionButtonDelegate?
    var LikeDelegate: LikeButtonDelegate?
    var FavouriteDelegate: FavouriteButtonDelegate?
    var PhoneDelegate: PhoneButtonDelegate?
    var LocationDelegate: LocationButtonDelegate?
    var ShareDelegate: ShareButtonDelegate?
    var AddPersonDelegate: AddPersonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnOptionClicked(_ sender: UIButton) {
        OptionDelegate?.didPressOptionButton(cell: self)
    }
    
    @IBAction func btnLikeClicked(_ sender: UIButton) {
        LikeDelegate?.didPressLikeButton(cell: self)
    }
    
    @IBAction func btnFavouriteButton(_ sender: UIButton) {
        FavouriteDelegate?.didPressFavouriteButton(cell: self)
    }
    
    @IBAction func btnPhoneClicked(_ sender: UIButton) {
        PhoneDelegate?.didPressPhoneButton(cell: self)
    }
    
    @IBAction func btnLocationClicked(_ sender: UIButton) {
        LocationDelegate?.didPressLocationButton(cell: self)
    }
    
    @IBAction func btnShareClicked(_ sender: UIButton) {
        ShareDelegate?.didPressShareButton(cell: self)
    }
    
    @IBAction func btnAddPersonClicked(_ sender: UIButton) {
        AddPersonDelegate?.didPressAddButton(cell: self)
    }
    
    
}
