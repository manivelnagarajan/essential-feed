//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Manivel Nagarajan on 25/02/25.
//

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (Result<HTTPURLResponse, Error>) -> Void)
}

public final class RemoteFeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public init(url: URL = URL(string: "https://a-feed-url.com")!, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    public func load(completion: @escaping (Error) -> Void) {
        client.get(from: url) { result in
            switch result {
            case .success:
                completion(.invalidData)
            case .failure:
                completion(.connectivity)
            }
        }
    }
}
