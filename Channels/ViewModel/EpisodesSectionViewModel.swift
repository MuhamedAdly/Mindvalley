//
//  EpisodesSectionViewModel.swift
//  Channels
//
//  Created by Mohamed Adly on 5/23/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum EpisodeAction {
    case loadEpisodes
}

enum EpisodeState {
    case idle
    case loadingEpisodes
    case episodesLoaded
    case errorInLoading(error: Error)
}

protocol EpisodesSectionViewModel {
    var episodesCount: Int { get}
    var media: [Media]? { get }
    var state: Observable<EpisodeState> { get }
    var episodesViewModels: [CourseViewModel]? { get set }
    func doAction(action: EpisodeAction)
}

class EpisodesSectionViewModelImpl: EpisodesSectionViewModel {
    var episodes: Episodes?
    var episodesViewModels: [CourseViewModel]?
    var apiClient: EpisodesApi?
    var dataSource: EpisodesLocalDataSourceImpl?
    private var stateRelay = BehaviorRelay<EpisodeState>(value: .idle)
    var state: Observable<EpisodeState> {
        return stateRelay.asDriver().asObservable()
    }
    convenience init(apiClient: EpisodesApi, dataSource: EpisodesLocalDataSourceImpl? = nil) {
        self.init()
        self.apiClient = apiClient
        self.dataSource = dataSource
    }
    fileprivate func mapToEpisodesViewModels(_ episodes: Episodes) {
        episodesViewModels = episodes.data?.media?.compactMap { return EpisodeCourseViewModelImpl(media: $0) }
    }
    func doAction(action: EpisodeAction) {
        switch action {
        case .loadEpisodes:
            stateRelay.accept(.loadingEpisodes)
            if let episodes = dataSource?.readEpisodes() {
                self.episodes = episodes
                mapToEpisodesViewModels(episodes)
                stateRelay.accept(.episodesLoaded)
            } else {
                apiClient?.requestNewEpisodes(onSuccess: { [weak self] (data, episodes) in
                    self?.dataSource?.saveJSON(data: data)
                    self?.episodes = episodes
                    self?.mapToEpisodesViewModels(episodes)
                    self?.stateRelay.accept(.episodesLoaded)
                    }, onError: { [weak self] in
                        self?.stateRelay.accept(.errorInLoading(error: $0))
                })
            }
        }
    }
    var episodesCount: Int {
        return episodes?.data?.media?.count ?? 0
    }
    var media: [Media]? {
        return episodes?.data?.media
    }
}
