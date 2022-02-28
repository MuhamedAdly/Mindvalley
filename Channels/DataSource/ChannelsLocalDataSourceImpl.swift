//
//  ChannelsLocalDataSourceImpl.swift
//  Channels
//
//  Created by Mohamed Adly on 5/26/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation
import DataCache

class ChannelsLocalDataSourceImpl: LocalDataSource, ChannelsLocalDataSource {
    var key: String
    init(key: String) {
        self.key = key
    }
    func saveJSON(data: Data) {
        DataCache.instance.write(data: data, forKey: key)
    }
    func readChannels() -> Channels? {
        if let json = DataCache.instance.readData(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let channels = try decoder.decode(Channels.self, from: json)
                return channels
            } catch {
                return nil
            }
        }
        return nil
    }
}
