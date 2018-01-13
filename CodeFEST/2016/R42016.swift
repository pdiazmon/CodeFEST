//
//  R42016.swift
//  CodeFEST2016
//
//  Created by Pedro L. Diaz Montilla on 7/1/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation

class Order {
    var orderNumber: Int
    var weight: Int
    var price: Int
    
    init(parNumber: Int, parWeight: Int, parPrice: Int) {
        self.orderNumber = parNumber
        self.weight = parWeight
        self.price = parPrice
    }
    
    /*
    * Returns an string with all the order information
    */
    func toString() -> String {
        return "[\(self.orderNumber): \(self.weight.formattedWithSeparator) Kg, \(self.price.formattedWithSeparator) €]"
    }
}

class OrderStack {
    var orders: [Order]
    
    init() {
        orders = []
    }
    
    /*
    * Create an stack as a copy from other stack
    */
    convenience init(stackToCopy: OrderStack) {
        self.init()
        for order in stackToCopy.orders {
            self.addOrder(Order(parNumber: order.orderNumber, parWeight: order.weight, parPrice: order.price))
        }
    }
    
    /*
    * As the OrderStack only has an array of orders, subscript over the stack must be the same as over the array
    */
    subscript (index: Int) -> Order {
        get { return self.orders[index] }
        set { self.orders[index] = newValue }
    }
    
    /*
    * Returns an string with all the order stack information
    */
    func toString() -> String {
        var str: String = ""
        
        for order in orders {
            str += "\(order.toString()) "
        }
        
        return str
    }
    
    /*
    * Returns an string with all the order numbers in the stack
    */
    func stringOrderNumbers() -> String {
        var str: String = ""
        
        str += "["
        for order in orders {
             str += ((str.count > 1) ? "," : "") + String(order.orderNumber)
        }
        str += "]"
        
       return str
    }
    
    /*
    * Add a new order in the stack
    */
    func addOrder(_ parOrder: Order) {
        orders.append(parOrder)
    }
    
    /*
    * Removes an specific order from the stack
    */
    func removeOrder(nth: Int) {
        orders.remove(at: nth)
    }
    
    /*
    * Calculates the total price for all the orders in the stack
    */
    func totalPrice() -> Int {
        var total: Int = 0
        
        for i in 0..<orders.count {
            total += orders[i].price
        }
        
        return total
    }
    
    /*
     * Calculates the total weight for all the orders in the stack
     */
    func totalWeight() -> Int {
        var total: Int = 0
        
        for i in 0..<orders.count {
            total += orders[i].weight
        }
        
        return total
    }
}

class R42016_Game {
    private var initialOrders: OrderStack = OrderStack()
    var maxPrice:  Int = 0
    var maxWeight: Int = 0
    var maxOrderNumbers: String = ""
    
    /*
    * Add to an OrderStack the orders array received
    */
    func fillInitialOrders(parOrders: [[Int]]) {
        initialOrders.orders = []
        
        for i in 0..<parOrders.count {
            initialOrders.addOrder(Order(parNumber: i+1, parWeight: parOrders[i][0], parPrice: parOrders[i][1]))
        }
    }
    
    func play(parOrders: [[Int]]) {
        maxPrice = 0
        
        // Fill the initial orders stack with all the orders received in an array
        fillInitialOrders(parOrders: parOrders)
        
        print("For orders: \(initialOrders.toString()) => ", terminator: "")
        
        // For all the initial orders
        for n in 0..<initialOrders.orders.count {
            let currentCombination = OrderStack()
            var restOfOrders: OrderStack
            
            // Add the nth order in the initial stack to the current combination
            currentCombination.addOrder(initialOrders[n])
            
            // The rest of orders in the initial stack, except the nth order
            restOfOrders = OrderStack(stackToCopy: initialOrders)
            restOfOrders.removeOrder(nth: n)
            
            // Generate all the combinations from the nth initial order
            generateCombinations(current: currentCombination, restOfOrders: restOfOrders)
        }
        
        print("\(maxPrice.formattedWithSeparator) €, \(maxWeight.formattedWithSeparator) Kg, \(maxOrderNumbers) orders\n")
    }
    
    
    /*
    * Generate all the possible combinations from a current orders stack adding all the rest of the orders
    */
    func generateCombinations(current: OrderStack, restOfOrders: OrderStack) {
        
        // If the current stack price is higher than the maximum, set the maximum to the current's one
        if (current.totalPrice() > maxPrice) {
            maxPrice        = current.totalPrice()
            maxWeight       = current.totalWeight()
            maxOrderNumbers = current.stringOrderNumbers()
        }
        
        // For all the rest of the orders
        for n in 0..<restOfOrders.orders.count {
            
            // If the current stack weight plus the nth order of the rest is not higher than 8000 kg
            if (current.totalWeight() + restOfOrders[n].weight <= 8000) {
                
                // Create a copy of the current stack and another copy of the rest of the orders stack
                let currentCopy = OrderStack(stackToCopy: current)
                let restOfOrdersCopy = OrderStack(stackToCopy: restOfOrders)
                
                // Move the nth order from the rest of the orders stack to the current stack
                currentCopy.addOrder(restOfOrders[n])
                restOfOrdersCopy.removeOrder(nth: n)
                
                // Continue generating possible combinations with the rest of orders
                generateCombinations(current: currentCopy, restOfOrders: restOfOrdersCopy)
            }
        }
    }
}
