//
//  ApiInterceptor.swift
//  Channels
//
//  Created by Mohamed Adly on 5/25/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation
import Alamofire

class ApiInterceptor: Interceptor {
    private let retryCount = 3
    private let retryDelay: TimeInterval = 3
    override func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if request.retryCount < retryCount {
            print("retrying(\(request.retryCount)):" + (request.request?.url?.absoluteString ?? ""))
            completion(.retryWithDelay(retryDelay))
        } else {
            print("doNotRetry(\(request.retryCount)):" + (request.request?.url?.absoluteString ?? ""))
            completion(.doNotRetry)
        }
    }
}
