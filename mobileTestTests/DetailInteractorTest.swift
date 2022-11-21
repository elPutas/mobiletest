//
//  DetailInteractorTest.swift
//  mobileTestTests
//
//  Created by Gio Valdes on 15/11/22.
//

import XCTest

final class DetailInteractorTest: XCTestCase {
    var sut:DetailInteractorImplementation?
    override func setUpWithError() throws {
        sut = DetailInteractorImplementation()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testUserInfo() throws {
        let exp = expectation(description: "Loading user")
        var myUser:AuthorUser?
        let userId:Int32 = 1
        var isSuccess = false
        sut?.services.getUserInfo(idUser: userId, completion: { success, user in
            isSuccess = success
            myUser = user
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 5)
        let result = try XCTUnwrap(myUser)
        if isSuccess{
            XCTAssertEqual(result.id, userId) //userid send it should be the same we recive
        }else{
            XCTAssertEqual(result.id, 0) //if not success userid is 0
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
