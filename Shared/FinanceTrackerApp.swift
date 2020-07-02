//
//  FinanceTrackerApp.swift
//  Shared
//
//  Created by Danny on 26.06.20.
//

import SwiftUI

@main
struct FinanceTrackerApp: App {
    
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(AccountStore())
        }
    }
}

//let testData: [Account] = [
//    Account(name: "ZKB Privatkonto", balance: 24_000.60, primaryColor: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), secondaryColor: Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1))),
//    Account(name: "ZKB Sparkonto", balance: 700, primaryColor: Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)), secondaryColor: Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))),
//    Account(name: "AKB Privatkonto", balance: 7_000, primaryColor: Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)), secondaryColor: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
//]
