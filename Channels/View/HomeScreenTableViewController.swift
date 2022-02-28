//
//  HomeScreenTableViewController.swift
//  Channels
//
//  Created by Mohamed Adly on 5/23/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeScreenTableViewController: UITableViewController {
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorView: UIView!
    var episodeSectionViewModel: EpisodesSectionViewModel!
    var channelsSectionViewModel: ChannelsSectionViewModel!
    var categoriesSectionViewModel: CategoriesSectionViewModel!
    let disposeBag = DisposeBag()
    static func instantiate(episodeSectionViewModel: EpisodesSectionViewModel,
                            channelsSectionViewModel: ChannelsSectionViewModel,
                            categoriesSectionViewModel: CategoriesSectionViewModel) -> HomeScreenTableViewController {
        let homeScreenViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: "HomeScreenTableViewController")
            as? HomeScreenTableViewController ?? HomeScreenTableViewController()
        homeScreenViewController.episodeSectionViewModel = episodeSectionViewModel
        homeScreenViewController.channelsSectionViewModel = channelsSectionViewModel
        homeScreenViewController.categoriesSectionViewModel = categoriesSectionViewModel
        return homeScreenViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupViewModelsSubscribers()
        loadData()
        setupRefreshControll()
    }
    fileprivate  func registerCells() {
        tableView.register(EpisodesSectionTableViewCell.nib,
                           forCellReuseIdentifier: EpisodesSectionTableViewCell.identifier)
        tableView.register(ChannlesSectionTableViewCell.nib,
                           forCellReuseIdentifier: ChannlesSectionTableViewCell.identifier)
        tableView.register(CategoriesSectionTableViewCell.nib,
                           forCellReuseIdentifier: CategoriesSectionTableViewCell.identifier)
    }
    fileprivate  func setupRefreshControll() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing please wait", attributes: attributes)
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.refreshControl = refreshControl
    }
    @objc fileprivate func loadData() {
        episodeSectionViewModel.doAction(action: .loadEpisodes)
        channelsSectionViewModel.doAction(action: .loadChannels)
        categoriesSectionViewModel.doAction(action: .loadCategories)
    }
    private var rowsCount: Int {
         return 2 + (channelsSectionViewModel.channelsCount == 0 ? 1 : channelsSectionViewModel.channelsCount)
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let totalRows = 2 + (channelsSectionViewModel.channelsCount == 0 ? 1 : channelsSectionViewModel.channelsCount)
        return totalRows
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let totalRows = 2 + (channelsSectionViewModel.channelsCount == 0 ? 1 : channelsSectionViewModel.channelsCount)
        switch indexPath.row {
        case 0:  //Episodes
            if let episodesCell = tableView.dequeueReusableCell(withIdentifier: EpisodesSectionTableViewCell.identifier) as? EpisodesSectionTableViewCell {
                episodesCell.episodeSectionViewModel = episodeSectionViewModel
                return episodesCell
            }
        case totalRows - 1: //Categories
            if let categoriesCell = tableView.dequeueReusableCell(withIdentifier: CategoriesSectionTableViewCell.identifier) as? CategoriesSectionTableViewCell {
                categoriesCell.categoriesViewModel = categoriesSectionViewModel
                return categoriesCell
            }
        default:
            if let channelCell = tableView.dequeueReusableCell(withIdentifier: ChannlesSectionTableViewCell.identifier) as? ChannlesSectionTableViewCell {
                if channelsSectionViewModel.channelsCount > 0,
                    let channelSectionViewModel = channelsSectionViewModel.channelSectionViewModels?[indexPath.row - 1] {
                    channelCell.channelSectionViewModel = channelSectionViewModel
                } else {
                    channelCell.loadingView.isHidden = false
                }
                return channelCell
            }
        }
        return UITableViewCell()
    }
}
