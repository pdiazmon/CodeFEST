//
//  R32017.swift
//  CodeFEST2017
//
//  Created by Pedro L. Diaz Montilla on 8/1/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation

class Time {
    var hour: Int = 0
    var minute: Int = 0
    
    convenience init(time: String) {
        self.init()
        var stringSplit = time.components(separatedBy: ":")
        self.hour = Int(stringSplit[0])!
        self.minute = Int(stringSplit[1])!
    }
    
    convenience init(t: Time) {
        self.init()
        self.hour = t.hour
        self.minute = t.minute
    }
    
    /*
    * Converts the time into string
    */
    func toString() -> String {
        return String(self.hour) + ":" + String(self.minute)
    }
    
    /*
    * Adds a minute to the time
    */
    func oneMinuteMore() {
        self.minute += 1
        if (self.minute == 60) {
            self.minute = 0
            self.hour += 1
            
            if (self.hour == 24) {
                self.hour = 0
            }
        }
    }
    
    /*
    * Calculates the differente between the current time and another given one
    */
    func differenteInMinutes(other: Time) -> Int {
        var minutes: Int = 0
        
        // We expect other to be greater than self
        if (other < self) { return -1 }
        else {
            minutes += (60 - self.minute)
            minutes += (other.hour - self.hour - 1)
            minutes += (other.minute + 1)
        
            return minutes
        }
    }
    
    /*
    * Overrides the '<' operator for Time
    */
    static func < (left: Time, right: Time) -> Bool {
        if (left.hour < right.hour) { return true }
        else if ((left.hour == right.hour) && (left.minute < right.minute)) { return true }
        else { return false }
    }

    /*
     * Overrides the '>' operator for Time
     */
    static func > (left: Time, right: Time) -> Bool {
        if (left.hour > right.hour) { return true }
        else if ((left.hour == right.hour) && (left.minute > right.minute)) { return true }
        else { return false }
    }

    /*
     * Overrides the '==' operator for Time
     */
    static func == (left: Time, right: Time) -> Bool {
        return (left.hour == right.hour && left.minute == right.minute)
    }

    /*
     * Overrides the '>=' operator for Time
     */
    static func >= (left: Time, right: Time) -> Bool {
        return (left > right || left == right)
    }

    /*
     * Overrides the '<=' operator for Time
     */
    static func <= (left: Time, right: Time) -> Bool {
        return (left < right || left == right)
    }


}

class Vehicle {
    var id: Int = 0
    var inTime: Time
    var outTime: Time
    
    init(id: Int, inTime: String, outTime: String) {
        self.id = id
        self.inTime = Time(time: inTime)
        self.outTime = Time(time: outTime)
    }

    /*
    * Returns true if the vehicle is in at a given time
    */
    func isIn(time: Time) -> Bool {
        return (self.inTime <= time && self.outTime >= time)
    }
}

class Schedule {
    var vehicles: [Vehicle] = []
    
    /*
    * Fill the vehicles schedule array
    */
    func fillSchedule(parSchedule: [[Any]]) {
        
        for i in parSchedule {
            vehicles.append(Vehicle(id: (i[0] as! Int), inTime: (i[1] as! String), outTime: (i[2] as! String)))
        }
    }
    
    /*
    * Returns the first time for all the vehicles
    */
    func minInTime() -> Time {
        var minTime = Time(time: "23:59")
        
        for v in vehicles {
            if (v.inTime < minTime) {
                minTime = v.inTime
            }
        }
        
        return minTime
    }

    /*
    * Returns the last time for all the vehicles
    */
    func maxOutTime() -> Time {
        var maxTime = Time(time: "00:00")
        
        for v in vehicles {
            if (v.outTime > maxTime) {
                maxTime = v.outTime
            }
        }
        
        return maxTime
    }
    
    /*
    * Returns the number of vehicles that are in at a given time
    */
    func howManyVehicles(time: Time) -> Int {
        var cont: Int = 0
        
        for v in vehicles {
            if (v.isIn(time: time)) { cont += 1 }
        }
        return cont
    }

}

class R32017_Game {
    
    
    func play(parSchedule: [[Any]]) {
        let schedule = Schedule()
        var maxVehicles: Int = 0
        var t: Time
        var maxOutTime: Time
        var min: Time
        var max: Time
        var numVehicles: Int = 0
        
        schedule.fillSchedule(parSchedule: parSchedule)
        
        t = Time(t: schedule.minInTime())
        min = Time(t: schedule.minInTime())
        max = Time(t: schedule.maxOutTime())
        maxOutTime = Time(t: schedule.maxOutTime())
        
        // Since the first vehicle arrives until the last one goes
        while (t <= maxOutTime) {
            // Get the number of vehicles at the current time
            numVehicles = schedule.howManyVehicles(time: t)

            // If we have found the maximun number of vehicles
            if (numVehicles > maxVehicles) {
                maxVehicles = numVehicles
                min = Time(t: t)
                max = Time(t: t)
            }
            // If we continue having the maximum number of vehicles
            else if (numVehicles == maxVehicles) {
                // Extend the timeframe
                max = Time(t: t)
            }
            
            // Add one minute more
            t.oneMinuteMore()
        }
        
        print("Min Hour: \(min.toString()) - Max Hour: \(max.toString()) - Num Vehicles: \(maxVehicles)")
    }
}
