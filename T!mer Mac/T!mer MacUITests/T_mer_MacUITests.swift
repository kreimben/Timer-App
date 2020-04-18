import XCTest

class T_mer_MacUITests: XCTestCase {

    func testExample() throws {
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        snapshot("mainScreenShot")
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
//  T_mer_MacUITests.swift
//  T!mer MacUITests
//
//  Created by Aksidion Kreimben on 4/15/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
