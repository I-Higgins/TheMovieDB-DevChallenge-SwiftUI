//
//  MovieModels.swift
//  TMDB
//
//  Created by Isaac Higgins on 21/11/23.
//

import Foundation
import UIKit

struct MovieResponseModel : Codable {
    var page: Int
    var results: [MovieModel]
    var total_pages: Int
    var total_results: Int
}

struct MovieModel : Codable, Identifiable {
    var adult: Bool = false
    var backdrop_path: String = ""
    var genre_ids: [Int] = []
    var id: Int = 0
    var original_language: String = ""
    var original_title: String = ""
    var overview: String = ""
    var popularity: Float = 0.0
    var poster_path: String = ""
    var release_date: String = ""
    var title: String = ""
    var video: Bool = false
    var vote_average: Float = 0.0
    var vote_count: Int = 0
    
    func getGenreStrings() -> [String] {
        return self.genre_ids.map({GenreDictionary[$0] ?? ""})
    }
    
    func getVotePercentage() -> Float {
        return self.vote_average * 10
    }
}

public struct MovieData: Codable, Identifiable {
    public var id = UUID()

    public var posterImage: Data
    public var backDropImage: Data
    var movieInfo: MovieModel
    
    public func getPosterImage() -> UIImage {
        return UIImage(data: self.posterImage) ?? UIImage()
    }
    
    public func getBackDropImage() -> UIImage {
        return UIImage(data: self.backDropImage) ?? UIImage()
    }
}
