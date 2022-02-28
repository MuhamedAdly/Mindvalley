//
//  Episode.swift
//  Channels
//
//  Created by Mohamed Adly on 5/22/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation

// MARK: - Episode
struct Episodes: Codable {
    let data: EpisodeData?
}

// MARK: - EpisodeData
struct EpisodeData: Codable {
    let media: [Media]?
}

// MARK: - Media
struct Media: Codable {
    let type, title: String?
    let coverAsset: CoverAsset?
    let channel: EpisodeChannel?
}

// MARK: - Channel
struct EpisodeChannel: Codable {
    let title: String?
}

// MARK: - CoverAsset
struct CoverAsset: Codable {
    let url: String?
}
