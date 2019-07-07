//
//  FavoriteControllerTests.swift
//  RickAndMortyAppTests
//
//  Created by Joakim Back on 2019-07-03.
//  Copyright © 2019 Joakim Back. All rights reserved.
//

import XCTest
@testable import RickAndMortyApp

class FavoriteControllerTests: XCTestCase {
    var observer: Any!

    override func setUp() {
        Favorites.shared.favorites = []
    }

    override func tearDown() {
        NotificationCenter.default.removeObserver(observer!)
    }

    func testAddFavorite() {
        let e = expectation(description: "Should notify")
        
        observer = NotificationCenter.default.addObserver(forName: .favoritesDidChange, object: nil, queue: nil) { _ in
            e.fulfill()
        }
        
        Favorites.shared.add(id: "1")
        
        waitForExpectations(timeout: 10.0, handler: nil)

        XCTAssert(Favorites.shared.favorites.count == 1)
        XCTAssert(Favorites.shared.contains(id: "1"))
    }
    
    func testAddSecondFavorite() {
        Favorites.shared.add(id: "1")
        
        let e = expectation(description: "Should notify")
        
        observer = NotificationCenter.default.addObserver(forName: .favoritesDidChange, object: nil, queue: nil) { _ in
            e.fulfill()
        }
        
        Favorites.shared.add(id: "2")
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        XCTAssert(Favorites.shared.favorites.count == 2)
        XCTAssert(Favorites.shared.contains(id: "1"))
        XCTAssert(Favorites.shared.contains(id: "2"))
    }
    
    func testRemoveFavorite() {
        Favorites.shared.add(id: "1")
        
        let e = expectation(description: "Should notify")
        
        observer = NotificationCenter.default.addObserver(forName: .favoritesDidChange, object: nil, queue: nil) { _ in
            e.fulfill()
        }
        
        Favorites.shared.remove(id: "1")
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        XCTAssert(Favorites.shared.favorites.count == 0)
        XCTAssertFalse(Favorites.shared.contains(id: "1"))
    }
}
