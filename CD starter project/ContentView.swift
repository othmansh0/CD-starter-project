//
//  ContentView.swift
//  CD starter project
//
//  Created by Othman Shahrouri on 31/05/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CalculatorViewModel()
    @State private var animateButton: String? = nil
    
    private static let buttonLayout: [[CalculatorButton]] = [
        [.clear, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equals]
    ]
    //
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

    private var backgroundGradient: some View {
        LinearGradient(
            colors: [
                Color(.systemGray6),
                Color(.systemGray5)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }

    private func displayArea(_ geometry: GeometryProxy) -> some View {
        VStack(alignment: .trailing, spacing: 8) {
            HStack {
                Spacer()
                Text(viewModel.operationSymbol ?? "")
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 4)
            }
            .frame(height: 20)

            Text(viewModel.formattedDisplay)
                .font(.system(size: dynamicFontSize, weight: .light, design: .rounded))
                .foregroundStyle(.primary)
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
    private func handleButtonTap(_ button: CalculatorButton) {
        animateButton(button.rawValue)
        provideFeedback()
        executeButtonAction(button)
    }
    
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
    
    private func provideFeedback() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
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
