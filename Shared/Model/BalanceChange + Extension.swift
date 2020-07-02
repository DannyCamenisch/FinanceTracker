//
//  BalanceChange + Extension.swift
//  FinanceTracker
//
//  Created by Danny on 01.07.20.
//

import Foundation
import CoreData

extension BalanceChange: Identifiable {
    @discardableResult convenience init(name: String, amount: Float, sfSymbol: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        
        self.id = UUID()
        self.name = name
        self.amount = amount
        self.sfSymbol = sfSymbol
        self.date = Date()
    }
}
