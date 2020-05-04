import XCTest

class TmerUITests: XCTestCase {

    func testExample() throws {

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        snapshot("01UserEntries")
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
