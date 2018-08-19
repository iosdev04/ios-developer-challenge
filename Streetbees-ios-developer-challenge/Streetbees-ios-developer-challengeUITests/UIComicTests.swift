//
//  UIComicTests.swift
//  Streetbees-ios-developer-challengeUITests
//
//  Created by Yasir Basharat on 19/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//

import XCTest

class UIComicTests: XCTestCase {
    let app =  XCUIApplication()
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")  //
        app.launch()
        _ = waitForElementToAppear(app)
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testComicViewController() {
        let collectionView: XCUIElement = app.collectionViews[AccessibilityLabel.comicCollectionView.rawValue]
            .firstMatch
        XCTContext.runActivity(named: "Comic Listing") { _ in
            XCTAssertNotNil(collectionView.exists,
                            "\(AccessibilityLabel.comicCollectionView.rawValue) doesn't exists")
            let cell = collectionView.cells["\(AccessibilityLabel.comicCollectionCellView.rawValue)-9"]
            if !cell.waitForExistence(timeout: 20) {
                XCTFail("some error occurred")
            }
            collectionView.swipe(.leftside, times: 1)
            collectionView.swipe(.rightside, times: 1)
            cell.tap()
            sleep(5)

        }
        XCTContext.runActivity(named: "Comic Details") { _ in
            let blurView = app.otherElements[AccessibilityLabel.comicDetailsBlurView.rawValue].firstMatch
            if !blurView.waitForExistence(timeout: 20) {
                XCTFail("some error occurred")
            }
            let barDoneItem = app.buttons[AccessibilityLabel.comicDetailsbarDoneItem.rawValue].firstMatch
            barDoneItem.tap()
            sleep(4)
            XCUIDevice.shared.orientation = .landscapeRight
            collectionView.swipe(.leftside, times: 3)
            collectionView.swipe(.rightside, times: 3)
            XCUIDevice.shared.orientation = .portrait
        }
    }
}
