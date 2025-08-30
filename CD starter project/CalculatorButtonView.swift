//
//  CalculatorButtonView.swift
//  CD starter project
//
//  Created by Othman Shahrouri on 30/08/2025.
//

import SwiftUI

struct CalculatorButtonView: View {
    let button: CalculatorButton
    let isAnimating: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: button.cornerRadius)
                .fill(button.backgroundColor)
                .shadow(
                    color: .black.opacity(0.08),
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

enum CalculatorButton: String, CaseIterable {
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
    case clear = "C"
    case plusMinus = "+/-"
    case percent = "%"
    case divide = "÷"
    case multiply = "×"
    case subtract = "−"
    case add = "+"
    case equals = "="
    
    private var buttonType: ButtonType {
        switch self {
        case .clear, .plusMinus, .percent: .function
        case .divide, .multiply, .subtract, .add, .equals: .operation
        default: .number
        }
    }
    
    private enum ButtonType {
        case function, operation, number
        
        var backgroundColor: Color {
            switch self {
            case .function: Color(red: 0.94, green: 0.94, blue: 0.96)
            case .operation: Color(red: 0.4, green: 0.6, blue: 0.85)
            case .number: Color.white
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .function: Color(red: 0.3, green: 0.3, blue: 0.35)
            case .operation: Color.white
            case .number: Color(red: 0.2, green: 0.2, blue: 0.25)
            }
        }
    }
    
    var backgroundColor: Color { buttonType.backgroundColor }
    var foregroundColor: Color { buttonType.foregroundColor }
    
    var displayText: String {
        switch self {
        case .plusMinus: return "±"
        default: return self.rawValue
        }
    }

    var cornerRadius: CGFloat {
        self == .zero ? 28 : 20 
    }
    
    var width: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let totalPadding: CGFloat = 76
        let buttonSpacing: CGFloat = 12
        let standardWidth = (screenWidth - totalPadding) / 4
        return self == .zero ? standardWidth * 2 + buttonSpacing : standardWidth
    }
    
    var height: CGFloat { 
        (UIScreen.main.bounds.width - 76) / 4 
    }

    var strokeGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.white.opacity(0.3),
                Color.clear
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
