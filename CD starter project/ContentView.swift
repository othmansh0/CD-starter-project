//
//  ContentView.swift
//  CD starter project
//
//  Created by Othman Shahrouri on 31/05/2025.
//

import SwiftUI

/// The main calculator view that displays the calculator UI and handles user interactions
struct ContentView: View {
    /// The view model that handles the calculator's business logic
    @StateObject private var viewModel = CalculatorViewModel()
    /// Tracks which button is currently being animated
    @State private var animateButton: String? = nil
    
    /// The layout of calculator buttons in a 2D grid
    private static let buttonLayout: [[CalculatorButton]] = [
        [.clear, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equals]
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundGradient
                
                VStack(spacing: 0) {
                    displayArea(geometry)
                    
                    buttonsArea
                }
            }
        }
    }

    /// Creates a subtle background gradient for the calculator
    private var backgroundGradient: some View {
        LinearGradient(
            colors: [
                Color(red: 0.92, green: 0.95, blue: 0.98),
                Color(red: 0.85, green: 0.90, blue: 0.95)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }

    /// Renders the calculator display area showing the current operation and result
    /// - Parameter geometry: The geometry proxy for responsive sizing
    /// - Returns: A view containing the operation symbol and formatted display text
    private func displayArea(_ geometry: GeometryProxy) -> some View {
        VStack(alignment: .trailing, spacing: 8) {
            HStack {
                Spacer()
                Text(viewModel.operationSymbol ?? "")
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundStyle(Color(red: 0.4, green: 0.5, blue: 0.6))
                    .padding(.horizontal, 4)
            }
            .frame(height: 20)

            Text(viewModel.formattedDisplay)
                .font(.system(size: dynamicFontSize, weight: .light, design: .rounded))
                .foregroundStyle(Color(red: 0.1, green: 0.2, blue: 0.3))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .contentTransition(.numericText())
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 20)
        .frame(height: geometry.size.height * 0.3)
    }

    /// Renders the calculator buttons grid layout
    /// - Returns: A view containing the calculator buttons arranged in rows and columns
    private var buttonsArea: some View {
        VStack(spacing: 12) {
            ForEach(Self.buttonLayout, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(row, id: \.self) { button in
                        CalculatorButtonView(
                            button: button,
                            isAnimating: animateButton == button.rawValue
                        ) {
                            handleButtonTap(button)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 30)
    }
    
    /// Calculates the appropriate font size based on the number of digits in the display
    /// - Returns: The font size that will fit the current display value
    private var dynamicFontSize: CGFloat {
        let digitCount = viewModel.formattedDisplay.filter { $0.isNumber }.count
        return switch digitCount {
        case 10...: 40
        case 8...9: 48
        case 6...7: 56
        default: 64
        }
    }
    
    // MARK: - Actions
    
    /// Handles the tap event on a calculator button
    /// - Parameter button: The calculator button that was tapped
    private func handleButtonTap(_ button: CalculatorButton) {
        animateButton(button.rawValue)
        provideFeedback()
        executeButtonAction(button)
    }
    
    /// Animates the button press with a subtle scale effect
    /// - Parameter buttonValue: The raw value of the button to animate
    private func animateButton(_ buttonValue: String) {
        withAnimation(.easeInOut(duration: 0.1)) {
            animateButton = buttonValue
        }
        
        Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(100))
            withAnimation(.easeInOut(duration: 0.1)) {
                animateButton = nil
            }
        }
    }
    
    /// Provides haptic feedback when a button is tapped
    private func provideFeedback() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    /// Executes the appropriate action based on the button type
    /// - Parameter button: The calculator button that was tapped
    private func executeButtonAction(_ button: CalculatorButton) {
        switch button {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            viewModel.tapNumber(button.rawValue)
        case .decimal:
            viewModel.tapDecimal()
        case .clear:
            viewModel.tapClear()
        case .plusMinus:
            viewModel.tapPlusMinus()
        case .percent:
            viewModel.tapPercent()
        case .add:
            viewModel.tapOperation(.add)
        case .subtract:
            viewModel.tapOperation(.subtract)
        case .multiply:
            viewModel.tapOperation(.multiply)
        case .divide:
            viewModel.tapOperation(.divide)
        case .equals:
            viewModel.tapEquals()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
