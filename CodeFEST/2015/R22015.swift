//
//  R22015.swift
//  CodeFEST2015
//
//  Created by Pedro L. Diaz Montilla on 31/12/17.
//  Copyright © 2017 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation



class R22015_Path {
	var path: String = ""
	var pathDistance: Int = 0
}

class R22015_Game {
	var maxDistance: Int = 0
	var times: UInt64 = 0
	
	func play(distance: Int) {
		times = 0
		maxDistance = distance
		times = findDistance2(distance: distance)
		
        print("For \(distance) distance: \(times.formattedWithSeparator) patterns found.")
	}
	
	/*
    * First approach with a recursive solution
	* Much more slower thant the second approach
    */
	func findDistance(path: String, pathDistance: Int) {
		
        // We've found another pattern that has the distance requested
		if(pathDistance == maxDistance) {
			self.times += 1
			return
		}
		
        // If a 'B' step can be done
		if ((maxDistance - pathDistance) >= 2) {
			var workPathB: String = path
            
            // Add a 'B' step to the pattern => '...(current pattern)... + B'
			workPathB.append("B")
            
            // Continue adding 'A' and 'B' to the pattern
			findDistance(path: workPathB, pathDistance: pathDistance + 2)
		}
        // If a 'A' step can be done
		if ((maxDistance - pathDistance) >= 1) {
			var workPathA: String = path
            
            // Add a 'A' step to the pattern => '...(current pattern)... + A'
			workPathA.append("A")
            
            // Continue adding 'A' and 'B' to the pattern
            findDistance(path: workPathA, pathDistance: pathDistance + 1)
		}
	}
	
	/*
    * Second approach with a single path
    */
	func findDistance2(distance: Int) -> UInt64 {
		var cacheReto1: [UInt64: UInt64] = [:]
		var i: UInt64 = 3
		
		if(distance >= 0) { cacheReto1[0] = 0 }
		if(distance >= 1) { cacheReto1[1] = 1 }
		if(distance >= 2) { cacheReto1[2] = 2 }
		
		while (i >= 3 && i <= distance) {
			cacheReto1[i] = cacheReto1[i-1]! + cacheReto1[i-2]!
			i += 1
		}
		return cacheReto1[UInt64(distance)]!
		
	}
}
