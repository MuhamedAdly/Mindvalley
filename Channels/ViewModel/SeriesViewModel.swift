//
//  SeriesViewModel.swift
//  Channels
//
//  Created by Mohamed Adly on 5/23/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation

protocol SeriesViewModel {
    var coverImageUrl: URL? { get }
    var title: String { get }
}

class SeriesViewModelImpl: SeriesViewModel {
    var series: Series?
    init(series: Series) {
        self.series = series
    }
    var coverImageUrl: URL? {
        do {
            return try series?.coverAsset?.url?.asURL()
        } catch {
            return nil
        }
    }
    var title: String {
        return series?.title ?? ""
    }
}
