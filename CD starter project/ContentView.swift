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
            Text("Count: \(viewModel.count)")
                .font(.largeTitle)
            HStack(spacing: 20) {
                Button("Increment") {
                    viewModel.increment()
                }
                Button("Reset") {
                    viewModel.reset()
                }
            }
            Divider()
            VStack(spacing: 10) {
                TextField("First Number", text: $firstNumber)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Second Number", text: $secondNumber)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                HStack {
                    Button("Add") {
                        if let a = Int(firstNumber), let b = Int(secondNumber) {
                            resultText = "\(viewModel.add(a: a, b: b))"
                        }
                    }
                    Button("Subtract") {
                        if let a = Int(firstNumber), let b = Int(secondNumber) {
                            resultText = "\(viewModel.subtract(a: a, b: b))"
                        }
                    }
                    Button("Multiply") {
                        if let a = Int(firstNumber), let b = Int(secondNumber) {
                            resultText = "\(viewModel.multiply(a: a, b: b))"
                        }
                    }
                }
                Button("Check Even") {
                    if let n = Int(firstNumber) {
                        resultText = viewModel.isEven(number: n) ? "Even" : "Odd"
                    }
                }
                Text("Result: \(resultText)")
                    .font(.headline)
                    .foregroundColor(.blue)
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

