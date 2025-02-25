//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Manivel Nagarajan on 25/02/25.
//

public protocol HTTPClient {
    func get(from url: URL)
}

public final class RemoteFeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public init(url: URL = URL(string: "https://a-feed-url.com")!, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    public func load() {
        client.get(from: url)
    }
}
