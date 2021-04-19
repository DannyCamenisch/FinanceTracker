//
//  NumbersOnly.swift
//  FinanceTracker
//
//  Created by Danny on 18.04.21.
//

import Foundation

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter{ "0123456789.-".contains($0) }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}
