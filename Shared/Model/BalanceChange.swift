//
//  BalanceChange.swift
//  FinanceTracker
//
//  Created by Danny on 01.07.20.
//

import Foundation
import SwiftUI

struct BalanceChange: Identifiable {
    var description: String
    var amount: Float
    var image: Image
    let id = UUID()
}
