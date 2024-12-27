//
//  CalculatorAppTests.swift
//  CalculatorAppTests
//
//  Created by roman on 12/27/24.
//

import XCTest
@testable import CalculatorApp

class CalculatorViewModelTests: XCTestCase {
    var viewModel: CalculatorViewModel!

    override func setUp() {
        super.setUp()
        viewModel = CalculatorViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    // Тест: Проверка сложения
    func testAddition() {
        viewModel.receiveInput(.number(5))
        viewModel.receiveInput(.operation("+"))
        viewModel.receiveInput(.number(3))
        viewModel.receiveInput(.equals)
        
        XCTAssertEqual(viewModel.display, "8", "Операция сложения работает неправильно")
        XCTAssertEqual(viewModel.history, "5 + 3 = 8", "История отображается неверно")
    }

    // Тест: Проверка вычитания
    func testSubtraction() {
        viewModel.receiveInput(.number(10))
        viewModel.receiveInput(.operation("-"))
        viewModel.receiveInput(.number(7))
        viewModel.receiveInput(.equals)
        
        XCTAssertEqual(viewModel.display, "3", "Операция вычитания работает неправильно")
        XCTAssertEqual(viewModel.history, "10 - 7 = 3", "История отображается неверно")
    }

    // Тест: Проверка умножения
    func testMultiplication() {
        viewModel.receiveInput(.number(4))
        viewModel.receiveInput(.operation("x"))
        viewModel.receiveInput(.number(3))
        viewModel.receiveInput(.equals)
        
        XCTAssertEqual(viewModel.display, "12", "Операция умножения работает неправильно")
        XCTAssertEqual(viewModel.history, "4 x 3 = 12", "История отображается неверно")
    }

    // Тест: Проверка деления
    func testDivision() {
        viewModel.receiveInput(.number(8))
        viewModel.receiveInput(.operation("/"))
        viewModel.receiveInput(.number(2))
        viewModel.receiveInput(.equals)
        
        XCTAssertEqual(viewModel.display, "4", "Операция деления работает неправильно")
        XCTAssertEqual(viewModel.history, "8 / 2 = 4", "История отображается неверно")
    }

    // Тест: Проверка деления на 0
    func testDivisionByZero() {
        viewModel.receiveInput(.number(8))
        viewModel.receiveInput(.operation("/"))
        viewModel.receiveInput(.number(0))
        viewModel.receiveInput(.equals)
        
        XCTAssertEqual(viewModel.display, "0", "Операция деления на 0 работает неправильно")
        XCTAssertEqual(viewModel.history, "8 / 0 = 0", "История отображается неверно")
    }

    // Тест: Проверка функции сброса (AC)
    func testClear() {
        viewModel.receiveInput(.number(5))
        viewModel.receiveInput(.operation("+"))
        viewModel.receiveInput(.number(3))
        viewModel.receiveInput(.function("AC"))
        
        XCTAssertEqual(viewModel.display, "0", "Функция сброса работает неправильно")
        XCTAssertEqual(viewModel.history, "", "История не очищена после сброса")
    }

    // Тест: Проверка изменения знака (+/-)
    func testToggleSign() {
        viewModel.receiveInput(.number(5))
        viewModel.receiveInput(.function("+/-"))
        
        XCTAssertEqual(viewModel.display, "-5", "Функция изменения знака работает неправильно")
        
        viewModel.receiveInput(.function("+/-"))
        XCTAssertEqual(viewModel.display, "5", "Функция изменения знака работает неправильно при повторном нажатии")
    }

    // Тест: Проверка процента (%)
    func testPercentage() {
        viewModel.receiveInput(.number(50))
        viewModel.receiveInput(.function("%"))
        
        XCTAssertEqual(viewModel.display, "0.5", "Функция процента работает неправильно")
    }
}
