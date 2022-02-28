//
//  ApiClientTests.swift
//  ChannelsTests
//
//  Created by Mohamed Adly on 5/22/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import XCTest
@testable import Channels
import OHHTTPStubs

class ApiClientTests: XCTestCase {
    var mindValleyChannelsApiClient: ApiClient!
    override func setUp() {
        mindValleyChannelsApiClient = ApiClient()
    }
    func testChannelCoursesRequestSuccess() {
        //Given
        stub(condition: { (urlRequest) -> Bool in
            urlRequest.url?.absoluteString == ApiRequest.channels.urlString
        }, response: { (_) -> HTTPStubsResponse in
            let channlesJSON = ApiClientMocks.channelsCoursesJSONMock
            return HTTPStubsResponse(jsonObject: channlesJSON, statusCode: 200, headers: nil)
        })
        var expectedChannels: Channels?
        //When
        let requestExpectation = expectation(description: "request will be success")
        mindValleyChannelsApiClient.requestChannels(onSuccess: { (channels) in
            expectedChannels = channels
            requestExpectation.fulfill()
        }, onError: nil)
        wait(for: [requestExpectation], timeout: 5)
        //Then
        XCTAssertNotNil(expectedChannels)
        XCTAssertEqual(expectedChannels?.data.channels.first?.series.count, 0)
        XCTAssertEqual(expectedChannels?.data.channels.first?.mediaCount, 98)
    }

    func testChannelSeriesRequestSuccess() {
        //Given
        stub(condition: { (urlRequest) -> Bool in
            urlRequest.url?.absoluteString == ApiRequest.channels.urlString
        }, response: { (_) -> HTTPStubsResponse in
            let channlesJSON = ApiClientMocks.channelsSeriesJSONMock
            return HTTPStubsResponse(jsonObject: channlesJSON, statusCode: 200, headers: nil)
        })
        var expectedChannels: Channels?
        //When
        let requestExpectation = expectation(description: "request will be success")
        mindValleyChannelsApiClient.requestChannels(onSuccess: { (channels) in
            expectedChannels = channels
            requestExpectation.fulfill()
        }, onError: nil)
        wait(for: [requestExpectation], timeout: 5)
        //Then
        XCTAssertNotNil(expectedChannels)
        XCTAssertEqual(expectedChannels?.data.channels.first?.series.count, 1)
        XCTAssertEqual(expectedChannels?.data.channels.first?.mediaCount, 6)
    }
    func testChannelsRequestFail() {
        //Given
        stub(condition: { (urlRequest) -> Bool in
            urlRequest.url?.absoluteString == ApiRequest.channels.urlString
        }, response: { (_) -> HTTPStubsResponse in
            return HTTPStubsResponse(jsonObject: [], statusCode: 401, headers: nil)
        })
        var expectedError: Error?
        //When
        let requestExpectation = expectation(description: "request will be fail")
        mindValleyChannelsApiClient.requestChannels(onSuccess: nil, onError: {
            expectedError = $0
            requestExpectation.fulfill()
        })
        wait(for: [requestExpectation], timeout: 5)
        //Then
        XCTAssertNotNil(expectedError)
    }
}
