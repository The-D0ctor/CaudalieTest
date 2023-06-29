//
//  CaudalieTestTests.swift
//  CaudalieTestTests
//
//  Created by Sébastien Rochelet on 30/05/2023.
//

import XCTest
@testable import RxAlamofire

final class CaudalieTestTests: XCTestCase {
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testValidApiCall() {
        let url = "https://itunes.apple.com/search?term=test"
        
        let promise = expectation(description: "Status code: 200")
        
        _ = RxAlamofire.requestJSON(.get, url).subscribe(
            onNext: { (httpUrlResponse: HTTPURLResponse, json: Any) in
                if (httpUrlResponse.statusCode != 200) {
                    XCTFail("Status code: \(httpUrlResponse.statusCode)")
                }
                else {
                    promise.fulfill()
                }
            },
            onError: { (error: Error) in
                XCTFail("Error: \(error.localizedDescription)")
            })
        wait(for: [promise], timeout: 5)
    }
    
    func testEmptyQuery() {
        let url = "https://itunes.apple.com/search"
        
        let promise = expectation(description: "List returned empty")
        
        _ = RxAlamofire.requestJSON(.get, url).subscribe(
            onNext: { (httpUrlResponse: HTTPURLResponse, json: Any) in
                guard let dic = json as? [String: Any], let resultCount = dic["resultCount"] as? Int
                else {
                    XCTFail("Deserialization error")
                    return
                }
                if resultCount != 0 {
                    XCTFail("List returned not empty")
                }
                else {
                    promise.fulfill()
                }
            })
        wait(for: [promise], timeout: 5)
    }
    
    func testInvalidQuery() {
        let url = "https://itunes.apple.com/search?test=test"
        
        let promise = expectation(description: "List returned empty")
        
        _ = RxAlamofire.requestJSON(.get, url).subscribe(
            onNext: { (httpUrlResponse: HTTPURLResponse, json: Any) in
                guard let dic = json as? [String: Any], let resultCount = dic["resultCount"] as? Int
                else {
                    XCTFail("Deserialization error")
                    return
                }
                if resultCount != 0 {
                    XCTFail("List returned not empty")
                }
                else {
                    promise.fulfill()
                }
            })
        wait(for: [promise], timeout: 5)
    }
}
