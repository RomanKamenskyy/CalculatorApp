//
//  CalculatorViewModel.swift
//  CalculatorApp
//
//  Created by roman on 03.12.2024.
//

import Foundation

class CalculatorViewModel: ObservableObject {
    @Published var display = "0" // Текущая строка на экране
    @Published var history = "" // История операций

    private var currentNumber: Double = 0
    private var previousNumber: Double = 0
    private var currentOperation: CalculatorButtonType?
    private var historyNumber: Double = 0
    
    func receiveInput(_ button: CalculatorButtonType) {
        switch button {
        case .number(let value):
            appendNumber(value)
        case .operation(let symbol):
            setOperation(symbol)
        case .equals:
            calculateResult()
        case .function(let function):
            performFunction(function)
        }
    }

    private func appendNumber(_ value: Int) {
        
       
        if display == "0" || currentOperation == .equals {
            display = "\(value)"
        } else {
            display += "\(value)"
        }
        currentNumber = Double(display) ?? 0
        
       // history = "\(formatNumber(currentNumber))"+"\(operation)"
    }

    private func setOperation(_ symbol: String) {
        // Если операция уже выбрана, то нужно выполнить промежуточное вычисление
        if currentOperation != nil {
            calculateResult()
        }
        
      
        // Сохраняем текущую операцию и предыдущее число
        currentOperation = .operation(symbol)
        previousNumber = currentNumber // Сохраняем первое число
        //currentNumber = 0 // Готовимся к вводу второго числа
        display = "0"
        
   
        
    }

    private func calculateResult() {
        guard let operation = currentOperation else { return }
       
        switch operation {
        case .operation(let symbol):
            switch symbol {
            case "+":
                historyNumber = currentNumber
                currentNumber = previousNumber + currentNumber
            case "-":
                historyNumber = currentNumber
                currentNumber = previousNumber - currentNumber
              
            case "x":
                historyNumber = currentNumber
                currentNumber = previousNumber * currentNumber
           
            case "/":
                historyNumber = currentNumber
                currentNumber = currentNumber == 0 ? 0 : previousNumber / currentNumber
            default:
                break
            }
            print(currentNumber)
            // Обновляем историю правильно
            history = "\(formatNumber(previousNumber)) \(symbol) \(formatNumber(historyNumber)) = \(formatNumber(currentNumber))"
            
            // Результат становится текущим числом
            previousNumber = currentNumber
        default:
            break
        }

        display = formatNumber(currentNumber)
        currentOperation = .equals
    }

    private func performFunction(_ function: String) {
        switch function {
        case "AC":
            clear()
        case "+/-":
            currentNumber = -currentNumber
            display = formatNumber(currentNumber)
        case "%":
            currentNumber = currentNumber / 100
            display = formatNumber(currentNumber)
        default:
            break
        }
    }

    private func clear() {
        display = "0"
        history = ""
        currentNumber = 0
        previousNumber = 0
        currentOperation = nil
    }

    // Форматирование числа: убираем .0, если число целое
    private func formatNumber(_ value: Double) -> String {
        if value == floor(value) {
            return String(format: "%.0f", value)
        } else {
            return String(value)
            
        }
    }
}
