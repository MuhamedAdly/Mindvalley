//
//  HomeScreenCoordinator.swift
//  Channels
//
//  Created by Mohamed Adly on 5/23/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation
import UIKit

class HomeScreenCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let apClient = ApiClient()
        let episodesDataSource = EpisodesLocalDataSourceImpl(key: "Episodes")
        let channelsDataSource = ChannelsLocalDataSourceImpl(key: "Channels")
        let categoriesDataSource = CategoriesLocalDataSourceImpl(key: "Categories")
        let episodesSectionViewModel = EpisodesSectionViewModelImpl(apiClient: apClient,
                                                                    dataSource: episodesDataSource)
        let channelsSectionViewModel = ChannelsSectionViewModelImpl(apiClient: apClient,
                                                                    dataSource: channelsDataSource)
        let categoriesSectionViewModel = CategoriesSectionViewModelImpl(apiClient: apClient,
                                                                        dataSource: categoriesDataSource)
        let homeScreenTableViewController = HomeScreenTableViewController.instantiate(
            episodeSectionViewModel: episodesSectionViewModel,
            channelsSectionViewModel: channelsSectionViewModel,
            categoriesSectionViewModel: categoriesSectionViewModel)
        navigationController.pushViewController(homeScreenTableViewController, animated: false)
    }
}
