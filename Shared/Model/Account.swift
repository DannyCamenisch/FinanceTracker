//
//  Account.swift
//  ManaBar
//
//  Created by Danny on 25.06.20.
//

import Foundation
import SwiftUI

struct Account: Identifiable {
    var name: String
    var balance: Float
    var balanceChanges: Array<BalanceChange> = []
    var primaryColor: Color
    var secondaryColor: Color
    let id: UUID = UUID()
    
    init(name: String, balance: Float, primaryColor: Color, secondaryColor: Color) {
        self.name = name
        self.balance = balance
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }
    
    func formattedBalance() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current

        let formattedString: String = formatter.string(for: balance)!
        return formattedString
    }
}

