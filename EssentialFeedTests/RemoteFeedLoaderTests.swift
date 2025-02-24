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
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func load() {
        client.get(from: URL(string: "https://a-feed-url.com")!)
    }
}

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestFeed() {
        let client = HTTPClientSpy()
        _ = RemoteFeedLoader(client: client)
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(client: client)
        sut.load()
        XCTAssertEqual(client.requestedURL, URL(string: "https://a-feed-url.com"))
    }
}
