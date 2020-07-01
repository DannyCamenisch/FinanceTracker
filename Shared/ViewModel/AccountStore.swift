//
//  AccountStore.swift
//  ManaBar
//
//  Created by Danny on 25.06.20.
//

import Foundation

class AccountStore: ObservableObject {
    @Published var accounts: [Account]
    
    var totalBalance: String {
        var totalBalance: Float = 0
        for account in accounts {
            totalBalance += account.balance
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current

        let formattedString: String = formatter.string(for: totalBalance)!
        return formattedString
    }
    
    init(accounts: [Account]) {
        self.accounts = accounts
    }
    
    
}
