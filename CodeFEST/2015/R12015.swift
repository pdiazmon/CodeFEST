//
//  R12015.swift
//  CodeFEST2015
//
//  Created by Pedro L. Diaz Montilla on 31/12/17.
//  Copyright © 2017 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation

class R12015_Game {
	
	func play(max: Int) {
		var times: Int = 0
		
        print("For number \(max.formattedWithSeparator) => ", terminator: "")
        
        // For every number up to 'max' and counts the times a sequence contain the number 89
		for i in 2...max {
			if createSequence(initialNumber: i) {
				times += 1
			}
		}
		print("\(times.formattedWithSeparator) integers contain in its sequence the number 89")
		
	}
	
	/*
    * Returns true if 89 is in the sequece, and false if not for a given number
    */
	func createSequence(initialNumber: Int) -> Bool {
		var next: Int = initialNumber
		
		while(next > 1 && next != 89){
			next = next.addSquares()
		}
		if(next == 89) {return true}
		else {return false}
	}
	
}
