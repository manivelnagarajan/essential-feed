import XCTest

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