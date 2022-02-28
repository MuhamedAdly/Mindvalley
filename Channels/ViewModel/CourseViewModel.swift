//
//  CourseViewModel.swift
//  Channels
//
//  Created by Mohamed Adly on 5/23/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation

protocol CourseViewModel {
    var coverImageUrl: URL? { get }
    var title: String { get }
    var subTitle: String? { get }
}

extension CourseViewModel {
    var subTitle: String? {
        return nil
    }
}

class EpisodeCourseViewModelImpl: CourseViewModel {
    var media: Media?
    init(media: Media) {
        self.media = media
    }
    var coverImageUrl: URL? {
        do {
            return try media?.coverAsset?.url?.asURL()
        } catch {
            return nil
        }
    }
    var title: String {
        return media?.title ?? ""
    }
    var subTitle: String? {
        return media?.channel?.title
    }
}

class ChannelCourseViewModelImpl: CourseViewModel {
    var latestMedia: LatestMedia?
    init(latestMedia: LatestMedia) {
        self.latestMedia = latestMedia
    }
    var coverImageUrl: URL? {
        do {
            return try latestMedia?.coverAsset?.url?.asURL()
        } catch {
            return nil
        }
    }
    var title: String {
        return latestMedia?.title ?? ""
    }
}
