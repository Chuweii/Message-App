//
//  String+.swift
//  Message App
//
//  Created by NeferUser on 2023/2/10.
//

import Foundation

extension String {
    
    func stringToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        return date ?? Date()
    }
    
    /// 四捨五入小數點第一位
    func iRound() -> String {
        guard let value = Double(self) else {
            return "转换错误"
        }
        var formatValue = String(format: "%.1f", value)
        
        if formatValue.contains(".0") {
            formatValue = String(format: "%.0f", value)
        }
        return formatValue
    }
    
    //去除小數點後的 0
    var cleanZero: String {
        var outNumber = self
        var i = 1
        
        if self.contains(".") {
            while i < self.count {
                if outNumber.hasSuffix("0") {
                    outNumber.remove(at: outNumber.index(before: outNumber.endIndex))
                    i = i + 1
                } else {
                    break
                }
            }
            if outNumber.hasSuffix(".") {
                outNumber.remove(at: outNumber.index(before: outNumber.endIndex))
            }
            return outNumber
        } else {
            return self
        }
    }
    
    mutating func insertInMiddle(text: String) -> String {
        self.insert(contentsOf: text, at: self.index(self.startIndex, offsetBy: self.count/2))
        
        return self
    }
}
