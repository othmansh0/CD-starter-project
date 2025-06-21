//
//  ContentView.swift
//  CD starter project
//
//  Created by Othman Shahrouri on 31/05/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CounterViewModel()
    
    @State private var firstNumber: String = ""
    @State private var secondNumber: String = ""
    @State private var resultText: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            //test test
            Text("🔢 Count: \(viewModel.count)")
                .font(.largeTitle)
                .fontWeight(.bold)
            HStack(spacing: 20) {
                Button("➕ Increment") {
                    viewModel.increment()
                }
                .buttonStyle(.borderedProminent)
                Button("🔄 Reset") {
                    viewModel.reset()
                }
                .buttonStyle(.bordered)
            }
            Divider()
            // Calculator section with basic arithmetic operations
            VStack(spacing: 10) {
                Text("🧮 Calculator")
                    .font(.title2)
                    .fontWeight(.semibold)
                TextField("🔢 First Number", text: $firstNumber)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("🔢 Second Number", text: $secondNumber)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                HStack(spacing: 8) {
                    Button("➕ Add") {
                        if let a = Int(firstNumber), let b = Int(secondNumber) {
                            resultText = "\(viewModel.add(a: a, b: b))"
                        }
                    }
                    .buttonStyle(.bordered)
                    Button("➖ Sub") {
                        if let a = Int(firstNumber), let b = Int(secondNumber) {
                            resultText = "\(viewModel.subtract(a: a, b: b))"
                        }
                    }
                    .buttonStyle(.bordered)
                    Button("✖️ Mul") {
                        if let a = Int(firstNumber), let b = Int(secondNumber) {
                            resultText = "\(viewModel.multiply(a: a, b: b))"
                        }
                    }
                    .buttonStyle(.bordered)
                    Button("➗ Div") {
                        if let a = Double(firstNumber), let b = Double(secondNumber) {
                            if b != 0 {
                                resultText = String(format: "%.2f", Double(a) / Double(b))
                            } else {
                                resultText = "Cannot divide by zero"
                            }
                        }
                    }
                    .buttonStyle(.bordered)
                    Button("🔋 Pow") {
                        if let a = Double(firstNumber), let b = Double(secondNumber) {
                            resultText = String(format: "%.2f", viewModel.power(base: a, exponent: b))
                        }
                    }
                    .buttonStyle(.bordered)
                }
                Button("🔍 Check Even/Odd") {
                    if let n = Int(firstNumber) {
                        resultText = viewModel.isEven(number: n) ? "✅ Even" : "❌ Odd"
                    }
                }
                .buttonStyle(.borderedProminent)
                Text("📊 Result: \(resultText)")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(.top, 5)
            }.padding()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

