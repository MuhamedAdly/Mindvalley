//
//  ChannelsSectionViewModel.swift
//  Channels
//
//  Created by Mohamed Adly on 5/23/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum ChannelsAction {
    case loadChannels
}

enum ChannelsState {
    case idle
    case loadingChannels
    case channelsLoaded
    case errorInLoading(error: Error)
}

protocol ChannelsSectionViewModel {
    var channelsCount: Int { get}
    var channels: [Channel]? { get }
    var channelSectionViewModels: [ChannelSectionViewModel]? { get set }
    var state: Observable<ChannelsState> { get }
    func doAction(action: ChannelsAction)
}

class ChannelsSectionViewModelImpl: ChannelsSectionViewModel {
    var channelsDataSource: Channels?
    var apiClient: ChannelsApi?
    var channelSectionViewModels: [ChannelSectionViewModel]?
    var dataSource: ChannelsLocalDataSourceImpl?
    private var stateRelay = BehaviorRelay<ChannelsState>(value: .idle)
    var state: Observable<ChannelsState> {
        return stateRelay.asDriver().asObservable()
    }
    convenience init(apiClient: ChannelsApi, dataSource: ChannelsLocalDataSourceImpl? = nil) {
        self.init()
        self.apiClient = apiClient
        self.dataSource = dataSource
    }
    fileprivate func mapToChannelsViewModels(channels: Channels) {
        channelSectionViewModels = channels.data?.channels?.compactMap {
            ChannelSectionViewModelImpl(channel: $0) }
    }
    func doAction(action: ChannelsAction) {
        switch action {
        case .loadChannels:
            stateRelay.accept(.loadingChannels)
            if let channels = dataSource?.readChannels() {
                channelsDataSource = channels
                mapToChannelsViewModels(channels: channels)
                stateRelay.accept(.channelsLoaded)
            } else {
                apiClient?.requestChannels(onSuccess: { [weak self] (data, channels) in
                    self?.channelsDataSource = channels
                    self?.dataSource?.saveJSON(data: data)
                    self?.mapToChannelsViewModels(channels: channels)
                    self?.stateRelay.accept(.channelsLoaded)
                    }, onError: {
                        self.stateRelay.accept(.errorInLoading(error: $0))
                })
            }
        }
    }
    var channelsCount: Int {
        return channelsDataSource?.data?.channels?.count ?? 0
    }
    var channels: [Channel]? {
        return channelsDataSource?.data?.channels
    }
}
