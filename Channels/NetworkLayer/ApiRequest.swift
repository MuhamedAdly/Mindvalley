//
//  ApiRequest.swift
//  Channels
//
//  Created by Mohamed Adly on 5/22/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation
import Alamofire

enum ApiRequest: URLRequestConvertible {
    case channels
    case episodes
    case categories
    var method: HTTPMethod {
        return .get
    }
    var urlString: String {
        switch self {
        case .channels:
            return "https://pastebin.com/raw/Xt12uVhM"
        case .episodes:
            return "https://pastebin.com/raw/z5AExTtw"
        case .categories:
            return "https://pastebin.com/raw/A0CgArX3"
        }
    }
    func asURLRequest() throws -> URLRequest {
        let url = try urlString.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        return urlRequest
    }
}
