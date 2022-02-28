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

class EpisodesSectionViewModelSpec: QuickSpec {
    override func spec() {
        describe("an episode view model") {
            beforeEach {
                stub(condition: { (urlRequest) -> Bool in
                    return urlRequest.url?.absoluteString == ApiRequest.episodes.urlString
                }, response: { (_) -> HTTPStubsResponse in
                    let jsonObject = ApiClientMocks.episodesJSONMock
                    return HTTPStubsResponse(jsonObject: jsonObject, statusCode: 200, headers: nil)
                })
            }
            it("should load 1 episode") {
                //Given
                let episodeApiClient: EpisodesApi = ApiClient()
                let episodeViewModel = EpisodesSectionViewModelImpl(apiClient: episodeApiClient, dataSource: nil)
                //When
                episodeViewModel.doAction(action: .loadEpisodes)
                //Then
                expect(episodeViewModel.media).toEventuallyNot(beNil())
                expect(episodeViewModel.episodesCount) == 1
            }
        }
    }
}
