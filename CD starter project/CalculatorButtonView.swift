//
//  CalculatorButtonView.swift
//  CD starter project
//
//  Created by Othman Shahrouri on 30/08/2025.
//

import SwiftUI

/// A view representing a single calculator button with custom styling and animation
struct CalculatorButtonView: View {
    /// The calculator button to display
    let button: CalculatorButton
    /// Whether the button is currently being animated
    let isAnimating: Bool
    /// The action to perform when the button is tapped
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: button.cornerRadius)
                .fill(button.backgroundColor)
                .shadow(
                    color: .black.opacity(0.12),
                    radius: isAnimating ? 2 : 6,
                    x: 0,
                    y: isAnimating ? 1 : 3
                )
                .overlay(
                    RoundedRectangle(cornerRadius: button.cornerRadius)
                        .stroke(button.strokeGradient, lineWidth: 0.5)
                )
                .overlay(
                    Text(button.displayText)
                        .font(.system(size: 28, weight: .regular, design: .rounded))
                        .foregroundColor(button.foregroundColor)
                        .scaleEffect(isAnimating ? 0.95 : 1.0)
                )
        }
        .frame(width: button.width, height: button.height)
        .buttonStyle(.plain)
    }
}

/// Represents the different types of calculator buttons
enum CalculatorButton: String, CaseIterable {
    // Number buttons
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case decimal = "."
    
    // Function buttons
    case clear = "C"
    case plusMinus = "+/-"
    case percent = "%"
    
    // Operation buttons
    case divide = "÷"
    case multiply = "×"
    case subtract = "−"
    case add = "+"
    case equals = "="
    
    /// Determines the type of button based on its function
    private var buttonType: ButtonType {
        switch self {
        case .clear, .plusMinus, .percent: .function
        case .divide, .multiply, .subtract, .add, .equals: .operation
        default: .number
        }
    }
    
    /// Defines the visual styling for different types of calculator buttons
    private enum ButtonType {
        /// Function buttons (clear, plus/minus, percent)
        case function
        /// Operation buttons (add, subtract, multiply, divide, equals)
        case operation
        /// Number buttons (0-9, decimal)
        case number
        
        /// The background color for this button type
        var backgroundColor: Color {
            switch self {
            case .function: Color(red: 0.92, green: 0.92, blue: 0.95)
            case .operation: Color(red: 0.35, green: 0.55, blue: 0.85)
            case .number: Color.white
            }
        }
        
        /// The text color for this button type
        var foregroundColor: Color {
            switch self {
            case .function: Color(red: 0.3, green: 0.3, blue: 0.35)
            case .operation: Color.white
            case .number: Color(red: 0.15, green: 0.15, blue: 0.2)
            }
        }
    }
    
    /// The background color of the button
    var backgroundColor: Color { buttonType.backgroundColor }
    
    /// The text color of the button
    var foregroundColor: Color { buttonType.foregroundColor }
    
    /// The text to display on the button
    var displayText: String {
        switch self {
        case .plusMinus: return "±"
        default: return self.rawValue
        }
    }

    /// The corner radius of the button
    var cornerRadius: CGFloat {
        self == .zero ? 28 : 20 
    }
    
    /// The width of the button, with the zero button being twice as wide
    var width: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let totalPadding: CGFloat = 76
        let buttonSpacing: CGFloat = 12
        let standardWidth = (screenWidth - totalPadding) / 4
        return self == .zero ? standardWidth * 2 + buttonSpacing : standardWidth
    }
    
    /// The height of the button
    var height: CGFloat { 
        (UIScreen.main.bounds.width - 76) / 4 
    }

    /// The gradient used for the button's stroke
    var strokeGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.white.opacity(0.4),
                Color.clear
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
