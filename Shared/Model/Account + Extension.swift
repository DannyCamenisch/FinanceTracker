//
//  Account + Extension.swift
//  FinanceTracker
//
//  Created by Danny on 02.07.20.
//

import Foundation
import CoreData
import SwiftUI

extension Account {
    @discardableResult convenience init(id: UUID = UUID(), name: String, balance: Float, primaryColor: Color, secondaryColor: Color, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        
        self.id = id
        self.name = name
        self.balance = balance
        self.balanceChanges = [BalanceChange(name: "Initial deposit", amount: balance, sfSymbol: "dollarsign.circle")]
        self.primaryColor = UIColor(primaryColor).toHex
        self.secondaryColor = UIColor(secondaryColor).toHex
    }
    
    func formattedBalance() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        
        let formattedString: String = formatter.string(for: self.balance)!
        return formattedString
    }
    
}
