//
//  R12017.swift
//  CodeFEST2017
//
//  Created by Pedro L. Diaz Montilla on 8/1/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation


class R12017_Game {
    var data: [Int] = []
    
    /*
    * Fills the data array with a sequence of numbers, starting at 2, up to a given number
    */
    func fillData(n: Int) {
        
        // If the array is empty
        if (data.count == 0) {
            for i in 0..<n {
                self.data.append(i+2)
            }
        }
        // If the array is not empty, fill with more data up to n
        else {
            for i in data.count...n {
                data.append(i+2)
            }
        }
    }
    
    /*
    * Returns the nth item in the array. If n is greater than the array capacity, fills the array with more numbers up to n
    */
    func getItem(_ n: Int) -> Int {
        if (n >= data.count) {
            fillData(n: n)
        }
        return data[n]
    }
    
    func play(iterations: Int, startAt: Int) {
        var p = startAt
        var maxDivider: Int
        
        
        print("Iterations=\(iterations.formattedWithSeparator), startAt=\(startAt.formattedWithSeparator) => ", terminator: "")
        
        data = []
        
        // Fills the array with numbers
        fillData(n: max(iterations, startAt))
        
        // For all the numbers up to 'iterations'
        for _ in 1...iterations {
            
            // If the number in position 'p' is prime
            if(getItem(p).isPrime()) {
                // Go to the following number in the sequence
                p += 1
            }
            // If not
            else {
                // Gets the maximum divider of the number
                maxDivider = data[p].maxDivider()
                
                // Divide the number by its maximum divider
                data[p] /= maxDivider
                
                // Sum the maximum divider to the previous number in the sequence
                p -= 1
                data[p] += maxDivider
            }
        }
        
        print("p=\(p.formattedWithSeparator)")
        
    }
    
}
