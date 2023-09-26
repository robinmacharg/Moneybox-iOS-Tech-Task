//
//  AccountDetailsModel.swift
//  MoneyBox
//
//  Created by Robin Macharg on 26/09/2023.
//

import Foundation
import Networking

class AccountDetailsModel: ObservableObject {
    
    enum State {
        case initial
        case loading
        case loaded
        case sendingMoney
        case sent
        case error(String)
    }
    
    // MARK: - Properties
    
    var account: AccountResponse?
    
    // MARK: - Published properties
    
    @Published var state: State = .initial
    
    // MARK: - Private properties
    
    private var dataProvider = DataProvider()
    
    // MARK: - Methods
    
    func addMoney(_ amount: Double) {
        state = .sendingMoney
        
        DispatchQueue.global(qos: .userInitiated).async {
//            if let investorProductID = account?.productResponses {
//                
//                let paymentRequest = OneOffPaymentRequest(
//                    amount: amount,
//                    investorProductID: <#T##Int#>)
//                self.dataProvider.addMoney(
//                    request: <#T##OneOffPaymentRequest#>) { result in
//                        switch result {
//                        case .success(let response):
//                            break
//                        case .failure(let error):
//                            self.state = .error("Failed to add money")
//                        }
//                    }
//            }
        }
    }
}
