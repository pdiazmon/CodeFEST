//
//  R52017.swift
//  CodeFEST2017
//
//  Created by Pedro L. Diaz Montilla on 11/1/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation

class NetworkDeposit {
	var deposits: [[Deposit]] = []
	
	var description: String {
		var str: String = ""
		
		for level in deposits {
			str += "\n{"
			for deposit in level {
				str += deposit.description+","
			}
			str += "}"
		}
		return str
	}
	
    /*
    * Creates the deposits network as a 2 dimension array
    */
	func createDesposits(upTo: Int) {
		var id: Int = 1
		var level: Int = 0
		var pos: Int = 0
		var maxPos: Int = 0
		
		deposits.append([])
		
		while (id <= upTo) {
			if (pos <= maxPos) {
				deposits[level].append(Deposit(id: id, level: level, pos: pos, network: self))
				pos += 1
			}
			if (pos > maxPos) {
				maxPos += 1
				level  += 1
				pos     = 0
				if (id < upTo) { deposits.append([]) }
			}
			
			id += 1
		}
	}
	
	/*
	* Fill the deposits network with the given network, starting with the root deposit
	*/
	func fill(litres: Double) {
		deposits[0][0].fill(litres: litres)
	}
	
	/*
	* Returns the number of litres stored in a given deposit
	*/
	func howManyLitres(id: Int) -> Double {
		for level in deposits {
			for deposit in level {
				if (deposit.id == id) { return deposit.capacity }
			}
		}
		
		return 0
	}

}

class Deposit {
    var capacity: Double = 0
    var id: Int
	var network: NetworkDeposit
	var level: Int = -1
	var pos: Int = -1
	var sons: [Deposit] { return [network.deposits[level+1][pos], network.deposits[level+1][pos+1]] }
	var fathers: [Deposit] {
		if (pos == 0) { return [network.deposits[level-1][0]] }
		else if (pos == network.deposits[level].count-1) { return [network.deposits[level-1][pos-1]] }
		else { return [network.deposits[level-1][pos-1], network.deposits[level-1][pos]]}
	}
	var description: String { return "["+String(self.id)+"/"+String(self.capacity)+"]" }

	init(id: Int, level: Int, pos: Int, network: NetworkDeposit) {
        self.id = id
        self.level = level
		self.pos = pos
		self.network = network
    }
	
	/*
	* Fill the deposit with a given number of litres
	*/
    func fill(litres: Double) {
		var rest: Double
		
		// If the number of litres to store will exceed 1000 litres in the deposit
		if ((self.capacity + litres) > 1000) {

			// Stores the 1000 litres in the deposit and calculates the remaining litres
			rest = litres - (1000 - self.capacity)
			self.capacity += (1000 - self.capacity)

			// Fill the son deposits with the remaining litres
			for son in self.sons {
				son.fill(litres: (rest / Double(sons.count)))
			}
		}
		// If it won't exceed the 1000 litres
		else if (litres > 0) {
			// Add the litres to the deposit
			self.capacity += litres
		}
	}
}
	
class R52017_Game {
	func play(upTo: Int, litres: Double, depositId: Int) {
		let network = NetworkDeposit()
		
		print("For \(upTo) deposits network and \(litres) litres => ", terminator: "")

		// Create the deposits network
		network.createDesposits(upTo: upTo)
		// And fill them
		network.fill(litres: litres)
		
		print("deposit #\(depositId) has \(network.howManyLitres(id: depositId)) litrers")
	}
}

