//
//  ApplicationConfigurationTests.swift
//  Streetbees-ios-developer-challengeTests
//
//  Created by Yasir Basharat on 19/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//

import XCTest
@testable import Streetbees_ios_developer_challenge

class ApplicationConfigurationTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testApplicationConfiguration_settings() {
        XCTAssertNotNil(APIConstant.apiKey, "Please set application variable in APIConstant. To Perform Unit Test")
        XCTAssertNotNil(APIConstant.privateKey, "Please set application variable in APIConstant. To Perform Unit Test")
        XCTAssertNotNil(APIConstant.publicKey, "Please set application variable in APIConstant. To Perform Unit Test")
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
