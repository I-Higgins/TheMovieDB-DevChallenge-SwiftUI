//
//  HttpClient.swift
//  TMDB
//
//  Created by Isaac Higgins on 21/11/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case invalidData
    case decodingError
    case invalidResponse
    case invalidToken
}

class MoviewViewModel: ObservableObject {
    @Published var searchBarText = ""
    @Published var filteredListOfMovies = [MovieData]()
    @Published var listOfMovies = [MovieData]()
    
    init() {
        self.RetrieveMovies() { _ in }
    }
    
    func RetrieveMovies(completion: @escaping (Result<[MovieModel], NetworkError>) -> Void) {
        var request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(Keys.TheMovieDataBaseApiKey)")!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
          do {
              let movies = try JSONDecoder().decode(MovieResponseModel.self, from: data)
              self.listOfMovies = movies.results.map { MovieData(posterImage: Data(), movieInfo: $0) }
              self.filteredListOfMovies = self.listOfMovies
              self.listOfMovies.forEach { movieInfo in
                  self.RetrieveMoviePoster(posterPath: movieInfo.movieInfo.poster_path ?? "") { result in
                      switch result {
                      case .success(_):
                          print("Success")
                      case .failure(let error):
                          print("Error: \(error)")
                      }
                  }
              }
              completion(.success(movies.results))
          } catch {
              completion(.failure(.decodingError))
          }
        }.resume()
    }
    
    private func RetrieveMoviePoster(posterPath: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        var request = URLRequest(url: URL(string: "https://image.tmdb.org/t/p/w300\(posterPath)?api_key=\(Keys.TheMovieDataBaseApiKey)")!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                if let index = self.listOfMovies.firstIndex(where: {$0.movieInfo.poster_path == posterPath})
                {
                    self.listOfMovies[index].posterImage = data
                }
                if let index = self.filteredListOfMovies.firstIndex(where: {$0.movieInfo.poster_path == posterPath})
                {
                    self.filteredListOfMovies[index].posterImage = data
                }
            }
            completion(.success(data))
        }.resume()
    }
    
    public func UpdateFilteredListOfMovies() {
        if (self.searchBarText.isEmpty) {
            self.filteredListOfMovies = self.listOfMovies
        } else {
            self.filteredListOfMovies = self.listOfMovies.filter({$0.movieInfo.title!.contains(self.searchBarText)})
        }
    }
}
