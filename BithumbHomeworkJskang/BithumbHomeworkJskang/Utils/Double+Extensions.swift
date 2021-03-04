//
//  Double+Extensions.swift
//  BithumbHomeworkJskang
//
//  Created by 강진석 on 2021/03/02.
//

import Foundation

extension Double {
    func getCurrencyFormatString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: self as NSNumber)!
    }
    
    func getPercentFormatString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        let resultString = numberFormatter.string(from: self as NSNumber)!
        return resultString
    }
}
