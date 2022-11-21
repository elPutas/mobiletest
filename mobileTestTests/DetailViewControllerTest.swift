//
//  DetailViewControllerTest.swift
//  mobileTestTests
//
//  Created by Gio Valdes on 15/11/22.
//

import XCTest
@testable import mobileTest

final class DetailViewControllerTest: XCTestCase {

    var sut: DetailViewController!
    let mockPost1 = Post(userId: 0, id: 1, title: "title", body: "body")

    override func setUpWithError() throws {
        sut = DetailViewController(post: mockPost1)

        sut.view = DetailView()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testPostInfo() throws {
        let post = try XCTUnwrap(sut.myPost)
        XCTAssertEqual(post.title, "title")
        XCTAssertEqual(post.body, "body")
    }

}
