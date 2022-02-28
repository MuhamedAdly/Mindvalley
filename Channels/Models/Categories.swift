//
//  Categories.swift
//  Channels
//
//  Created by Mohamed Adly on 5/22/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Categories: Codable {
    let data: CategoriesData?
}

// MARK: - CategoriesData
struct CategoriesData: Codable {
    let categories: [Category]?
}

// MARK: - Category
struct Category: Codable {
    let name: String?
}
