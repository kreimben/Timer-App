import XCTest

@testable import T_mer
import CommonT_mer

class T_merTests_iOS_: XCTestCase {
    
    let mainController = CTMainController()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testIsTimerRunning() {
        
        let result = self.mainController.isTimerRunning()
        
        XCTAssertEqual(result, true, "Failed!!!")
    }
}

//
//  T_merTests_iOS_.swift
//  T!merTests(iOS)
//
//  Created by Aksidion Kreimben on 7/16/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
