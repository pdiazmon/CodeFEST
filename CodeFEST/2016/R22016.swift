//
//  R22016.swift
//  CodeFEST2016
//
//  Created by Pedro L. Diaz Montilla on 5/1/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation


class R22016_Display {
    
    /*
    * Returns the number of segments powered on in a 7-segments display for a given number (0..9)
    */
    func digitConsumption(_ number: Int) -> Int {
        switch number {
            case 0: return 6
            case 1: return 2
            case 2: return 5
            case 3: return 5
            case 4: return 4
            case 5: return 5
            case 6: return 6
            case 7: return 3
            case 8: return 7
            case 9: return 6
            default: return Int.max
        }
    }
    
    /*
    * Returns the power consumption for a double digit
    */
    func doubleDigitConsumption(_ doubleDigit: Int) -> Int {
        return digitConsumption(doubleDigit/10) + digitConsumption(doubleDigit%10)
    }
    
    /*
    * Returns the power consumption for the whole display for given hours, minutes and seconds
    */
    func displayConsumption(hours: Int, minutes: Int, seconds: Int) -> Int {
        return doubleDigitConsumption(hours) + doubleDigitConsumption(minutes) + doubleDigitConsumption(seconds)
    }
    
}

class R22016_Game {
    let display = R22016_Display()
    
    func play(days: Int, hours: Int, minutes: Int, seconds: Int) {
        var consumption: Int = 0
        
        // Calculate the n first days consumption
        // The rest, for the last day's consumption, is calculated after
        for _ in 0..<days {
            for hour in 0..<24 {
                for minute in 0..<60 {
                    for second in 1...60 {
                        consumption += display.displayConsumption(hours: hour, minutes: minute, seconds: second)
                    }
                }
            }
        }
        
        // Calculate the last day hour's consumption
        for hour in 0..<hours {
            for minute in 1..<60 {
                for second in 1...60 {
                    consumption += display.displayConsumption(hours: hour, minutes: minute, seconds: second)
                }
            }
        }
        
        // Calculate the last hour minute's consumption
        for minute in 0..<minutes {
            for second in 1...60 {
                consumption += display.displayConsumption(hours: hours, minutes: minute, seconds: second)
            }

        }
        
        // Calculate the last minute second's consumption
        for second in 0..<seconds {
              consumption += display.displayConsumption(hours: hours, minutes: minutes, seconds: second)
            
        }
        
        print("For \(days) days, \(hours) hours, \(minutes) minutes and \(seconds) seconds => \(consumption.formattedWithSeparator) WH consumed")
    }
}
