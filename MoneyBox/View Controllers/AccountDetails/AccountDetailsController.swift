//
//  AccountDetailsController.swift
//  MoneyBox
//
//  Created by Robin Macharg on 26/09/2023.
//

import UIKit

class AccountDetailsController: UIViewController {

    @IBOutlet weak var accountTypeLabel: UILabel!
    @IBOutlet weak var planValue: UILabel!
    @IBOutlet weak var moneyboxLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addMoney(_ sender: Any) {
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
