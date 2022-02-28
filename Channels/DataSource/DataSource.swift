//
//  DataSource.swift
//  Channels
//
//  Created by Mohamed Adly on 5/26/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation
import DataCache

protocol LocalDataSource {
    var key: String { get set }
    func saveJSON(data: Data)
}

protocol EpisodesLocalDataSource {
    func readEpisodes() -> Episodes?
}

protocol ChannelsLocalDataSource {
    func readChannels() -> Channels?
}

protocol CategoriesLocalDataSource {
    func readCategories() -> Categories?
}
