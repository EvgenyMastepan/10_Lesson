//
//  Artwork.swift
//  10_Lesson
//
//  Created by Evgeny Mastepan on 20.07.2025.
//


import Foundation

struct RedditResponse: Codable {
    let data: RedditListing
}

struct RedditListing: Codable {
    let children: [RedditPostWrapper]
    let after: String?
}

struct RedditPostWrapper: Codable {
    let data: RedditPost
}

struct RedditPost: Codable {
    let id: String
    let title: String
    let url: String?
    let ups: Int
    let created_utc: TimeInterval
    let author: String
    let num_comments: Int
    let preview: RedditPreview?
    
    var imageUrl: String? {
        preview?.images.first?.source.url.replacingOccurrences(of: "&amp;", with: "&")
    }
}

struct RedditPreview: Codable {
    let images: [RedditImage]
}

struct RedditImage: Codable {
    let source: RedditImageSource
}

struct RedditImageSource: Codable {
    let url: String
    let width: Int
    let height: Int
}
