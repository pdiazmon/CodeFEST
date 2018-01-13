//
//  R32015.swift
//  CodeFEST2015
//
//  Created by Pedro L. Diaz Montilla on 31/12/17.
//  Copyright © 2017 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation

enum TypeResidue: String {
	case nodef = "n/a"
	case glass = "Glass"
	case paperboard = "Paperboard"
	case plastic = "Plastic"
}

class R32015_Container {
	var content: [TypeResidue: Int] = [:]
	var typeContent: TypeResidue = TypeResidue.nodef
    var description: String {
        // Resturns a description of the content of the container
        var str: String = ""
        
        str = " Glass:" + String(content[TypeResidue.glass]!.formattedWithSeparator)
        str += " Paperboard:" + String(content[TypeResidue.paperboard]!.formattedWithSeparator)
        str += " Plastic:" + String(content[TypeResidue.plastic]!.formattedWithSeparator)
        return str
    }
	
	convenience init(numGlass: Int, numPaperboard: Int, numPlastic: Int) {
		self.init(type: TypeResidue.nodef, numGlass: numGlass, numPaperboard: numPaperboard, numPlastic: numPlastic)
	}
    
	convenience init(type: TypeResidue, numGlass: Int, numPaperboard: Int, numPlastic: Int) {
		self.init()
		self.typeContent = type
		self.fill(numGlass: numGlass, numPaperboard: numPaperboard, numPlastic: numPlastic)
	}
	
    /*
    * Fill the container with the residues
    */
	func fill(numGlass: Int, numPaperboard: Int, numPlastic: Int) {
		content[TypeResidue.glass] = numGlass
		content[TypeResidue.paperboard] = numPaperboard
		content[TypeResidue.plastic] = numPlastic
	}
	
    /*
    * Calculate and return the necessary movements to be done to extract the residues from the container depending on its type
    */
	func necessaryMovements() -> Int {
		if (typeContent == TypeResidue.glass) { return content[TypeResidue.paperboard]! + content[TypeResidue.plastic]! }
		else if (typeContent == TypeResidue.paperboard) { return content[TypeResidue.glass]! + content[TypeResidue.plastic]! }
		else if (typeContent == TypeResidue.plastic) { return content[TypeResidue.paperboard]! + content[TypeResidue.glass]! }
        else { return content[TypeResidue.glass]! + content[TypeResidue.paperboard]! + content[TypeResidue.plastic]! }
    }

}

class R32015_Game {
	var container1 = R32015_Container(numGlass: 0, numPaperboard: 0, numPlastic: 0)
	var container2 = R32015_Container(numGlass: 0, numPaperboard: 0, numPlastic: 0)
	var container3 = R32015_Container(numGlass: 0, numPaperboard: 0, numPlastic: 0)
	var types: [TypeResidue] = [TypeResidue.glass, TypeResidue.paperboard, TypeResidue.plastic]
	
	func play() {
		
		var minimum: Int = Int.max
        var newMinimum: Int = Int.max
        var minimumType: [TypeResidue] = [TypeResidue.nodef, TypeResidue.nodef, TypeResidue.nodef]
        
        // For all types of content
		for t1 in types {
            // Again, for all type of contents
			for t2 in types {
                // Only if t1 and t2 are different
				if (t1 != t2) {
                    // Again, for all type of contents
					for t3 in types {
                        // Only if the combination of contents has no repetitions
						if (t2 != t3 && t1 != t3) {
                            // What if the containers are dedicated for this combination of contents
							container1.typeContent = t1
							container2.typeContent = t2
							container3.typeContent = t3
							
                            // Calculate the necessary movements for this combination, compare with the minimum and get the minor
							newMinimum = container1.necessaryMovements() + container2.necessaryMovements() + container3.necessaryMovements()
                            if (newMinimum < minimum) {
                                minimum = newMinimum
                                minimumType = [t1, t2, t3]
                            }
						}
					}
				}
			}
		}
		
        // Print the initial content of each container
        print("Container #1: \(container1.description)")
		print("Container #2: \(container2.description)")
		print("Container #3: \(container3.description)")
        
        print("Types of containers: Container #1: \(minimumType[0].rawValue) - Container #2: \(minimumType[1].rawValue) - Container #3: \(minimumType[2].rawValue)")
		print("Minimum Movements: \(minimum)\n")
	}
}

