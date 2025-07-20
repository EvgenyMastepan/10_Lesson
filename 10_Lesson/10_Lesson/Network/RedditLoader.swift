//
//  ArtworkLoader.swift
//  10_Lesson
//
//  Created by Evgeny Mastepan on 20.07.2025.
//


import Foundation

enum RedditError: Error {
    case invalidURL
    case noData
    case decodingError
}

class RedditLoader {
    static let shared = RedditLoader()
    private let baseURL = "https://www.reddit.com/r/memes"
    
    func fetchMemes(count: Int, completion: @escaping (Result<[RedditPost], RedditError>) -> Void) {
        let urlString = "\(baseURL)/hot.json?limit=\(count)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(RedditResponse.self, from: data)
                let postsWithImages = response.data.children.compactMap { $0.data }.filter { $0.imageUrl != nil }
                completion(.success(postsWithImages))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
}
