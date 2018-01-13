//
//  R52016.swift
//  CodeFEST2016
//
//  Created by Pedro L. Diaz Montilla on 7/1/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation

class City {
    var cityId: Int = 0
    var cityPaths: [Int] = []

    init(cityId: Int, paths: [Int]) {
        self.cityId = cityId
        self.cityPaths = paths
    }
}

class CitiesSet {
    var set: [City] = []
    var count: Int { return set.count }
    
    init() {
        set = []
    }
    
    /*
    * Creates a new CityStet as a copy from other one
    */
    convenience init(copyFrom: CitiesSet) {
        self.init()
        for c in copyFrom.set {
            self.set.append(City(cityId: c.cityId, paths: c.cityPaths))
        }
    }
    
    /*
     * As the CitiesSet only has an array of cities, subscript over the set must be the same as over the array
     */
    subscript (index: Int) -> City {
        get { return self.set[index] }
        set { self.set[index] = newValue }
    }
    
    /*
    * Removes an specific city from the set
    */
    func removeCity(cityId: Int) {
        for n in 0..<set.count {
            if (set[n].cityId == cityId) {
                set.remove(at: n)
                return
            }
        }
    }
    
    /*
    * Returns true if an specific city is in the set. If not, returns false
    */
    func isIncluded(cityId: Int) -> Bool {
        for c in set {
            if (c.cityId == cityId) {return true}
        }
        
        return false
    }
    
    /*
    * Returns true if a city is reacheable from the current one
    */
    func isReacheable(cityId: Int) -> Bool {
        for c in self.set {
            if (c.cityId == cityId || c.cityPaths.contains(cityId)) {return true}
        }
        return false
    }
    
    /*
    * Adds a new path from the current city to another one
    */
    func addPathToCity(cityId: Int, newPath: Int) {
        for c in set {
            if (c.cityId == cityId && !c.cityPaths.contains(newPath)) {
                c.cityPaths.append(newPath)
            }
        }
    }
    
    /*
    * Returns true if all the cities in the given city set are reacheable from the current one
    */
    func areAllTheCities(completeList: CitiesSet) -> Bool {
        for c in completeList.set {
            if (!self.isReacheable(cityId: c.cityId)) {return false}
        }
        return true
    }
    
    /*
    * Returns an string with all the information of the cities in the set
    */
    func toStringCities() -> String {
        var str: String = ""
        
        str = "["
        for c in self.set {
            str += ((str.count > 1) ? ", " : "") + String(c.cityId)
        }
        str += "]"
        
        return str
    }
    
    /*
    * Returns an string with all the information of the paths from the current city
    */
    func toStringPaths(index: Int) -> String {
        var str: String = ""
        
        for p in set[index].cityPaths {
            str += ((str.count >= 1) ? ", " : "") + String(p)
        }
        
        return str
    }
    
    /*
    * Returns an string with all the information of the cities in the set and their paths
    */
    func toStringCitiesAndPaths() -> String {
        var str: String = ""
        
        str = "{"
        for n in 0..<self.set.count {
            str += ((str.count > 1) ? " - " : "") + "{" + String(self.set[n].cityId) + ": " + self.toStringPaths(index: n) + "}"
        }
        str += "}"
        
        return str
    }

}

class R52016_Game {
    var cities = CitiesSet()
    var minCities: Int = Int.max
    var minSet: CitiesSet?
    
    /*
    * Fill the CitiesSet with all the paths in an array
    */
    func fillCities(paths: [[Int]]) {
        cities.set = []
        
        // For all the paths
        for p in paths {
            
            // If origin city is not included yet in the set, add it
            if (!self.cities.isIncluded(cityId: p[0])) {
                cities.set.append(City(cityId: p[0], paths: [p[1]]))
            }
            // If it is already included, just add the path
            else {
                cities.addPathToCity(cityId: p[0], newPath: p[1])
            }
            
            // If target city is not included yet, add it
            if (!self.cities.isIncluded(cityId: p[1])) {
                cities.set.append(City(cityId: p[1], paths: [p[0]]))
            }
            // If it is already included, just add the path
            else {
                cities.addPathToCity(cityId: p[1], newPath: p[0])
            }
            
        }
    }
    
    func play(paths: [[Int]]) {

        minCities = Int.max
        
        // Fill the set with all the paths information
        fillCities(paths: paths)
        
        print("Initial paths: \(cities.toStringCitiesAndPaths())")
        
        // For all the cities in the set
        for city in cities.set {
        
            let currentStack = CitiesSet()
            var restOfCities = CitiesSet()

            // Moves the city from the 'rest' set to the 'current' one
            currentStack.set.append(city)
            restOfCities = CitiesSet(copyFrom: cities)
            restOfCities.removeCity(cityId: city.cityId)
            
            // Generate all the combinations starting with the 'city'
            generateCombinations(current: currentStack, rest: restOfCities)
        }
        
        print("Minimal cities set: \(minCities) => \(minSet!.toStringCities())")
        
    }
    
    /*
    * From a given current stack of cities and the rest of the cities in another set, generate all the combinations adding cities from the 'rest' stack to the 'current' one
    */
    func generateCombinations(current: CitiesSet, rest: CitiesSet) {
        
        // If the current set already has more or equal cities than the minimum, discard the combination and return
        if (current.count >= minCities) { return }
        else if(current.count < minCities) {

            // If the current combination already has all the cities, we have found a new minimum
            if (current.areAllTheCities(completeList: self.cities)) {
                minCities = current.count
                minSet    = CitiesSet(copyFrom: current)
            }
                
            // If not, keep generating combinations from the current one
            else {
                
                // For all the rest of the cities
                for n in 0..<rest.count {
                    
                    // Create a copy of the current cities set and another for the rest ones
                    let currentCopy = CitiesSet(copyFrom: current)
                    let restCopy = CitiesSet(copyFrom: rest)

                    // Move the nth city in the 'rest' set to the current one
                    currentCopy.set.append(restCopy[n])
                    restCopy.removeCity(cityId: restCopy[n].cityId)
                    
                    // ... and generate combinations from it
                    generateCombinations(current: currentCopy, rest: restCopy)
                }
            }
        }
    }
}
