//
//  LoginModel.swift
//  MoneyBox
//
//  Created by Robin Macharg on 26/09/2023.
//

import Foundation
import Networking



final class LoginViewModel: ObservableObject {
    
    enum State {
        case validCredentials(Bool)
        case loggingIn
        case loggedIn
        case error(String)
    }
    
    // MARK: - Published properties
    
    @Published var state: State = .validCredentials(false)
    
    // MARK: - Properties
    
    var dataProvider: DataProviderLogic
    var user: LoginResponse.User?
    
    init(dataProvider: DataProviderLogic) {
        self.dataProvider = dataProvider
    }
    
    // MARK: - Functions
    
    private func updateFieldsFilledIn() {
        let validCredentials = !(email?.isEmpty ?? true) && !(password?.isEmpty ?? true)
        state = .validCredentials(validCredentials)
    }
    
    var email: String? {
        didSet {
            updateFieldsFilledIn()
        }
    }
    
    var password: String? {
        didSet {
            updateFieldsFilledIn()
        }
    }
    
    func login() {
        if let email, let password {
            
            state = .loggingIn
            
            DispatchQueue.global(qos: .userInitiated).async {
//                let loginRequest = LoginRequest(
//                    email: email,
//                    password: password)
                let loginRequest = LoginRequest(
                    email: "test+ios2@moneyboxapp.com",
                    password: "P455word12") // Valid
//                let loginRequest = LoginRequest(
//                    email: "test+ios2@moneyboxapp.com",
//                    password: "P455word12X") // Invalid
                self.dataProvider.login(request: loginRequest) { result in
                    switch result {
                    case .success(let response):
                        SessionManager().setUserToken(response.session.bearerToken)
                        self.user = response.user
                        self.state = .loggedIn
                    case .failure(let error):
                        self.state = .error("Login Failed.  Please try again.")
                    }
                }
            }
        }
    }
}
