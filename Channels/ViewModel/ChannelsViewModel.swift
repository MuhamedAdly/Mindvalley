//
//  ChannelsViewModel.swift
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
}

protocol ChannelsSectionViewModel {
    var channelsCount: Int { get}
    var channels: [Channel]? { get }
    func doAction(action: ChannelsAction)
}

class ChannelsViewModelImpl: ChannelsSectionViewModel {
    var channelsDataSource: Channels?
    var apiClient: ChannelsApi?
    private var stateRelay = BehaviorRelay<ChannelsState>(value: .idle)
    var state: Observable<ChannelsState> {
        return stateRelay.asDriver().asObservable()
    }
    convenience init(apiClient: ChannelsApi) {
        self.init()
        self.apiClient = apiClient
    }
    func doAction(action: ChannelsAction) {
        switch action {
        case .loadChannels:
            stateRelay.accept(.loadingChannels)
            apiClient?.requestChannels(onSuccess: { [weak self] (channels) in
                self?.channelsDataSource = channels
                self?.stateRelay.accept(.channelsLoaded)
            }, onError: nil)
        }
    }
    var channelsCount: Int {
        return channelsDataSource?.data.channels.count ?? 0
    }
    var channels: [Channel]? {
        return channelsDataSource?.data.channels
    }
}
