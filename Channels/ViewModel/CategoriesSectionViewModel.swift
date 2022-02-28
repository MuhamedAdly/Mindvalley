//
//  CategoriesSectionViewModel.swift
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
    case errorInLoading(error: Error)
}

protocol CategoriesSectionViewModel {
    var categoriesCount: Int { get}
    var categories: [Category]? { get }
    var categorieViewModels: [CategoryViewModel]? { get set}
    var state: Observable<CategoriesState> { get }
    func doAction(action: CategoriesAction)
}

class CategoriesSectionViewModelImpl: CategoriesSectionViewModel {
    var categoriesDataSource: Categories?
    var apiClient: CategoriesApi?
    var categorieViewModels: [CategoryViewModel]?
    var dataSource: CategoriesLocalDataSourceImpl?
    private var stateRelay = BehaviorRelay<CategoriesState>(value: .idle)
    var state: Observable<CategoriesState> {
        return stateRelay.asDriver().asObservable()
    }
    convenience init(apiClient: CategoriesApi, dataSource: CategoriesLocalDataSourceImpl? = nil) {
        self.init()
        self.apiClient = apiClient
        self.dataSource = dataSource
    }
    fileprivate func mapToCatrgoriesViewModels(_ categories: Categories) {
        categorieViewModels = categories.data?.categories?.compactMap { CategoryViewModelImpl(category: $0) }
    }
    func doAction(action: CategoriesAction) {
        switch action {
        case .loadCategories:
            stateRelay.accept(.loadingCategories)
            if let categories = dataSource?.readCategories() {
                categoriesDataSource = categories
                mapToCatrgoriesViewModels(categories)
                stateRelay.accept(.categoriesLoaded)
            } else {
                apiClient?.requestCategroies(onSuccess: { [weak self] (data, categories) in
                    self?.categoriesDataSource = categories
                    self?.dataSource?.saveJSON(data: data)
                    self?.mapToCatrgoriesViewModels(categories)
                    self?.stateRelay.accept(.categoriesLoaded)
                }, onError: {
                    self.stateRelay.accept(.errorInLoading(error: $0))
                })
            }
        }
    }
    var categoriesCount: Int {
        return categorieViewModels?.count ?? 0
    }
    var categories: [Category]? {
        return categoriesDataSource?.data?.categories
    }
}
