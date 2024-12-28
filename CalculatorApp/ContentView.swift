//
//  ContentView.swift
//  CalculatorApp
//
//  Created by roman on 03.12.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CalculatorViewModel()
    @State private var gradientStart = UnitPoint.topLeading
    @State private var gradientEnd = UnitPoint.bottomTrailing

    var body: some View {
        ZStack {
            // Градиентный фон
            LinearGradient(
                gradient: Gradient(colors: [Color.purple, Color.blue, Color.cyan]),
                startPoint: gradientStart,
                endPoint: gradientEnd
            )
            .ignoresSafeArea()
            .onAppear {
                animateGradient()
            }

            VStack(spacing: 10) {
                Spacer()

                // История операций
                Text(viewModel.history)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding([.leading, .trailing])

                // Экран калькулятора
                Text(viewModel.display)
                    .font(.system(size: 64))
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()

                
                
                // Кнопки калькулятора
                VStack(spacing: 10) {
                    ForEach(buttons, id: \.self) { row in
                        HStack(spacing: 10) {
                            ForEach(row, id: \.self) { button in
                                CalculatorButton(button: button, action: {
                                    viewModel.receiveInput(button)
                                })
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
        }
    }

    // Анимация для градиента
    private func animateGradient() {
        withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: true)) {
            gradientStart = UnitPoint.bottomTrailing
            gradientEnd = UnitPoint.topLeading
        }
    }
}

enum CalculatorButtonType: Hashable {
    case number(Int)
    case operation(String)
    case function(String)
    case equals
}

struct CalculatorButton: View {
    let button: CalculatorButtonType
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(buttonTitle)
                .font(.system(size: 32))
                .foregroundColor(.white)
                .frame(width: buttonWidth, height: buttonHeight)
                .background(buttonColor)
                .cornerRadius(buttonWidth / 2)
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5) // Тень для кнопок
        }
    }

    private var buttonTitle: String {
        switch button {
        case .number(let value): return "\(value)"
        case .operation(let symbol): return symbol
        case .function(let symbol): return symbol
        case .equals: return "="
        }
    }

    private var buttonColor: Color {
        switch button {
        case .number: return Color(.darkGray)
        case .operation: return Color.orange
        case .function: return Color.gray
        case .equals: return Color.orange
        }
    }

    private var buttonWidth: CGFloat {
        button == .number(0) ? 160 : 70
    }

    private var buttonHeight: CGFloat {
        70
    }
}
let buttons: [[CalculatorButtonType]] = [
    [.function("AC"), .function("+/-"), .function("%"), .operation("/")],
    [.number(7), .number(8), .number(9), .operation("x")],
    [.number(4), .number(5), .number(6), .operation("-")],
    [.number(1), .number(2), .number(3), .operation("+")],
    [.number(0), .equals]
]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
