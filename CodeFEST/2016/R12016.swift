//
//  R12016.swift
//  CodeFEST2016
//
//  Created by Pedro L. Diaz Montilla on 2/1/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation

class R12016_DistributionLine {
    // Distribution line is a dictionary, where the key is the position and the value is the number of medicins on it
    var line: [Int: Int]
    
    init (_ parLine: [Int: Int]) {
        line = parLine
    }
    
    /*
    * Returns the higher position in the line
    */
    func maxPositions() -> Int {
        var maxKey: Int = 0
        for k in line.keys
        {
            maxKey = max(maxKey, k)
        }
        return maxKey
    }
    
}

class R12016_Game {
    
    func play(parLine: [Int: Int]) {
        let myLine = R12016_DistributionLine(parLine)
        var movs: Int = 0
        var boxPos: Int = -1
        var minMovs: Int = Int.max
        
        print("\nStarting approach 1 for \(myLine.line.debugDescription)")
        
        // For all the possible positions in the line
        for pos in 1...myLine.maxPositions() {
            
            // We move the box to the position 'pos' from position 0
            movs = pos
            
            // Again, we iterate for all the possible positions in the line
            for movToPos in 1...myLine.maxPositions() {
                
                // If there are medicins in the 'movToPos' position
                if (myLine.line[movToPos] != nil) {
                    // Move all of the medicions to the box, one by one: moving to 'pos' and back to 'movToPos'
                    movs += ((pos-movToPos).abs() * 2) * myLine.line[movToPos]!
                }
            }
            
            // Moving back to position 0 from position 'pos'
            movs += pos
            
            // If the necessary movements are lower than the current minimum, get also the position 'pos'
            if(movs < minMovs) {
                minMovs = movs
                boxPos = pos
            }
        }
        
        print("Meters = \(minMovs) - Box Position = \(boxPos)")
    }
    
    // Other approach
    func play2(parLine: [Int]) {
        var minMeters: Int = Int.max
        var boxOpt: Int = 0
        var meters: Int = 0
 
        print("\nStarting approach 2 for \(parLine.debugDescription)")

        for boxPos in 1...parLine.count {
            meters = (boxPos) * 2
            
            for pos in parLine {
                meters += (boxPos-pos).abs() * 2
            }
            
            if (meters < minMeters) {
                minMeters = meters
                boxOpt = boxPos
            }
        }
        
        print("Meters = \(minMeters) - Box Position = \(boxOpt)")
    }
}
