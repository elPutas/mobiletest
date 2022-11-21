//
//  HomeViewControllerTest.swift
//  mobileTestTests
//
//  Created by Gio Valdes on 15/11/22.
//

import XCTest
@testable import mobileTest

final class HomeViewControllerTest: XCTestCase {

    var sut: HomeViewController!
    let interactor = HomeInteractorImplementation()
    let presenter = HomePresenterImplementation()

    let mockPost1 = Post(userId: 0, id: 1, title: "title", body: "body")
    let mockPost2 = Post(userId: 0, id: 2, title: "title", body: "body")
    let mockPost3 = Post(userId: 0, id: 3, title: "title", body: "body", isFavorite: true)
    let mockPost4 = Post(userId: 0, id: 4, title: "title", body: "body", isFavorite: false)

    override func setUpWithError() throws {
        // config
        sut = HomeViewController()
        interactor.presenter = presenter
        sut.homeInteractor = interactor
        presenter.viewControler = sut
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testDeleteOnePost() throws {
        let index = IndexPath(row: 0, section: 1) // delete index 0, id 2
        let expectation = expectation(description: "deleting first one")
        let interactor = try XCTUnwrap(sut.homeInteractor)
        interactor.deletePost(post: [mockPost1, mockPost2], index: index)
        expectation.fulfill()
        waitForExpectations(timeout: 1)

        let result = try XCTUnwrap(sut.myAllPosts)
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].id, 2)
    }

    func testMarkAsFav() throws {
        let index = IndexPath(row: 0, section: 1) // set fav index 0
        let expectation = expectation(description: "first one as fav")
        let interactor = try XCTUnwrap(sut.homeInteractor)
        interactor.setAsFav(post: [mockPost1, mockPost2], index: index)
        expectation.fulfill()
        waitForExpectations(timeout: 1)

        let result = try XCTUnwrap(sut.myAllPosts)
        XCTAssertEqual(result[0].isFavorite, true)
        XCTAssertEqual(result[1].isFavorite, nil)
    }

    func testOrderInFavs() throws {
        let index = IndexPath(row: 1, section: 1) // set fav index 1, should be return index 0 as fav
        let expectation = expectation(description: "first one as fav")
        let interactor = try XCTUnwrap(sut.homeInteractor)
        interactor.setAsFav(post: [mockPost1, mockPost2], index: index)
        expectation.fulfill()
        waitForExpectations(timeout: 1)

        let result = try XCTUnwrap(sut.myAllPosts)
        XCTAssertEqual(result[0].isFavorite, true)
        XCTAssertEqual(result[1].isFavorite, nil)
    }

    func testDeleteAllButFav() throws {
        let expectation = expectation(description: "deleting all but favs")
        let interactor = try XCTUnwrap(sut.homeInteractor)
        interactor.filterOnlyFavs(allPost: [mockPost1, mockPost2, mockPost3, mockPost4]) // just index 3 has isFavorite set as true
        expectation.fulfill()
        waitForExpectations(timeout: 1)

        let result = try XCTUnwrap(sut.myAllPosts)
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].id, 3)
    }

}
