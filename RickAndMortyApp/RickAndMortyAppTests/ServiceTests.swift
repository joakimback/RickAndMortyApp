//
//  ServiceTests.swift
//  RickAndMortyAppTests
//
//  Created by Joakim Back on 2019-07-01.
//  Copyright © 2019 Joakim Back. All rights reserved.
//

import XCTest
import PromiseKit
@testable import RickAndMortyApp

class ServiceTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchCharacters() {
        let e = expectation(description: "")
        
        firstly {
            Service.shared.fetchCharacters(for: 1)
            }.done {
                XCTAssert($0.count > 0)
            }.catch { _ in
                XCTFail("Unable to fetch characters")
            }.finally {
                e.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testFetchLocation() {
        let e = expectation(description: "")
        
        firstly {
            Service.shared.fetchLocation(id: "1")
            }.done {
                XCTAssertNotNil($0)
            }.catch { _ in
                XCTFail("Unable to fetch location")
            }.finally {
                e.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testFetchResidents() {
        let e = expectation(description: "")
        
        firstly {
            Service.shared.fetchResidents(for: "1")
            }.done {
                XCTAssertTrue($0.count > 0)
            }.catch { _ in
                XCTFail("Unable to fetch residents")
            }.finally {
                e.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testFetchFavorites() {
        let e = expectation(description: "")
        
        firstly {
            Service.shared.fetchCharacters(for: ["1", "2", "3"])
            }.done {
                XCTAssertTrue($0.count ==  3)
            }.catch { _ in
                XCTFail("Unable to fetch characters")
            }.finally {
                e.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
