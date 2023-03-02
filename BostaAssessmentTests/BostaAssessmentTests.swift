//
//  BostaAssessmentTests.swift
//  BostaAssessmentTests
//
//  Created by Adham Samer on 28/02/2023.
//

@testable import BostaAssessment
import XCTest

final class BostaAssessmentTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchAlbums() throws {
        let expectaion = expectation(description: "Waiting for the API to get Albums")
        NetworkService.fetchAlbums(userID: 2) { albums in
            guard let albums = albums else {
                XCTFail("No Data")
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(albums.count, 0)
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    func testFetchPhotos() throws {
        let expectaion = expectation(description: "Waiting for the API to get Photos")
        NetworkService.fetchPhotos(albumID: 1) { photos in
            guard let photos = photos else {
                XCTFail("No Data")
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(photos.count, 0)
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
}
