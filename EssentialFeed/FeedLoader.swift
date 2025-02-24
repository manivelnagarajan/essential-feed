//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Manivel Nagarajan on 24/02/25.
//

typealias FeedLoaderResult = Result<[FeedItem], Error>

protocol FeedLoader {
    func load(completion: @escaping (FeedLoaderResult) -> Void)
}
