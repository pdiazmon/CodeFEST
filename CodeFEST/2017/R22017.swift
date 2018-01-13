//
//  R22017.swift
//  CodeFEST2017
//
//  Created by Pedro L. Diaz Montilla on 8/1/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation

class Client {
    var DNI: String = ""
    var name: String = ""
    var lastName1: String = ""
    var lastName2: String = ""
    var email: String = ""
    
    init(DNI: String, name: String, lastName1: String, lastName2: String, email: String) {
        self.DNI       = DNI
        self.name      = name
        self.lastName1 = lastName1
        self.lastName2 = lastName2
        self.email     = email
    }
}

class BDClients {
    var clients: [Client] = []
    
    /*
    * Add a new client to the array
    */
    func addClient(_ newClient: Client) {
        clients.append(newClient)
    }
	
    /*
    * Empty the clients array
    */
	func emptyBD() {
		clients = []
	}
	
    /*
    * Search a client by its DNI
    */
	func searchByDNI(DNI: String) -> Client? {
		for c in clients {
			if (c.DNI == DNI) { return c }
		}
		
		return nil
	}
}

extension Character {
	
    /*
    * Returns true if the character is numeric and false if not
    */
	func isNumber() -> Bool {
		if (self >= "0" && self <= "9") {
			return true
		}
		else{
			return false
		}
	}

    /*
    * Returns true if the character is alphabetic and false if not
    */
	func isAlpha() -> Bool {
		if ((self >= "A" && self <= "Z") || (self >= "a" && self <= "z")) {
			return true
		}
		else{
			return false
		}
	}

}

extension String {
	
	subscript (i: Int) -> Character {
		return self[index(startIndex, offsetBy: i)]
	}
}

extension Int {
    
    /*
    * Calculates the corresponding letter for the DNI number
    */
	func DNILetter() -> Character {
		let letters: [Character] = ["T", "R", "W", "A", "G", "M", "Y", "F", "P", "D", "X", "B", "N", "J", "Z", "S", "Q", "V", "H", "L", "C", "K", "E"]
		return letters[self]
	}
}



class R22017_Game {
	var clients: BDClients = BDClients()
	
    /*
    * Fill the clients array
    */
    func fillBDClients(arrayClients: [[String]]) {
		clients.emptyBD()
		
        for client in arrayClients {
			clients.addClient(Client(DNI: client[5], name: client[0], lastName1: client[1], lastName2: client[2], email: client[6]))
        }
    }
	
    /*
    * Checks if the DNI is well formed and returns:
    * - true if the DNI is well formed and false if not
    * - ans string with the DNI, including its letter
    */
	func checkDNI(string: String, index: Int) -> (Bool, String) {
		var number: String = ""
		
		// 8 first characters must be numbers
		for i in index...(index+7) {
			if (!string[i].isNumber()) { return (false, "") }
			number.append(string[i])
		}
		
		// 9th character must be a letter
		if (!string[index+8].isAlpha()) {
			return (false, "")
		}
		
		// And, finally, the letter must be the right one
		if (!checkDNILetter(number: Int(number)!, letter: string[index+8])) {
			return (false, "")
		}
		
		number.append(string[index+8])
		return (true, number)
	}
	
    /*
    * Checks if the letter corresponds to the DNI number and returns true if yes and false if not
    */
	func checkDNILetter(number: Int, letter: Character) -> Bool {
		return ((number % 23).DNILetter() == letter)
	}
	
    /*
    * Compose and return an string with the email's text
    */
	func composeEmail(client: Client) -> String {
		return "\nTo: " + client.email + "\nBody: Hola " + client.name + " " + client.lastName1 + " " + client.lastName2 + ": nos ponemos contacto para indicarte que nuestro sistema de alarmas ha detectado que tu DNI no " + client.DNI + " aparece en el BOE de la fecha de hoy. Un saludo."
	}
	
	func play(arrayClients: [[String]], BOE: String) {
		var outputFile: String = ""
		var sDNI: String
		var okDNI: Bool
		var wClient: Client?
		var contClients: Int = 0
		
		// Fill the clients array
		fillBDClients(arrayClients: arrayClients)
		
        // For all the BOE text characters
		for index in 0..<BOE.count {
            
            // If the character is a number
			if (BOE[index].isNumber()) {
                
				// Possible start of DNI
				(okDNI, sDNI) = checkDNI(string: BOE, index: index)
				
                // If we have found a DNI in the BOE text
				if (okDNI) {
                    
                    // Seach the client in the clients array by its DNI
					wClient = clients.searchByDNI(DNI: sDNI)
					
                    // If the client exists in the array
					if (wClient != nil) {
						outputFile.append(composeEmail(client: wClient!))
						contClients += 1
					}
				}
			}
		}

		print("\nFinished => \(contClients) found.")
        print("\(outputFile)")
	}
}
