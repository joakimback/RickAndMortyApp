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
            XCTFail("Unable to find characters")
        }.finally {
            e.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
