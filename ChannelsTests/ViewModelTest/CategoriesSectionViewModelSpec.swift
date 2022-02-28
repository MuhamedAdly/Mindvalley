//
//  CategoriesSectionViewModelSpec.swift
//  ChannelsTests
//
//  Created by Mohamed Adly on 5/23/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation
import Quick
import Nimble
import OHHTTPStubs
@testable import Channels

class CategoriesSectionViewModelSpec: QuickSpec {
    override func spec() {
        describe("a category view model") {
            beforeEach {
                stub(condition: { (urlRequest) -> Bool in
                    return urlRequest.url?.absoluteString == ApiRequest.categories.urlString
                }, response: { (_) -> HTTPStubsResponse in
                    let jsonObject = ApiClientMocks.categoriesMock
                    return HTTPStubsResponse(jsonObject: jsonObject, statusCode: 200, headers: nil)
                })
            }
            it("should load 12 categories") {
                //Given
                let apiClient: CategoriesApi = ApiClient()
                let categoriesViewModel = CategoriesSectionViewModelImpl(apiClient: apiClient, dataSource: nil)
                //When
                categoriesViewModel.doAction(action: .loadCategories)
                //Then
                expect(categoriesViewModel.categories).toEventuallyNot(beNil())
                expect(categoriesViewModel.categoriesCount) == 12
            }
        }
    }
}
