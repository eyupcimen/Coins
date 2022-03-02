//
//  Decimal+Extension.swift
//  Coins
//
//  Created by eyup cimen on 27.02.2022.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return round(NSDecimalNumber(decimal: self).doubleValue * 100) / 100.0
    }
}
