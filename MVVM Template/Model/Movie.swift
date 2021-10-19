//
//  Movie.swift
//  MVVMDemo
//
//  Created by Seifallah Selmi on 17/06/20.
//  Copyright © 2020 Seifallah Selmi All rights reserved.
//

import UIKit
import Foundation

// MARK: - Movies array
struct MovieResponseModel : Codable {
    let page, totalResults, totalPages: Int?
    let movie: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movie = "results"
    }
    
    init(page: Int, totalResults: Int, totalPages: Int, movie: [Movie]) {
        self.page = page
        self.totalResults = totalResults
        self.totalPages = totalPages
        self.movie = movie
    }
}

// MARK: - Movie
class Movie: Codable {
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let posterPath: String?
    let id: Int?
    let adult: Bool?
    let backdropPath: String?
    let originalLanguage: OriginalLanguage?
    let originalTitle: String?
    let genreIDS: [Int]?
    let title: String?
    let voteAverage: Double?
    let overview: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
    
    init(popularity: Double, voteCount: Int, video: Bool, posterPath: String, id: Int, adult: Bool, backdropPath: String, originalLanguage: OriginalLanguage, originalTitle: String, genreIDS: [Int], title: String, voteAverage: Double, overview: String, releaseDate: String?) {
        self.popularity = popularity
        self.voteCount = voteCount
        self.video = video
        self.posterPath = posterPath
        self.id = id
        self.adult = adult
        self.backdropPath = backdropPath
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.genreIDS = genreIDS
        self.title = title
        self.voteAverage = voteAverage
        self.overview = overview
        self.releaseDate = releaseDate
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case ko = "ko"
    case pl = "pl"
    case sv = "sv"
    case fr = "fr"
}



// MARK: Array extension

extension Array where Element == Movie {
    
    func matching(_ query: String) -> [Movie] {
        
        return self.filter({ $0.title == query || $0.originalTitle == query})
    }
    
    func sortByName() -> [Movie] {
        
        return self.sorted(by: { (first, next) -> Bool in
            
            return first.title?.compare(next.title!) == .orderedAscending
        })
    }
}
