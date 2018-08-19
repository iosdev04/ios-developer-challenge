//
//  UITestHelper.swift
//  Streetbees-ios-developer-challengeUITests
//
//  Created by Yasir Basharat on 19/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//

import XCTest
extension XCTestCase {
    /// WaitForElementToAppear
    ///
    /// - Parameter element: XCUIElement
    /// - Returns: Bool
    public func waitForElementToAppear(_ element: XCUIElement) -> Bool {
        let predicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter().wait(for: [expectation], timeout: 15)
        return result == .completed
    }
}
extension XCUIElement {
    var isDisplayed: Bool {
        if self.exists {
            let window = XCUIApplication().windows.element(boundBy: 0)
            XCTAssertTrue(window.exists, "App window not present. The app may have crashed")
            return window.frame.contains(self.frame)
        } else {
            return false
        }
    }
    @discardableResult
    func swipe(_ direction: Direction, times: Int) -> Bool {
        guard times > 0 else {
            return false
        }
        for _ in 1...times {
            switch direction {
            case .upside:
                swipeUp()
            //sleep(2)
            case .downside:
                swipeDown()
            //sleep(2)
            case .leftside:
                swipeLeft()
            //sleep(2)
            case .rightside:
                swipeRight()
                //sleep(2)
            }
        }
        return true
    }
    enum Direction {
        case upside
        case downside
        case leftside
        case rightside
    }
}
