//
//  ListImagesUITests.swift
//  FlickerImagesUITests
//
//  Created by Arpit Srivastava on 28/01/22.
//  Copyright © 2022 Arpit Srivastava. All rights reserved.
//

import XCTest

class ListImagesUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testClickingOnTextFieldShowsCancelButton() {

        // Given
        let app = XCUIApplication()
        let flickerImagesNavigationBar = app.navigationBars["Flicker Images"]

        // When
        flickerImagesNavigationBar.searchFields["Enter text to search"].tap()

        // Then
        XCTAssertTrue(flickerImagesNavigationBar.buttons["Cancel"].exists)
    }

    func testClickingOnSearchShouldShowLoader() {

        // Given
        let app = XCUIApplication()
        let flickerImagesNavigationBar = app.navigationBars["Flicker Images"]

        // When
        flickerImagesNavigationBar.searchFields["Enter text to search"].tap()
        app.keyboards.keys["T"].tap()
        app.keyboards.keys["e"].tap()
        app.keyboards.keys["s"].tap()
        app.keyboards.keys["t"].tap()
        app.keyboards.buttons["search"].tap()

        // Then
        XCTAssertTrue(app.activityIndicators["In progress"].exists)
        XCTAssertTrue(flickerImagesNavigationBar.exists)
        XCTAssertFalse(flickerImagesNavigationBar.buttons["Cancel"].exists)
    }

    func testClickingOnItemShouldShowDetailsPage() {
        // Given
        let app = XCUIApplication()
        let flickerImagesNavigationBar = app.navigationBars["Flicker Images"]

        // When
        flickerImagesNavigationBar.searchFields["Enter text to search"].tap()
        app.keyboards.keys["M"].tap()
        app.keyboards.keys["a"].tap()
        app.keyboards.keys["n"].tap()
        app.keyboards.keys["g"].tap()
        app.keyboards.keys["o"].tap()
        app.keyboards.buttons["search"].tap()
        sleep(5)
        app.collectionViews.children(matching:.any).element(boundBy: 0).tap()
        //app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()

        // Then
        XCTAssertTrue(app.staticTexts["BPI Sports Best Glutamine Peach Mango 400 gr"].exists)
        XCTAssertTrue(app.navigationBars["FlickerImages.ImageDetailsView"].buttons["Flicker Images"].exists)
    }

    func testClickingBackOnDetailsShowListPage() {

        // Given
        let app = XCUIApplication()
        let flickerImagesNavigationBar = app.navigationBars["Flicker Images"]

        // When
        flickerImagesNavigationBar.searchFields["Enter text to search"].tap()
        app.keyboards.keys["M"].tap()
        app.keyboards.keys["a"].tap()
        app.keyboards.keys["n"].tap()
        app.keyboards.buttons["search"].tap()
        sleep(5)
        app.collectionViews.children(matching:.any).element(boundBy: 0).tap()
        sleep(2)
        app.navigationBars["FlickerImages.ImageDetailsView"].buttons["Flicker Images"].tap()
        sleep(2)

        // Then
        XCTAssertTrue(flickerImagesNavigationBar.exists)
        XCTAssertTrue(flickerImagesNavigationBar.searchFields["Enter text to search"].exists)
    }
}
