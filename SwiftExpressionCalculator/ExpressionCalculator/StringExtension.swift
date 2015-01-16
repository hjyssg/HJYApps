//
//  StringExtension.swift
//  ExpressionCalculator
//
//  Created by Junyang Huang on 1/15/15.
//  Copyright (c) 2015 HJY. All rights reserved.
//

import Foundation

public extension String {
    
    var length: Int { return countElements(self) }
    
    func toDouble() -> Double? {
        return (self as NSString).doubleValue
        
    }
    
    subscript (range: Range<Int>) -> String? {
        if range.startIndex < 0 || range.endIndex > self.length {
            return nil
        }
        
        let range = Range(start: advance(startIndex, range.startIndex), end: advance(startIndex, range.endIndex))
        
        return self[range]
    }
    
    subscript (index: Int) -> String? {
        let temp = Array(self)
            return String(temp[index])
    }
    
}