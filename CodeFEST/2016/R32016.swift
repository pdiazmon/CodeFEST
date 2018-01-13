//
//  R32016.swift
//  CodeFEST2016
//
//  Created by Pedro L. Diaz Montilla on 5/1/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation

class R32016_Game {
    var sequence: [Int] = []
    var maxNumber: Int = 0
    
    func play(number: Int) {
        self.maxNumber = number
        sequence = []
        
        self.generateSequence(currentNumber: 1)
        
        print("For \(maxNumber.formattedWithSeparator) => can be decomposed in \(self.sequence.count.formattedWithSeparator) numbers")
        
    }
    
    /*
    * Iterate recursively to generate the sequence
    */
    func generateSequence(currentNumber: Int) {
        
        // If we have reached the maximum, return
        if (currentNumber > maxNumber) { return }
        
        // Plus 5: First, if it is possible to add 5 and the result number has not been added yet to the sequence
        if (currentNumber + 5 <= maxNumber && !self.sequence.contains(currentNumber + 5)) {
            
            // Include to the the sequence the current number plus 5
            self.sequence.append(currentNumber + 5)
            
            // Continue adding +5 and *3 to the sequence
            generateSequence(currentNumber: currentNumber + 5)
        }
        // Multiplied by 3: if it is possible to multiply by 3 and the result number has not been added yet to the sequence
        if (currentNumber * 3 <= maxNumber && !self.sequence.contains(currentNumber * 3)) {
            
            // Include to the the sequence the current number multiplied by 3
            self.sequence.append(currentNumber * 3)
            
            // Continue adding +5 and *3 to the sequence
            generateSequence(currentNumber: currentNumber * 3)
        }
    }
}
