import XCTest

class T_merUITests: XCTestCase {

    func testExample() throws {

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // 1
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        // 2
//        let chipCountTextField = app.textFields["chip count"]
//        chipCountTextField.tap()
//        chipCountTextField.typeText("10")
        // 3
//        let bigBlindTextField = app.textFields["big blind"]
//        bigBlindTextField.tap()
//        bigBlindTextField.typeText("100")
        // 4
        snapshot("01UserEntries")
        // 5
//        app.buttons["what should i do"].tap()
//        snapshot("02Suggestion")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}

//
//  T_merUITests.swift
//  T!merUITests
//
//  Created by Aksidion Kreimben on 4/9/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
