//
//  ChannelSectionViewModel.swift
//  Channels
//
//  Created by Mohamed Adly on 5/23/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation

protocol ChannelSectionViewModel {
    var title: String { get }
    var coverImageUrl: URL? { get }
    var thumbnailUrl: URL? { get }
    var subdetails: String { get }
    var isSeries: Bool { get }
    var seriesViewModels: [SeriesViewModel]? { get}
    var coursesViewModels: [CourseViewModel]? { get }
    var itemsCount: Int { get }
}

class ChannelSectionViewModelImpl: ChannelSectionViewModel {
    private var mappedCoursesViewModels: [CourseViewModel]?
    private var mappedSeriesViewModels: [SeriesViewModel]?
    private var channel: Channel!
    init(channel: Channel) {
        self.channel = channel
        if channel.series?.count ?? 0 > 0 {
            mappedSeriesViewModels = channel.series?.compactMap {
                SeriesViewModelImpl(series: $0)
            }
        } else {
            mappedCoursesViewModels = channel.latestMedia?.compactMap { ChannelCourseViewModelImpl(latestMedia: $0) }
        }
    }
    var title: String {
        return channel.title ?? ""
    }
    var thumbnailUrl: URL? {
        do {
            return try channel.iconAsset?.thumbnailUrl?.asURL()
        } catch {
            return nil
        }
    }
    var coverImageUrl: URL? {
        do {
            return try channel.coverAsset?.url?.asURL()
        } catch {
            return nil
        }
    }
    var subdetails: String {
        let episdoesDescription = (itemsCount == 1 ? "episode".localizaed : "episodes".localizaed)
        return "\(itemsCount) " + episdoesDescription
    }
    var isSeries: Bool {
        return (mappedSeriesViewModels?.count ?? 0) > 0
    }
    var seriesViewModels: [SeriesViewModel]? {
        return mappedSeriesViewModels
    }
    var coursesViewModels: [CourseViewModel]? {
        return mappedCoursesViewModels
    }
    var itemsCount: Int {
        if isSeries {
            return seriesViewModels?.count ?? 0
        }
        return coursesViewModels?.count ?? 0
    }
}
