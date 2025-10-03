//
//  CalculatorViewModel.swift
//  CD starter project
//
//  Created by Othman Shahrouri on 30/08/2025.
//

import Foundation
import Combine

/// The view model that handles the calculator's business logic and state
final class CalculatorViewModel: ObservableObject {
    /// Represents the mathematical operations that can be performed
    enum Operation: CaseIterable {
        /// Addition operation
        case add
        /// Subtraction operation
        case subtract
        /// Multiplication operation
        case multiply
        /// Division operation
        case divide
        
        /// The symbol representing this operation
        var symbol: String {
            switch self {
            case .add: "+"
            case .subtract: "−"
            case .multiply: "×"
            case .divide: "÷"
            }
        }
        
        /// Performs the calculation between two operands
        /// - Parameters:
        ///   - lhs: The left-hand side operand
        ///   - rhs: The right-hand side operand
        /// - Returns: The result of the calculation, or nil if the operation is invalid (e.g., division by zero)
        func calculate(_ lhs: Double, _ rhs: Double) -> Double? {
            switch self {
            case .add: lhs + rhs
            case .subtract: lhs - rhs
            case .multiply: lhs * rhs
            case .divide: rhs != 0 ? lhs / rhs : nil
            }
        }
    }

    /// The current text displayed on the calculator
    @Published private(set) var displayText: String = "0"
    /// The current operation being performed, if any
    @Published private(set) var currentOperation: Operation? = nil

    /// The maximum number of digits that can be entered
    private let maximumDigits: Int = 9
    /// The previous number entered before an operation was selected
    private var previousNumber: Double = 0
    /// Whether the display should be reset on the next number input
    private var shouldResetDisplay: Bool = false
    /// Whether the user is currently entering a number
    private var isEnteringNumber: Bool = false
    
    /// Formatter for displaying numbers with proper decimal and thousands separators
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.groupingSeparator = ","
        formatter.usesGroupingSeparator = true
        return formatter
    }()

    /// The symbol for the current operation, if any
    var operationSymbol: String? {
        currentOperation?.symbol
    }

    /// The formatted display text with proper number formatting
    var formattedDisplay: String {
        formatDisplay(displayText)
    }

    // MARK: - Public Actions
    
    /// Handles a number button tap
    /// - Parameter number: The number that was tapped (as a string)
    func tapNumber(_ number: String) {
        if shouldResetDisplay || !isEnteringNumber || displayText == "0" {
            displayText = number
            shouldResetDisplay = false
            isEnteringNumber = true
        } else if digitCount(of: displayText) < maximumDigits {
            displayText += number
        }
    }

    /// Handles the decimal point button tap
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

    /// Handles the clear button tap
    func tapClear() {
        resetState()
    }

    /// Handles the plus/minus button tap to toggle the sign of the current number
    func tapPlusMinus() {
        if let dec = currentDecimalValue() {
            displayText = decimalToString(-dec)
            isEnteringNumber = true
        }
    }

    /// Handles the percent button tap to convert the current number to a percentage
    func tapPercent() {
        if let dec = currentDecimalValue() {
            let result = dec / Decimal(100)
            displayText = decimalToString(result)
            isEnteringNumber = true
        }
    }

    /// Handles an operation button tap
    /// - Parameter operation: The operation to perform
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

    /// Handles the equals button tap to perform the calculation
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


