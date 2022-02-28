//
//  EpisdoesLocalDataSourceImpl.swift
//  Channels
//
//  Created by Mohamed Adly on 5/26/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation
import DataCache

class EpisodesLocalDataSourceImpl: LocalDataSource, EpisodesLocalDataSource {
    var key: String
    init(key: String) {
        self.key = key
    }
    func saveJSON(data: Data) {
        DataCache.instance.write(data: data, forKey: key)
    }
    func readEpisodes() -> Episodes? {
        if let json = DataCache.instance.readData(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let episodes = try decoder.decode(Episodes.self, from: json)
                return episodes
            } catch {
                return nil
            }
        }
        return nil
    }
}
