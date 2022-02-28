//
//  Channels.swift
//  Channels
//
//  Created by Mohamed Adly on 5/22/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Channels: Codable {
    let data: ChannelsData?
}

// MARK: - ChannelsData
struct ChannelsData: Codable {
    let channels: [Channel]?
}

// MARK: - Channel
struct Channel: Codable {
    let title: String?
    let series: [Series]?
    let mediaCount: Int?
    let latestMedia: [LatestMedia]?
    // swiftlint:disable identifier_name
    let id: String?
    let iconAsset: IconAsset?
    let coverAsset: CoverAsset?
}

// MARK: - LatestMedia
struct LatestMedia: Codable {
    let type, title: String?
    let coverAsset: CoverAsset?
}

// MARK: - Series
struct Series: Codable {
    let title: String?
    let coverAsset: CoverAsset?
}

// MARK: - IconAsset
struct IconAsset: Codable {
    let thumbnailUrl: String?
}
