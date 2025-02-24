//
//  RemoteFeedLoaderTests.swift
//  EssentialFeed
//
//  Created by Manivel Nagarajan on 24/02/25.
//

import XCTest

class HTTPClient {
    func get(from url: URL) {}
}

class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?
    
    override func get(from url: URL) {
        requestedURL = url
    }
}

class RemoteFeedLoader {
    let client: HTTPClient
    let url: URL
    init(url: URL = URL(string: "https://a-feed-url.com")!, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    func load() {
        client.get(from: url)
    }
}

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestFeed() {
        let (_, client) = makeSUT()
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let (sut, client) = makeSUT()
        sut.load()
        XCTAssertEqual(client.requestedURL, URL(string: "https://a-feed-url.com"))
    }
    
    // Helpers
    private func makeSUT(url: URL = URL(string: "https://a-feed-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
}
