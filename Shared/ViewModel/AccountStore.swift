//
//  AccountStore.swift
//  ManaBar
//
//  Created by Danny on 25.06.20.
//

import Foundation
import SwiftUI
import CoreData

class AccountStore: ObservableObject {
    @Published private(set) var accounts = [Account]()
    
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
    
    
    init() {
        getAccounts()
    }
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.shared.mainContext
        do {
            try moc.save()
            getAccounts()
            
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
    
    // MARK: - CRUD Methods
    // Create
    func addNewAccountWith(name: String, balance: Float, primaryColor: Color, secondaryColor: Color, completion: @escaping() -> Void) {
        _ = Account(name: name, balance: balance, primaryColor: primaryColor, secondaryColor: secondaryColor)
        saveToPersistentStore()
        completion()
    }
    
    // Read
    func getAccounts() {
        let fetchRequest: NSFetchRequest<Account> = Account.fetchRequest()
        let moc = CoreDataStack.shared.mainContext
        
        do {
            accounts = try moc.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching tasks: \(error)")
        }
    }
    
    // Update
    func update(account: Account, name: String, balance: Float) {
        account.name = name
        account.balance = balance
        
        saveToPersistentStore()
    }
    
    func updateBalance(account: Account, balance: Float) {
        let sfSymbol = balance - account.balance < 0 ? "minus.circle" : "plus.circle"
        let balanceChange = BalanceChange(name: "Updated Balance", amount: balance - account.balance, sfSymbol: sfSymbol)
        account.addToBalanceChanges(balanceChange)
        
        update(account: account, name: account.name!, balance: balance)
        saveToPersistentStore()
    }
    
    func newTransaction(account: Account, change: Float, description: String) {
        let sfSymbol = change < 0 ? "minus.circle" : "plus.circle"
        let balanceChange = BalanceChange(name: description, amount: change, sfSymbol: sfSymbol)
        account.addToBalanceChanges(balanceChange)
        
        update(account: account, name: account.name!, balance: account.balance + change)
        saveToPersistentStore()
    }
    
    // Delete
    func delete(account: Account) {
        let mainC = CoreDataStack.shared.mainContext
        mainC.delete(account)
        saveToPersistentStore()    }
    
    func deleteAccount(at indexSet: IndexSet) {
        guard let index = Array(indexSet).first else { return }
        let account = self.accounts[index]
        
        delete(account: account)
    }
}
