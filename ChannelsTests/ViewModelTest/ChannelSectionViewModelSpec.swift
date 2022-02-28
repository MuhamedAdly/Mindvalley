//
//  ChannelSectionViewModelSpec.swift
//  ChannelsTests
//
//  Created by Mohamed Adly on 5/25/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation
import Quick
import Nimble
import OHHTTPStubs
@testable import Channels

class ChannelSectionViewModelSpec: QuickSpec {
    override func spec() {
        describe("a channel course viewmodel") {
            context("channel course") {
                //Given
                beforeEach {
                    stub(condition: { (urlRequest) -> Bool in
                        return urlRequest.url?.absoluteString == ApiRequest.channels.urlString
                    }, response: { (_) -> HTTPStubsResponse in
                        let jsonObject = ApiClientMocks.channelsCoursesJSONMock
                        return HTTPStubsResponse(jsonObject: jsonObject, statusCode: 200, headers: nil)
                    })
                }
                it("should load course viewmodels ") {
                    let apiClient: ChannelsApi = ApiClient()
                    let channelsViewModel = ChannelsSectionViewModelImpl(apiClient: apiClient, dataSource: nil)
                    //When
                    channelsViewModel.doAction(action: .loadChannels)
                    //Then
                    expect(channelsViewModel.channelSectionViewModels).toEventuallyNot(beNil())
                    let coursesViewModels = channelsViewModel.channelSectionViewModels?.first?.coursesViewModels
                    expect(coursesViewModels?.count) == 12
                    let firstCourseViewModel = coursesViewModels?.first
                    expect(firstCourseViewModel?.title) == "How Journaling Helped Create a $500M Company"
                    expect(firstCourseViewModel?.coverImageUrl) ==
                        URL(string: "https://assets.mindvalley.com/api/v1/assets/a90653b8-8475-41a9-925a-3a1bf0e7cd5f.jpg?transform=w_1080")
                }
            }
            context("series course") {
                //Given
                beforeEach {
                    stub(condition: { (urlRequest) -> Bool in
                        return urlRequest.url?.absoluteString == ApiRequest.channels.urlString
                    }, response: { (_) -> HTTPStubsResponse in
                        let jsonObject = ApiClientMocks.channelsSeriesJSONMock
                        return HTTPStubsResponse(jsonObject: jsonObject, statusCode: 200, headers: nil)
                    })
                }
                it("should load course viewmodels ") {
                    let apiClient: ChannelsApi = ApiClient()
                    let channelsViewModel = ChannelsSectionViewModelImpl(apiClient: apiClient, dataSource: nil)
                    //When
                    channelsViewModel.doAction(action: .loadChannels)
                    //Then
                    expect(channelsViewModel.channelSectionViewModels).toEventuallyNot(beNil())
                    expect(channelsViewModel.channelSectionViewModels?.first?.isSeries).to(beTrue())
                    let seriesViewModels = channelsViewModel.channelSectionViewModels?.first?.seriesViewModels
                    expect(seriesViewModels?.count) == 1
                    let firstSeriesViewModel = seriesViewModels?.first
                    expect(firstSeriesViewModel?.title) == "Getting Started with the Lifebook Accountability System"
                    expect(firstSeriesViewModel?.coverImageUrl) ==
                        URL(string: "https://assets.mindvalley.com/api/v1/assets/4d960fc3-836a-4536-8ba7-062911943477.jpg?transform=w_1080")
                }
            }
        }
    }
}
