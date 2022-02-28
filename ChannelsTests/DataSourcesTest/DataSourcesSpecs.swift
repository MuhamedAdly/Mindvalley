//
//  DataSourcesSpecs.swift
//  ChannelsTests
//
//  Created by Mohamed Adly on 5/26/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Channels

class DataSourcesSpecs: QuickSpec {
    //swiftlint:disable function_body_length
    override func spec() {
        describe("an episode datasource") {
            it("should save and load expceted data") {
                //Given
                let json = ApiClientMocks.episodesJSONMock
                var jsonData: Data?
                do {
                    jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                } catch {
                }
                expect(jsonData).toNot(beNil())
                let datasource = EpisodesLocalDataSourceImpl(key: "EpisodesTest")
                //When
                datasource.saveJSON(data: jsonData!)
                let episodes = datasource.readEpisodes()
                //Then
                let media = episodes?.data?.media
                expect(media).notTo(beNil())
                expect(media?.count) == 1
                expect(media?.first?.type) == "course"
                expect(media?.first?.title) == "Conscious Parenting"
            }
        }
        describe("a channels datasource") {
            it("should save and load expceted data") {
                //Given
                let json = ApiClientMocks.channelsSeriesJSONMock
                var jsonData: Data?
                do {
                    jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                } catch {
                }
                expect(jsonData).toNot(beNil())
                let datasource = ChannelsLocalDataSourceImpl(key: "ChannelsTest")
                //When
                datasource.saveJSON(data: jsonData!)
                let channels = datasource.readChannels()
                let series = channels?.data?.channels?.first?.series
                //Then
                expect(series).notTo(beNil())
                expect(series?.count) == 1
                expect(series?.first?.title) == "Getting Started with the Lifebook Accountability System"
            }
        }
        describe("a categories datasource") {
            it("should save and load expceted data") {
                //Given
                let json = ApiClientMocks.categoriesMock
                var jsonData: Data?
                do {
                    jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                } catch {
                }
                expect(jsonData).toNot(beNil())
                let datasource = CategoriesLocalDataSourceImpl(key: "CategoiresTest")
                //When
                datasource.saveJSON(data: jsonData!)
                let categoriesList = datasource.readCategories()
                //Then
                let categories = categoriesList?.data?.categories
                expect(categories).notTo(beNil())
                expect(categories?.count) == 12
                expect(categories?.first?.name) == "Career"
            }
        }
    }
}
