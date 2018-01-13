//
//  Extensions.swift
//  CodeFEST
//
//  Created by Pedro L. Diaz Montilla on 13/1/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Int {

    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }

    /*
     * Return the sum of the squares for all the integer's digits
     */
    func addSquares() -> Int {
        var square:Int = 0
        var n: Int = 0
        
        for character in String(self) {
            n = Int(String(character))!
            square += n * n
        }
        return square
    }
    
    func abs() -> Int { return Swift.abs(self) }
    
    /*
     * Returns true if the number is prime and false if not
     */
    func isPrime() -> Bool {
        var i: Int
        
        if (self <= 1) { return false }
        if (self <= 3) { return true }
        
        i = 2
        while (i*i <= self) {
            if (self % i == 0) { return false }
            i = i + 1
        }
        return true
    }
    
    /*
     * Returns the number, less than the current one, that when dividing the current one obtains a rest of zero
     */
    func maxDivider() -> Int {
        var i: Int = self-1
        
        while (i >= 2) {
            if (self % i == 0) {return i}
            i -= 1
        }
        return self
    }
}

extension UInt64 {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
    
}
