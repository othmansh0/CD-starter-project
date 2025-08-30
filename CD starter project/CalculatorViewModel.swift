//
//  CalculatorViewModel.swift
//  CD starter project
//
//  Created by Othman Shahrouri on 30/08/2025.
//

import Foundation
import Combine

final class CalculatorViewModel: ObservableObject {
    enum Operation: CaseIterable {
        case add, subtract, multiply, divide
        
        var symbol: String {
            switch self {
            case .add: "+"
            case .subtract: "−"
            case .multiply: "×"
            case .divide: "÷"
            }
        }
        
        func calculate(_ lhs: Double, _ rhs: Double) -> Double? {
            switch self {
            case .add: lhs + rhs
            case .subtract: lhs - rhs
            case .multiply: lhs * rhs
            case .divide: rhs != 0 ? lhs / rhs : nil
            }
        }
    }

    @Published private(set) var displayText: String = "0"
    @Published private(set) var currentOperation: Operation? = nil

    private let maximumDigits: Int = 9
    private var previousNumber: Double = 0
    private var shouldResetDisplay: Bool = false
    private var isEnteringNumber: Bool = false
    
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.groupingSeparator = ","
        formatter.usesGroupingSeparator = true
        return formatter
    }()

    var operationSymbol: String? {
        currentOperation?.symbol
    }

    var formattedDisplay: String {
        formatDisplay(displayText)
    }

    // MARK: - Public Actions
    func tapNumber(_ number: String) {
        if shouldResetDisplay || !isEnteringNumber || displayText == "0" {
            displayText = number
            shouldResetDisplay = false
            isEnteringNumber = true
        } else if digitCount(of: displayText) < maximumDigits {
            displayText += number
        }
    }

    func tapDecimal() {
        if shouldResetDisplay {
            displayText = "0."
            shouldResetDisplay = false
            isEnteringNumber = true
        } else if !displayText.contains(".") {
            displayText += "."
            isEnteringNumber = true
        }
    }

    func tapClear() {
        resetState()
    }

    func tapPlusMinus() {
        if let dec = currentDecimalValue() {
            displayText = decimalToString(-dec)
            isEnteringNumber = true
        }
    }

    func tapPercent() {
        if let dec = currentDecimalValue() {
            let result = dec / Decimal(100)
            displayText = decimalToString(result)
            isEnteringNumber = true
        }
    }

    func tapOperation(_ operation: Operation) {
        if let value = currentValue() {
            if currentOperation != nil && isEnteringNumber {
                tapEquals()
            } else {
                previousNumber = value
            }
            currentOperation = operation
            shouldResetDisplay = true
            isEnteringNumber = false
        }
    }

    func tapEquals() {
        guard let operation = currentOperation, 
              let currentValue = currentValue() else { return }

        guard let result = operation.calculate(previousNumber, currentValue) else {
            handleError()
            return
        }

        displayText = formatResult(result)
        updateStateAfterCalculation(result)
    }
    
    // MARK: - Helper Methods
    private func handleError() {
        displayText = "Error"
        resetState()
    }
    
    private func formatResult(_ result: Double) -> String {
        result.truncatingRemainder(dividingBy: 1) == 0 && abs(result) < 1e10 
            ? String(format: "%.0f", result) 
            : String(result)
    }
    
    private func updateStateAfterCalculation(_ result: Double) {
        previousNumber = result
        currentOperation = nil
        shouldResetDisplay = true
        isEnteringNumber = false
    }

    private func resetState() {
        displayText = "0"
        previousNumber = 0
        currentOperation = nil
        shouldResetDisplay = false
        isEnteringNumber = false
    }
    
    private func currentValue() -> Double? {
        Double(displayText.replacingOccurrences(of: ",", with: ""))
    }

    private func currentDecimalValue() -> Decimal? {
        Decimal(string: displayText.replacingOccurrences(of: ",", with: ""))
    }

    private func digitCount(of text: String) -> Int {
        text.filter { $0.isNumber }.count
    }

    private func formatDisplay(_ text: String) -> String {
        guard let number = Double(text.replacingOccurrences(of: ",", with: "")) else {
            return text
        }

        guard let formatted = numberFormatter.string(from: NSNumber(value: number)) else {
            return text
        }
        
        return preserveDecimalFormatting(original: text, formatted: formatted)
    }
    
    private func preserveDecimalFormatting(original: String, formatted: String) -> String {
        if original.hasSuffix(".") && !formatted.contains(".") {
            return formatted + "."
        }
        
        if original.contains(".") {
            let components = original.split(separator: ".")
            if components.count == 2 {
                let decimalPart = String(components[1])
                if decimalPart.hasSuffix("0") {
                    let formattedComponents = formatted.split(separator: ".")
                    if formattedComponents.count == 1 {
                        return formatted + "." + decimalPart
                    }
                }
            }
        }
        
        return formatted
    }

    private func decimalToString(_ value: Decimal) -> String {
        let ns = NSDecimalNumber(decimal: value)
        return ns.stringValue
    }
}


