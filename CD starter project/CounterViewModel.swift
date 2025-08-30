//
//  CounterViewModel.swift
//  CD starter project
//
//  Created by Othman Shahrouri on 31/05/2025.
//
import SwiftUI
import Foundation

// ViewModel for managing counter state and arithmetic operations
class CounterViewModel: ObservableObject {
    @Published private(set) var count: Int = 0

    func increment() {
        count += 1
    }

    func reset() {
        count = 0
    }
    
    func add(a: Int, b: Int) -> Int {
        return a + b
    }
    
    func subtract(a: Int, b: Int) -> Int {
        return a - b
    }
    
    func multiply(a: Int, b: Int) -> Int {
        return a * b
    }
    
    func isEven(number: Int) -> Bool {
        return number % 2 == 0
    }
    
    func power(base: Double, exponent: Double) -> Double {
        return pow(base, exponent)
    }
}
