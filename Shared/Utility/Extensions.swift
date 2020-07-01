//
//  Extensions.swift
//  FinanceTracker
//
//  Created by Danny on 01.07.20.
//

import Foundation
import SwiftUI

extension Double {
    static func random() -> Double {
        return Double(arc4random()) / Double(UInt32.max)
    }
}

extension Color {
    static func random() -> Color {
        return Color(red: .random(), green: .random(), blue: .random())
    }
}
