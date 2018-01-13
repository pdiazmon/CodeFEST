//
//  R42017.swift
//  CodeFEST2017
//
//  Created by Pedro L. Diaz Montilla on 9/1/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation

let Danger = 1
let Free = 0

class Position {
    var x: Int = -1
    var y: Int = -1
    var description: String { return "{"+String(self.x)+","+String(self.y)+"}" }

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    /*
    * Return true if the position is at any bound of the map
    */
    func isExit(map: [[Int]]) -> Bool {
        return (self.x == 0 || self.y == 0 || (self.x == map[0].count-1) || (self.y == map.count-1))
    }
}

class Path {
    var path: [Position]
    var description: String {
        var str: String = "["
        
        for p in self.path {
            str += p.description
        }
        str += "]"
        
        return str
    }
    var count: Int { return path.count }
    
    init() {
        self.path = []
    }
    
    convenience init(_ other: Path) {
        self.init()
        self.path = other.path
    }
    
    /*
    * Return true if the path is empty and false if not
    */
    func isEmpty() -> Bool { return self.path.isEmpty }
    
    /*
    * Adds a new position to the path
    */
    func append(_ pos: Position) { self.path.append(pos) }
    
    /*
    * Return true if the position already exists in the path array
    */
    func exists(pos: Position) -> Bool {
        for p in path {
            if (p.x == pos.x && p.y == pos.y) { return true }
        }
        return false
    }
}

class R42017_Game {
    var map: [[Int]] = [[]]
    var minPath = Path()
    
    func play(parMap: [[Int]]) {
        var initialPosition: Position
        
        self.map = parMap
        minPath = Path()
		
		// Set the initial position at the center of the map
        initialPosition = Position(x: abs((map[0].count/2)), y: abs((map.count/2)))
		
		// Try the different routes from the center of the map
        tryRoute(position: initialPosition, path:Path())
        
        print("Minimal path with \(minPath.count) steps => \(minPath.description)")
        
    }
	
	/*
	* Try the different routes in the map from the given position on it
	*/
    func tryRoute(position: Position, path: Path) {
        var wPath: Path
        var wPosition: Position
		
		// If the path is greater than the already identified minimum path, return
        if ((path.count + 1) >= minPath.count && !minPath.isEmpty()) { return }
		
		// Add the given position to the path
        wPath = path
        wPath.append(position)
		
		// If the given position is an exit
        if (position.isExit(map: map) && (wPath.count < minPath.count || minPath.isEmpty())) {
            // New minimal path found
            minPath = wPath
            return
        }
        
        // Try up
        wPosition = Position(x: position.x, y: position.y-1)
        if (!wPath.exists(pos: wPosition) && position.y > 0 && map[position.y-1][position.x] != Danger) {
            tryRoute(position: wPosition, path: Path(wPath))
        }
        
        // Try down
        wPosition = Position(x:position.x, y: position.y+1)
        if (!wPath.exists(pos: wPosition) && position.y < map.count-1 && map[position.y+1][position.x] != Danger) {
            tryRoute(position: wPosition, path: Path(wPath))
        }
        
        // Try rigth
        wPosition = Position(x:position.x+1, y: position.y)
        if (!wPath.exists(pos: wPosition) && position.x < map[0].count-1 && map[position.y][position.x+1] != Danger) {
            tryRoute(position: wPosition, path: Path(wPath))
        }
        
        // Try left
        wPosition = Position(x:position.x-1, y: position.y)
        if (!wPath.exists(pos: wPosition) && position.x > 0 && map[position.y][position.x-1] != Danger) {
            tryRoute(position: wPosition, path: Path(wPath))
        }
    }
}
