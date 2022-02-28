//
//  CategoryViewModel.swift
//  Channels
//
//  Created by Mohamed Adly on 5/25/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation

protocol CategoryViewModel {
    var name: String { get }
}

class CategoryViewModelImpl: CategoryViewModel {
    var category: Category!
    init(category: Category) {
        self.category = category
    }
    var name: String {
        return category.name ?? ""
    }
}
