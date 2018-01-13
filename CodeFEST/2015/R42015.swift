//
//  R42015.swift
//  CodeFEST2015
//
//  Created by Pedro L. Diaz Montilla on 1/1/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation

enum Direction: String {
	case N = "North"
	case S = "South"
	case W = "West"
	case E = "East"
	case NW = "NorthWest"
	case NE = "NorthEast"
	case SW = "SouthWest"
	case SE = "SouthEast"
	case nodef = "n/a"
}

class R42015_Field {
	var field: [[Int]] = [[]]
	var maxX: Int = 0
	var maxY: Int = 0

	init(parField: [[Int]]) {
		field = parField
        // Calculate the field bounds
		maxY = parField.count - 1
		maxX = parField[0].count - 1
	}
	
    /*
    * Calculate and return the collected product if we move to the EAST 3 positions
    */
	func calculateEast(x: Int, y: Int) -> Int {
		var res:Int = field[y][x]
		
		res += (maxX >= (x+1) ? field[y][x+1] : 0)
		res += (maxX >= (x+2) ? field[y][x+2] : 0)
		res += (maxX >= (x+3) ? field[y][x+3] : 0)
		
		return res
	}
    
    /*
    * Calculate and return the collected product if we move to the WEST 3 positions
    */
	func calculateWest(x: Int, y: Int) -> Int {
		var res:Int = field[y][x]
		
		res += ((x-1) >= 0 ? field[y][x-1] : 0)
		res += ((x-2) >= 0 ? field[y][x-2] : 0)
		res += ((x-3) >= 0 ? field[y][x-3] : 0)
		
		return res
	}
    
    /*
    * Calculate and return the collected product if we move to the NORTH 3 positions
    */
	func calculateNorth(x: Int, y: Int) -> Int {
		var res:Int = field[y][x]
		
		res += ((y-1) >= 0 ? field[y-1][x] : 0)
		res += ((y-2) >= 0 ? field[y-2][x] : 0)
		res += ((y-3) >= 0 ? field[y-3][x] : 0)

		return res
    }
    
    /*
    * Calculate and return the collected product if we move to the SOUTH 3 positions
    */
	func calculateSouth(x: Int, y: Int) -> Int {
		var res:Int = field[y][x]
		
		res += (maxY >= (y+1) ? field[y+1][x] : 0)
		res += (maxY >= (y+2) ? field[y+2][x] : 0)
		res += (maxY >= (y+3) ? field[y+3][x] : 0)
		
		return res
	}
    
    /*
    * Calculate and return the collected product if we move to the NORTHEAST 3 positions
    */
	func calculateNorthEast(x: Int, y: Int) -> Int {
		var res:Int = field[y][x]
		
		res += ((y-1) >= 0 && maxX >= (x+1) ? field[y-1][x+1] : 0)
		res += ((y-2) >= 0 && maxX >= (x+2) ? field[y-2][x+2] : 0)
		res += ((y-3) >= 0 && maxX >= (x+3) ? field[y-3][x+3] : 0)

		return res
	}
    
    /*
    * Calculate and return the collected product if we move to the NORTHWEST 3 positions
    */
	func calculateNorthWest(x: Int, y: Int) -> Int {
		var res:Int = field[y][x]
		
		res += ((y-1) >= 0 && (x-1) >= 0 ? field[y-1][x-1] : 0)
		res += ((y-2) >= 0 && (x-2) >= 0 ? field[y-2][x-2] : 0)
		res += ((y-3) >= 0 && (x-3) >= 0 ? field[y-3][x-3] : 0)

		return res
	}
    
    /*
    * Calculate and return the collected product if we move to the SOUTHEAST 3 positions
    */
	func calculateSouthEast(x: Int, y: Int) -> Int {
		var res:Int = field[y][x]
		
		res += ((maxY >= (y+1) && maxX >= (x+1)) ? field[y+1][x+1] : 0)
		res += ((maxY >= (y+2) && maxX >= (x+2)) ? field[y+2][x+2] : 0)
		res += ((maxY >= (y+3) && maxX >= (x+3)) ? field[y+3][x+3] : 0)

		return res
	}
    
    /*
    * Calculate and return the collected product if we move to the SOUTHWEST 3 positions
    */
	func calculateSouthWest(x: Int, y: Int) -> Int {
		var res:Int = field[y][x]
		
		res += ((maxY >= (y+1) && (x-1) >= 0) ? field[y+1][x-1] : 0)
		res += ((maxY >= (y+2) && (x-2) >= 0) ? field[y+2][x-2] : 0)
		res += ((maxY >= (y+3) && (x-3) >= 0) ? field[y+3][x-3] : 0)

		return res
	}

	
}

class R42015_Game {

	func play(parField: [[Int]]) {
		var maxValue: Int = 0
		var maxValueX: Int = -1
		var maxValueY: Int = -1
		let field = R42015_Field(parField: parField)
		var maxDirection: Direction = Direction.nodef
		var East: Int
		var West: Int
		var North: Int
		var South: Int
		var NorthEast: Int
		var NorthWest: Int
		var SouthWest: Int
		var SouthEast: Int

        // For all the rows
		for y in 0...field.maxY {
            // For all the columns
			for x in 0...field.maxX {
                
                // Calculate all the collected products if we move in all directions
				East = field.calculateEast(x: x, y: y)
				West = field.calculateWest(x: x, y: y)
				North = field.calculateNorth(x: x, y: y)
				South = field.calculateSouth(x: x, y: y)
				NorthEast = field.calculateNorthEast(x: x, y: y)
				NorthWest = field.calculateNorthWest(x: x, y: y)
				SouthWest = field.calculateSouthWest(x: x, y: y)
				SouthEast = field.calculateSouthEast(x: x, y: y)

                // Compare each direction's result with the minimum and get the direction, position and direction if it is the higher
				if(maxValue < East) {
					maxValue = East
					maxValueX = x
					maxValueY = y
					maxDirection = Direction.E
				}
				if(maxValue < West) {
					maxValue = West
					maxValueX = x
					maxValueY = y
					maxDirection = Direction.W
				}
				if(maxValue < North) {
					maxValue = North
					maxValueX = x
					maxValueY = y
					maxDirection = Direction.N
				}
				if(maxValue < South) {
					maxValue = South
					maxValueX = x
					maxValueY = y
					maxDirection = Direction.S
				}
				if(maxValue < NorthEast) {
					maxValue = NorthEast
					maxValueX = x
					maxValueY = y
					maxDirection = Direction.NE
				}
				if(maxValue < NorthWest) {
					maxValue = NorthWest
					maxValueX = x
					maxValueY = y
					maxDirection = Direction.NW
				}
				if(maxValue < SouthEast) {
					maxValue = SouthEast
					maxValueX = x
					maxValueY = y
					maxDirection = Direction.SE
				}
				if(maxValue < SouthWest) {
					maxValue = SouthWest
					maxValueX = x
					maxValueY = y
					maxDirection = Direction.SW
				}
			}
		}
		
        print("Max Value: \(maxValue)")
        print("X: \(maxValueX) - Y: \(maxValueY)")
		print("Direction = \(maxDirection.rawValue)\n")
	}
	
	
}
