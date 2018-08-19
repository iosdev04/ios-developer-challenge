//
//  ComicTest.swift
//  Streetbees-ios-developer-challengeTests
//
//  Created by Yasir Basharat on 19/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//

import XCTest
@testable import Streetbees_ios_developer_challenge

class ComicTest: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testService_fetchComics() {
        //Given
        let exp = expectation(description: "Wait for Comic data from API")
        let request = ComicRequest(endpoint: .comics, limit: 50, offset: 0)
        let data = ComicService(withRequest: request)
        //WHEN
        data.fetchComicList { result in
            switch result {
            case .success(let dataResponse):
                guard let dataResponse = dataResponse else {
                    XCTFail("Invalid data received")
                    return
                }
                XCTAssertEqual(dataResponse.code, 200)
                XCTAssertEqual(dataResponse.status, "Ok")
                XCTAssertEqual(dataResponse.copyright, "© 2018 MARVEL")
                XCTAssertEqual(dataResponse.attributionText, "Data provided by Marvel. © 2018 MARVEL")
                XCTAssertEqual(dataResponse.data.offset, 0)
                XCTAssertEqual(dataResponse.data.limit, 50)
                XCTAssertGreaterThan(dataResponse.data.results.count, 0)
                if let comic = dataResponse.data.results.first {
                    XCTAssertGreaterThan(comic.itemId, 0)
                }
                exp.fulfill()
            case .failure(let error):
                switch error {
                case .responseError(let errorStatus):
                    if let errorStatus = errorStatus {
                        XCTFail(errorStatus.message)
                    } else {
                        XCTFail(error.description)
                    }
                default:
                    break
                }
            }
        }
        //Then
        waitForExpectations(timeout: 20, handler: { error in
            if let error = error {
                XCTFail("Error while waiting: \(error)")
            }
        })
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
        }
    }
}
