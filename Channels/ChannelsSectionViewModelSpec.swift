//
//  ChannelsSectionViewModelSpec.swift
//  ChannelsTests
//
//  Created by Mohamed Adly on 5/23/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation
import Quick
import Nimble
import OHHTTPStubs
@testable import Channels

class ChannelsSectionViewModelSpec: QuickSpec {
    override func spec() {
       describe("a channels view model") {
            context("courses") {
                beforeEach {
                    stub(condition: { (urlRequest) -> Bool in
                        return urlRequest.url?.absoluteString == ApiRequest.channels.urlString
                    }, response: { (_) -> HTTPStubsResponse in
                        let jsonObject = ApiClientMocks.channelsCoursesJSONMock
                        return HTTPStubsResponse(jsonObject: jsonObject, statusCode: 200, headers: nil)
                    })
                }
                it("should load 12 courses") {
                    //Given
                    let apiClient: ChannelsApi = ApiClient()
                    let channelsViewModel = ChannelsSectionViewModelImpl(apiClient: apiClient, dataSource: nil)
                    //When
                    channelsViewModel.doAction(action: .loadChannels)
                    //Then
                    expect(channelsViewModel.channels?.first?.latestMedia).toEventuallyNot(beNil())
                    expect(channelsViewModel.channels?.first?.series?.count) == 0
                    expect(channelsViewModel.channels?.first?.latestMedia?.count) == 12
                }
            }
            context("series") {
                beforeEach {
                    stub(condition: { (urlRequest) -> Bool in
                        return urlRequest.url?.absoluteString == ApiRequest.channels.urlString
                    }, response: { (_) -> HTTPStubsResponse in
                        let jsonObject = ApiClientMocks.channelsSeriesJSONMock
                        return HTTPStubsResponse(jsonObject: jsonObject, statusCode: 200, headers: nil)
                    })
                }
                it("should load 1 series") {
                    //Given
                    let apiClient = ApiClient()
                    let channelsViewModel = ChannelsSectionViewModelImpl(apiClient: apiClient, dataSource: nil)
                    //When
                    channelsViewModel.doAction(action: .loadChannels)
                    //Then
                    expect(channelsViewModel.channels?.first?.series).toEventuallyNot(beNil())
                    expect(channelsViewModel.channels?.first?.series?.count) == 1
                }
            }
        }
    }
}
