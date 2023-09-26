//
//  AccountsViewModel.swift
//  MoneyBox
//
//  Created by Robin Macharg on 26/09/2023.
//

import Foundation
import Networking

final class AccountsViewModel: ObservableObject {
    
    enum State {
        case initial
        case loading
        case loaded
        case error(message: String, details: String? = nil)
    }
    
    // MARK: - Properties
    
    var user: LoginResponse.User?
    var accounts: [Account]?
    var productResponses: [ProductResponse]?
    var totalPlanValue: Double?

    // MARK: - Published properties
    
    @Published var state: State = .initial
    
    // MARK: - Private properties
    
    private var dataProvider = DataProvider()
    
    // MARK: - Methods
    
    func configure(user: LoginResponse.User) {
        self.user = user
    }
    
    func loadData() {
        state = .loading
        DispatchQueue.global(qos: .userInitiated).async {
            self.dataProvider.fetchProducts { result in
                switch result {
                case .success(let response):
                    self.productResponses = response.productResponses ?? []
                    self.totalPlanValue = response.totalPlanValue ?? 0.0
                    self.state = .loaded
                    
                case .failure(let error):
                    self.state = .error(
                        message: "Failed to load data",
                        details: error.localizedDescription
                    )
                }
            }
        }
    }
    
}
