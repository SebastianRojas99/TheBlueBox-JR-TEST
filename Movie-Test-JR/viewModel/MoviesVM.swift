//
//  MoviesVM.swift
//  Movie-Test-JR
//
//  Created by Sebastian Marquez Rojas on 05/09/2024.
//
import Foundation
import Alamofire
import Observation

@Observable
class MoviesVM {
    var movie: Movie?
    var movies: [Movie] = []
    var genres: [Int: String] = [:]
    var errorMessage: APIError?
    var currentPage = 1
    var maxPage = 5
    var budget:Int = 0
    var isLoading:Bool = false
    
    init() {
        getGenres()
        getAllMovies()
    }
    
    func getAllMovies() {
           guard !isLoading && currentPage <= maxPage else { return }
           isLoading = true
           AF
               .request("\(api)\(currentPage)", method: .get)
               .validate(statusCode: 200..<300)
               .responseDecodable(of: Response.self) { response in
                   self.isLoading = false
                   switch response.result {
                   case .success(let data):
                       self.movies.append(contentsOf: data.results)
                       if self.currentPage < self.maxPage {
                           self.currentPage += 1
                       } else {
                           self.currentPage = self.maxPage
                       }
                   case .failure(let error):
                       let statusCode = response.response?.statusCode
                       self.errorMessage = APIError(message: "Error getting movies: \(error.localizedDescription)", statusCode: statusCode)
                       print("API error: \(self.errorMessage?.message ?? "Unknown error")")
                   }
               }
       }

    
    func getGenres() {
        AF
            .request(apiGenres, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: GenreResponse.self) { response in
                switch response.result {
                case .success(let data):
                    self.genres = Dictionary(uniqueKeysWithValues: data.genres.map { ($0.id, $0.name) })
                case .failure(let error):
                    let statusCode = response.response?.statusCode
                    self.errorMessage = APIError(message: "Error al obtener generos: \(error.localizedDescription)", statusCode: statusCode)
                    print("Genre error: \(self.errorMessage?.message ?? "Unknow error")")
                }
            }
    }
    
    func getBudget(id: Int) {
        AF
            .request("https://api.themoviedb.org/3/movie/\(id)?api_key=efbc2b95033e7dde757b6c455744baa2",
                     method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MovieDetails.self) { response in
                switch response.result {
                case .success(let data):
                    self.budget = data.budget
                    
                case .failure(let error):
                    let statusCode = response.response?.statusCode
                    self.errorMessage = APIError(message: "Budget error: \(error.localizedDescription)", statusCode: statusCode)
                    print("Budget error: \(self.errorMessage?.message ?? "Unknow error")")
                }
            }
    }

    
    func genreNames(for movie: Movie) -> String {
        let genreNames = movie.genre_ids.compactMap { genres[$0] }
        return genreNames.joined(separator: ", ")
    }
}

