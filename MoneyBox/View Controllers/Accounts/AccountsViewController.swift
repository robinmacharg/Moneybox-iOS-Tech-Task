//
//  AccountsViewController.swift
//  MoneyBox
//
//  Created by Robin Macharg on 26/09/2023.
//

import UIKit
import Networking
import Combine

class AccountsViewController: UIViewController {
    
    struct SegueInfo {
        let account: String
        let planValue: Double
        let moneybox: Double
        let id: Int
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var planValue: UILabel!
    @IBOutlet weak var planValueLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var model = AccountsViewModel()
    private var bindings = Set<AnyCancellable>()
    
    private var segueInfo: SegueInfo?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
        name.text = ""
        planValue.text = ""
        planValueLabel.isHidden = true
        name.isHidden = true
        tableView.isHidden = true
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
        
        model.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        self.navigationItem.hidesBackButton = true
    }
    
    private func setUpBindings() {
        model.$state
            .receive(on: DispatchQueue.main)
            .sink { state in
                switch state {
                case .initial:
                    break
                    
                case .loading:
                    self.activityIndicator.isHidden = false
                    self.activityIndicator.startAnimating()
                    
                case .loaded:
                    self.planValue.text = "£\(self.model.totalPlanValue ?? 0)"
                    self.name.text = "Hello \(self.model.user?.firstName ?? "")!"
                    self.planValueLabel.isHidden = false
                    self.name.isHidden = false
                    self.tableView.isHidden = false
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                    
                case .error(_, _):
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                }
            }
            .store(in: &bindings)
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

// MARK: - Navigation

extension AccountsViewController {
    func configure(user: LoginResponse.User) {
        model.configure(user: user)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "accounts_details":
            if let user = model.user, let segueInfo {
                (segue.destination as? AccountDetailsViewController)?.configure(
                    account: segueInfo.account,
                    planValue: segueInfo.planValue,
                    moneybox: segueInfo.moneybox,
                    id: segueInfo.id
                )
            }
        default:
            break
        }
    }
}

// MARK: - <UITableViewDataSource>

extension AccountsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.productResponses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "account", for: indexPath) as? AccountCell
        {
            if let product = model.productResponses?[indexPath.row],
               let planValue = product.planValue,
               let moneybox = product.moneybox,
               let name = product.product?.friendlyName,
               let id = product.id
            {
                cell.configure(
                    id: id,
                    accountName: name,
                    planValue: planValue,
                    moneybox: moneybox,
                    delegate: self)
                return cell
            }
            else {
                return tableView.dequeueReusableCell(withIdentifier: "error", for: indexPath)
            }
        }
        fatalError("Can't dequeue cell")
    }
}

// MARK: - <UITableViewDelegate>

extension AccountsViewController: UITableViewDelegate {
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        tableView.deselectRow(at: indexPath, animated: true)
    //    }
}

// MARK: - <AccountCellDelegate>

extension AccountsViewController: AccountCellDelegate {
    func tapped(segueInfo: SegueInfo) {
//        print("tapped", id)
        self.segueInfo = segueInfo
        self.performSegue(withIdentifier: "accounts_details", sender: self)
    }
}
