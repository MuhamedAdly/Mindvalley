//
//  ApiClientSpec.swift
//  ChannelsTests
//
//  Created by Mohamed Adly on 5/22/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation
import Quick
import Nimble
import OHHTTPStubs
@testable import Channels

class ApiClientSpec: QuickSpec {
    override func spec() {
        super.spec()
        describe("requestEpisodes") {
            context("success") {
                it("should return Episodes") {
                    //Given
                    stub(condition: { (urlRequest) -> Bool in
                        return urlRequest.url?.absoluteString == ApiRequest.episodes.urlString
                    }, response: { (_) -> HTTPStubsResponse in
                        let jsonResponse = ApiClientMocks.episodesJSONMock
                        return HTTPStubsResponse(jsonObject: jsonResponse, statusCode: 200, headers: nil)
                    })
                    var expectedEpisodes: Episodes?
                    //When
                    ApiClient().requestNewEpisodes(onSuccess: { (episodes) in
                        expectedEpisodes = episodes
                    }, onError: nil)
                    //Then
                    expect(expectedEpisodes).toEventuallyNot(beNil())
                    expect(expectedEpisodes?.data.media.count) == 1
                    expect(expectedEpisodes?.data.media.first?.type) == "course"
                    expect(expectedEpisodes?.data.media.first?.title) == "Conscious Parenting"
                    expect(expectedEpisodes?.data.media.first?.channel.title) == "Little Humans"
                }
            }
            context("error") {
                it("should return error") {
                    stub(condition: { (urlRequest) -> Bool in
                        urlRequest.url?.absoluteString == ApiRequest.episodes.urlString
                    }, response: { (_) -> HTTPStubsResponse in
                        return HTTPStubsResponse(jsonObject: [], statusCode: 401, headers: nil)
                    })
                    var expectedError: Error?
                    //When
                    ApiClient().requestNewEpisodes(onSuccess: nil, onError: {
                        expectedError = $0
                    })
                    //Then
                    expect(expectedError).toEventuallyNot(beNil())
                }
            }
        }
    }
}
