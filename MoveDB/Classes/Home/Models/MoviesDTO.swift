//
//  MoviesDTO.swift
//  MoveDB
//
//  Created by Ahmed Shafik on 01/01/2022.
//

import Foundation


// MARK: - MoviesDTO
struct MoviesDTO: Codable {
    
    let page: Int
    let results: [MovieDataDTO]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
// MARK: - Result
struct MovieDataDTO: Codable {
    let id: Int
    let title: String
    let posterPath : String

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
    }
}

