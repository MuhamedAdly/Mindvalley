//
//  HomeScreenTableViewController+Subscribers.swift
//  Channels
//
//  Created by Mohamed Adly on 5/23/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation

extension HomeScreenTableViewController {
    func setupViewModelsSubscribers() {
        setupEpisodesSectionVMSubscriber()
        setupChannelsSectionVMSubscriber()
        setupCategoriesSectionVMSubscriber()
    }
    fileprivate func setupEpisodesSectionVMSubscriber() {
        episodeSectionViewModel.state.subscribe(onNext: { [weak self] (state) in
            switch state {
            case .idle:
                break
            case .loadingEpisodes:
                self?.hideError()
            case .episodesLoaded:
                self?.tableView.reloadRows(at: [IndexPath(item: 0, section: 0)], with: .automatic)
                self?.refreshControl?.endRefreshing()
                self?.hideError()
            case .errorInLoading(let error):
                self?.showError(error: error)
            }
        }).disposed(by: disposeBag)
    }
    fileprivate func setupChannelsSectionVMSubscriber() {
        channelsSectionViewModel.state.subscribe(onNext: { [weak self] (state) in
            switch state {
            case .idle:
                break
            case .loadingChannels:
                self?.hideError()
            case .channelsLoaded:
                self?.tableView.reloadData()
                self?.refreshControl?.endRefreshing()
                self?.hideError()
            case .errorInLoading(let error):
                self?.showError(error: error)
            }
        }).disposed(by: disposeBag)
    }
    fileprivate func setupCategoriesSectionVMSubscriber() {
        categoriesSectionViewModel.state.subscribe(onNext: { [weak self] (state) in
            switch state {
            case .idle:
                break
            case .loadingCategories:
                self?.hideError()
            case .categoriesLoaded:
                self?.tableView.reloadData()
                self?.refreshControl?.endRefreshing()
                self?.hideError()
            case .errorInLoading(let error):
                self?.showError(error: error)
            }
        }).disposed(by: disposeBag)
    }
    fileprivate func showError(error: Error) {
        errorLabel.text = "Server Error ! \n Pull to retry again"
        tableView.tableHeaderView = errorView
        print(error.localizedDescription)
        refreshControl?.endRefreshing()
    }
    fileprivate func hideError() {
        tableView.tableHeaderView = nil
    }
}
