//
//  CategoriesViewModel.swift
//  Channels
//
//  Created by Mohamed Adly on 5/23/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum CategoriesAction {
    case loadCategories
}

enum CategoriesState {
    case idle
    case loadingCategories
    case categoriesLoaded
}

protocol CategoriesSectionViewModel {
    var categoriesCount: Int { get}
    var categories: [Category]? { get }
    func doAction(action: CategoriesAction)
}

class CategoriesViewModelImpl: CategoriesSectionViewModel {
    var categoriesDataSource: Categories?
    var apiClient: CategoriesApi?
    private var stateRelay = BehaviorRelay<CategoriesState>(value: .idle)
    var state: Observable<CategoriesState> {
        return stateRelay.asDriver().asObservable()
    }
    convenience init(apiClient: CategoriesApi) {
        self.init()
        self.apiClient = apiClient
    }
    func doAction(action: CategoriesAction) {
        switch action {
        case .loadCategories:
            stateRelay.accept(.loadingCategories)
            apiClient?.requestCategroies(onSuccess: { [weak self] (categories) in
                self?.categoriesDataSource = categories
                self?.stateRelay.accept(.categoriesLoaded)
            }, onError: nil)
        }
    }
    var categoriesCount: Int {
        return categoriesDataSource?.data.categories.count ?? 0
    }
    var categories: [Category]? {
        return categoriesDataSource?.data.categories
    }
}
