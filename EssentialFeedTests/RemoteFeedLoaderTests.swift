//
//  RemoteFeedLoaderTests.swift
//  EssentialFeed
//
//  Created by Manivel Nagarajan on 24/02/25.
//

import XCTest
import EssentialFeed

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestFeed() {
        let (_, client) = makeSUT()
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load{ _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load{ _ in }
        sut.load{ _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        var capturedErrors: [RemoteFeedLoader.Error] = []
        sut.load { error in
            capturedErrors.append(error)
        }
        client.complete(with: NSError(domain: "test", code: 0), at: 0)
        XCTAssertEqual(capturedErrors, [.connectivity])
    }
    
    // Helpers
    private func makeSUT(url: URL = URL(string: "https://a-feed-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        var requestedURLs: [URL] = []
        var completions: [(Result<HTTPURLResponse, Error>) -> Void] = []
        
        func get(from url: URL, completion: @escaping (Result<HTTPURLResponse, Error>) -> Void) {
            requestedURLs.append(url)
            completions.append(completion)
        }
        
        func complete(with error: NSError, at index: Int) {
            completions[index](.failure(error))
        }
    }
}
