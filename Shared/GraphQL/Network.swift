//
//  Network.swift
//  Network
//
//  Created by Alexis Bronchart on 10/09/2021.
//

import Foundation
import Apollo
import SwiftUI

class Network {

    // MARK: Constants

    let serverURL = URL(string: "https://api.producthunt.com/v2/api/graphql")!
    let client: ApolloClient

    // MARK: Access network

    static var instance: Network {
        return Network()
    }

    init() {
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let urlSessionClient = URLSessionClient()
        let provider = NetworkInterceptorProvider(store: store, client: urlSessionClient)
        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: serverURL)

        client = ApolloClient(networkTransport: requestChainTransport, store: store)
    }
}

struct PHAuthInterceptor: ApolloInterceptor {

    // MARK: Interceptor functions

    func interceptAsync<Operation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) where Operation : GraphQLOperation {

            guard let accessToken = Config.instance?.auth.accessToken else {
                chain.cancel()
                return
            }

            let headers = [
                "Authorization" : "Bearer \(accessToken)",
                "Content-Type" : "application/json",
                "Accept" : "application/json",
            ]

            headers.forEach { (key, value) in
                request.addHeader(name: key, value: value)
            }

            chain.proceedAsync(request: request, response: response, completion: completion)
        }
}

struct NetworkInterceptorProvider: InterceptorProvider {

    private let store: ApolloStore
    private let client: URLSessionClient

    init(store: ApolloStore,
         client: URLSessionClient) {
        self.store = store
        self.client = client
    }

    func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        return [
            MaxRetryInterceptor(),
            PHAuthInterceptor(),
            CacheReadInterceptor(store: self.store),
            NetworkFetchInterceptor(client: self.client),
            ResponseCodeInterceptor(),
            JSONResponseParsingInterceptor(cacheKeyForObject: self.store.cacheKeyForObject),
            AutomaticPersistedQueryInterceptor(),
            CacheWriteInterceptor(store: self.store)
        ]
    }
}
