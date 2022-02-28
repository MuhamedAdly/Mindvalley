//
//  ChannelsApiClient.swift
//  Channels
//
//  Created by Mohamed Adly on 5/22/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation
import Alamofire

typealias EpisodesCallback = (Data, Episodes) -> Void
typealias ErrorCallback = (Error) -> Void
typealias ChannelsCallback = (Data, Channels) -> Void
typealias CategoriesCallback = (Data, Categories) -> Void

// I followed the principle of Interface segregation and separate each API into protocol.
// MARK: - EpisodesApi
protocol EpisodesApi {
    func requestNewEpisodes(onSuccess: EpisodesCallback?, onError: ErrorCallback?)
}

// MARK: - ChannelApi
protocol ChannelsApi {
    func requestChannels(onSuccess: ChannelsCallback?, onError: ErrorCallback?)
}

// MARK: - CategoriesApi
protocol CategoriesApi {
    func requestCategroies(onSuccess: CategoriesCallback?, onError: ErrorCallback?)
}

// MARK: - ApiClient

class ApiClient: EpisodesApi, ChannelsApi, CategoriesApi {
    func requestNewEpisodes(onSuccess: EpisodesCallback? = nil, onError: ErrorCallback? = nil) {
        AF.request(ApiRequest.episodes, interceptor: ApiInterceptor()).responseData(
            completionHandler: { (response: AFDataResponse<Data>) in
                switch response.result {
                case .success(let value):
                    do {
                        let decoder = JSONDecoder()
                        let episodes = try decoder.decode(Episodes.self, from: value)
                        onSuccess?(value, episodes)
                    } catch {
                        onError?(error)
                    }
                case .failure(let error):
                    onError?(error)
                }
        })
    }
    func requestChannels(onSuccess: ChannelsCallback? = nil, onError: ErrorCallback? = nil) {
        AF.request(ApiRequest.channels, interceptor: ApiInterceptor()).responseData(
            completionHandler: { (response: AFDataResponse<Data>) in
                switch response.result {
                case .success(let value):
                    do {
                        let decoder = JSONDecoder()
                        let channels = try decoder.decode(Channels.self, from: value)
                        onSuccess?(value, channels)
                    } catch {
                        onError?(error)
                    }
                case .failure(let error):
                    onError?(error)
                }
        })
    }
    func requestCategroies(onSuccess: CategoriesCallback? = nil, onError: ErrorCallback? = nil) {
        AF.request(ApiRequest.categories, interceptor: ApiInterceptor()).responseData(
            completionHandler: { (response: AFDataResponse<Data>) in
                switch response.result {
                case .success(let value):
                    do {
                        let decoder = JSONDecoder()
                        let categories = try decoder.decode(Categories.self, from: value)
                        onSuccess?(value, categories)
                    } catch {
                        onError?(error)
                    }
                case .failure(let error):
                    onError?(error)
                }
        })
    }
}
