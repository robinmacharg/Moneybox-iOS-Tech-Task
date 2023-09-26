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
    
    // MARK: - Outlets
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var planValue: UILabel!
    @IBOutlet weak var planValueLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var model = AccountsViewModel()
    private var bindings = Set<AnyCancellable>()
    
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
    func setUser(_ user: LoginResponse.User) {
        model.user = user
    }
}

// MARK: - <UITableViewDataSource>

extension AccountsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.accounts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "account", for: indexPath) as? AccountCell
         {
            if let account = model.accounts?[indexPath.row],
                let totalValue = account.wrapper?.totalValue,
               let moneyboxContributions = account.wrapper?.totalContributions
            {
                cell.accountNameLabel.text = account.name
                cell.planValueLabel.text = "£\(totalValue)"
                cell.moneyboxAmountLabel.text = "£\(moneyboxContributions)"
                cell.delegate = self
                cell.configure()
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

extension AccountsViewController: AccountCellDelegate {
    func tapped(recognizer: UITapGestureRecognizer) {
        print("tapped")
    }
}
