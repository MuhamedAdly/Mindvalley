//
//  CategoriesLocalDataSource.swift
//  Channels
//
//  Created by Mohamed Adly on 5/26/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation
import DataCache

class CategoriesLocalDataSourceImpl: LocalDataSource, CategoriesLocalDataSource {
    var key: String
    init(key: String) {
        self.key = key
    }
    func saveJSON(data: Data) {
        DataCache.instance.write(data: data, forKey: key)
    }
    func readCategories() -> Categories? {
        if let json = DataCache.instance.readData(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let categories = try decoder.decode(Categories.self, from: json)
                return categories
            } catch {
                return nil
            }
        }
        return nil
    }
}
