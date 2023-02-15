//
//  Date+.swift
//  Message App
//
//  Created by NeferUser on 2023/2/10.
//

import Foundation

// MARK: - 日期轉換
extension Date {
    
    func setYearString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let dateString = formatter.string(from: self)
        
        return dateString
    }
    
    func setDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        let dateString = formatter.string(from: self)
        
        return dateString
    }
    
    func setDateString2() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: self)
        
        return dateString
    }
    
    func setDateString3() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let dateString = formatter.string(from: self)
        
        return dateString
    }
    
    func setDateString4() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: self)
        
        return dateString
    }
}
