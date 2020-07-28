//
//  ListImagesInteractorTests.swift
//  FlickerImages
//
//  Created by Arpit Srivastava on 28/07/20.
//  Copyright (c) 2020 Arpit Srivastava. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import XCTest
@testable import FlickerImages

class ListImagesInteractorTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: ListImagesInteractor!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupListImagesInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupListImagesInteractor() {
        sut = ListImagesInteractor()
    }
    
    // MARK: Test doubles
    class ListImagesPresentationLogicSpy: ListImagesPresentationLogic {
        var presentRefreshCalled = false
        var refreshResponse: ListImages.Refresh.Response!
        func presentRefresh(response: ListImages.Refresh.Response) {
            presentRefreshCalled = true
            refreshResponse = response
        }
    }
    
    class DataWorkerSpy: DataWorker {
        // MARK: Method call expectations
        var fetchImagesListCalled = false
        
        // MARK: Spied methods
        override func fetchImagesList(using params: [String: Any], completionHandler: @escaping (_ result: FetchDataResult<PhotosList>) -> Void) {
            fetchImagesListCalled = true
            super.fetchImagesList(using: params, completionHandler: completionHandler)
        }
    }

    // MARK: Flow Tests
    func testRefreshShouldAskWorkerToFetchImagesListAndPresenterToPresentRefresh() {
        
        // Given
        let spy = ListImagesPresentationLogicSpy()
        sut.presenter = spy
        let dataWorkerSpy = DataWorkerSpy(store: StaticJson())
        sut.worker = dataWorkerSpy
        let request = ListImages.Refresh.Request(searchTerm: "abc", shouldIncreasePageNumber: true)
        
        // When
        sut.refresh(request: request)
        
        // Then
        let predicate = NSPredicate(format: "%@ == true", spy.presentRefreshCalled)
        let expect = expectation(for: predicate, evaluatedWith: 0, handler: nil)
        XCTWaiter().wait(for: [expect], timeout: 1.0)
        XCTAssertTrue(dataWorkerSpy.fetchImagesListCalled, "refresh(request:) should ask the worker to fetchImagesList")
        XCTAssertTrue(spy.presentRefreshCalled, "refresh(request:) should ask the presenter to present refresh")
    }
    
    // MARK: Data Tests
    func testRefreshShouldFormatForPresent() {
        
        // Given
        let spy = ListImagesPresentationLogicSpy()
        sut.presenter = spy
        let workerSpy = DataWorkerSpy(store: StaticJson())
        sut.worker = workerSpy
        let request = ListImages.Refresh.Request(searchTerm: "abc", shouldIncreasePageNumber: true)
        
        // When
        sut.refresh(request: request)

        // Then
        let predicate = NSPredicate(format: "%@ == true", spy.presentRefreshCalled)
        let expect = expectation(for: predicate, evaluatedWith: 0, handler: nil)
        XCTWaiter().wait(for: [expect], timeout: 1.0)
        XCTAssertEqual(spy.refreshResponse.photoUrls.count, 3, "Incorrect photoUrls count")
        XCTAssertEqual(spy.refreshResponse.photoUrls[0].absoluteString, "https://farm66.staticFlickr.com/65535/48822393341_5f51f56614_m.jpg", "Incorrect photoUrls[0]")
        XCTAssertEqual(spy.refreshResponse.photoUrls[1].absoluteString, "https://farm66.staticFlickr.com/65535/48822184531_b0bc8f0d33_m.jpg", "Incorrect photoUrls[1]")
        XCTAssertEqual(spy.refreshResponse.photoUrls[2].absoluteString, "https://farm5.staticFlickr.com/4324/35418907823_170e367569_m.jpg", "Incorrect photoUrls[2]")
    }
}
