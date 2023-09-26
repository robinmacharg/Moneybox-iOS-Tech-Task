//
//  AccountDetailsController.swift
//  MoneyBox
//
//  Created by Robin Macharg on 26/09/2023.
//

import UIKit
import Combine

class AccountDetailsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var accountTypeLabel: UILabel!
    @IBOutlet weak var planValue: UILabel!
    @IBOutlet weak var moneyboxLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    private var model = AccountDetailsViewModel()
    private var bindings = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
        setBusy(false)
        updateScreen()
    }
    
    // MARK: - Actions
        
    @IBAction func addMoney(_ sender: Any) {
        model.addMoney(10)
    }
    
    // MARK: - Methods
    
    func setUpBindings() {
        model.$state
            .receive(on: DispatchQueue.main)
            .sink { state in
                switch state {
                    
                case .initial:
                    break
                    
                case .loading:
                    self.setBusy(true)

                case .loaded:
                    break

                case .sendingMoney:
                    self.setBusy(true)

                case .sent:
                    self.setBusy(false)
                    self.updateScreen()

                case .error(_):
                    self.setBusy(false)
                }
            }
            .store(in: &bindings)
    }
    
    func updateScreen() {
        accountTypeLabel.text = model.account ?? ""
        planValue.text = "£\(model.planValue ?? 0.0)"
        moneyboxLabel.text = "£\(model.moneybox ?? 0.0)"
    }
    
    func setBusy(_ busy: Bool) {
        if busy {
            self.containerView.layer.opacity = 0.5
            self.containerView.isUserInteractionEnabled = false
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
        else {
            self.containerView.layer.opacity = 1.0
            self.containerView.isUserInteractionEnabled = true
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Navigation

    func configure(
        account: String,
        planValue: Double,
        moneybox: Double,
        id: Int
    ) {
        model.account = account
        model.planValue = planValue
        model.moneybox = moneybox
        model.id = id
     }
}
