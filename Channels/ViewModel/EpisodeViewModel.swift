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
    var episodeTitle: String { get }
    var episodeChannelTitle: String { get }
}

class EpisodeViewModelImpl: CourseViewModel {
    var media: Media!
    init(media: Media) {
        self.media = media
    }
    var coverImageUrl: URL? {
        return URL(string: media.coverAsset.url)
    }
    var episodeTitle: String {
        return media.title
    }
    var episodeChannelTitle: String {
        return media.channel.title
    }
}
