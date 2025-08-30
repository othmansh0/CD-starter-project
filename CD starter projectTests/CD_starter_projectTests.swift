//
//  CD_starter_projectTests.swift
//  CD starter projectTests
//
//  Created by Othman Shahrouri on 31/05/2025.
//

import XCTest
@testable import CD_starter_project

final class CDStarterProjectTests: XCTestCase {
    var viewModel: CalculatorViewModel!

    override func setUp() {
        super.setUp()
        viewModel = CalculatorViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testInitialDisplayIsZero() {
        XCTAssertEqual(viewModel.formattedDisplay, "0")
    }

    func testSimpleAddition() {
        viewModel.tapNumber("1")
        viewModel.tapOperation(.add)
        viewModel.tapNumber("1")
        viewModel.tapEquals()
        XCTAssertEqual(viewModel.formattedDisplay, "2")
    }

    func testChainedOperations() {
        viewModel.tapNumber("2")
        viewModel.tapOperation(.add)
        viewModel.tapNumber("3")
        viewModel.tapOperation(.multiply)
        viewModel.tapNumber("4")
        viewModel.tapEquals()
        // (2 + 3) * 4 = 20
        XCTAssertEqual(viewModel.formattedDisplay, "20")
    }

    func testPlusMinusAndPercent() {
        viewModel.tapNumber("5")
        viewModel.tapPlusMinus()
        XCTAssertEqual(viewModel.formattedDisplay, "-5")
        viewModel.tapPercent()
        XCTAssertEqual(viewModel.formattedDisplay, "-0.05")
    }

    func testClearResetsState() {
        viewModel.tapNumber("9")
        viewModel.tapDecimal()
        viewModel.tapNumber("9")
        viewModel.tapClear()
        XCTAssertEqual(viewModel.formattedDisplay, "0")
    }
}
