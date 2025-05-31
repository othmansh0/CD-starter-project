//
//  CD_starter_projectTests.swift
//  CD starter projectTests
//
//  Created by Othman Shahrouri on 31/05/2025.
//

import XCTest
@testable import CD_starter_project

final class CDStarterProjectTests: XCTestCase {
    var viewModel: CounterViewModel!

    override func setUp() {
        super.setUp()
        viewModel = CounterViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testInitialCountIsZero() {
        XCTAssertEqual(viewModel.count, 0)
    }

    func testIncrementIncreasesCount() {
        viewModel.increment()
        XCTAssertEqual(viewModel.count, 1)
    }

    func testResetSetsCountToZero() {
        viewModel.increment()
        viewModel.reset()
        XCTAssertEqual(viewModel.count, 0)
    }

    func testAddFunction() {
        XCTAssertEqual(viewModel.add(a: 2, b: 3), 5)
        XCTAssertEqual(viewModel.add(a: -1, b: 1), 0)
    }

    func testMultiplyFunction() {
        XCTAssertEqual(viewModel.multiply(a: 3, b: 4), 12)
        XCTAssertEqual(viewModel.multiply(a: -2, b: 3), -6)
    }

    func testIsEvenFunction() {
        XCTAssertTrue(viewModel.isEven(number: 2))
        XCTAssertFalse(viewModel.isEven(number: 3))
    }
}
