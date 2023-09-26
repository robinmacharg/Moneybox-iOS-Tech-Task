//
//  AccountCell.swift
//  MoneyBox
//
//  Created by Robin Macharg on 26/09/2023.
//

import UIKit

protocol AccountCellDelegate {
    func tapped(recognizer: UITapGestureRecognizer)
}

class AccountCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var planValueLabel: UILabel!
    @IBOutlet weak var moneyboxAmountLabel: UILabel!
    
    var delegate: AccountCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        layer.cornerRadius = 10
        
//        if let delegate {
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AccountCell.didTapView(_:)))
//            containerView.addGestureRecognizer(tapGesture)
////            tapGesture.delegate = delegate
//        }
    }

    func configure() {
        layer.cornerRadius = 10
//        if let delegate {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AccountCell.didTapView(_:)))
            containerView.addGestureRecognizer(tapGesture)
//            tapGesture.delegate = delegate
//        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc
    func didTapView(_ sender: UITapGestureRecognizer) {
        print("did tap view", sender)
        delegate?.tapped(recognizer: sender)
    }
}
