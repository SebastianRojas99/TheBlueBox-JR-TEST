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
    var errorMessage: APIError? // Cambiar el tipo a APIError
    var budget:Int = 0
    
    init() {
        getGenres()
        getAllMovies()
    }
    
    func getAllMovies() {
        AF
            .request(api, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Response.self) { response in
                switch response.result {
                case .success(let data):
                    self.movies = Array(data.results)
                case .failure(let error):
                    let statusCode = response.response?.statusCode
                    self.errorMessage = APIError(message: "Error al obtener películas: \(error.localizedDescription)", statusCode: statusCode)
                    print("Error en la API: \(self.errorMessage?.message ?? "Error desconocido")")
                }
            }
    }
    
    func getGenres() {
        AF
            .request("https://api.themoviedb.org/3/genre/movie/list?api_key=efbc2b95033e7dde757b6c455744baa2", method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: GenreResponse.self) { response in
                switch response.result {
                case .success(let data):
                    self.genres = Dictionary(uniqueKeysWithValues: data.genres.map { ($0.id, $0.name) })
                case .failure(let error):
                    let statusCode = response.response?.statusCode
                    self.errorMessage = APIError(message: "Error al obtener generos: \(error.localizedDescription)", statusCode: statusCode)
                    print("Error en los generos: \(self.errorMessage?.message ?? "Error desconocido")")
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
                    self.errorMessage = APIError(message: "Error al obtener monto: \(error.localizedDescription)", statusCode: statusCode)
                    print("Error en el monto: \(self.errorMessage?.message ?? "Error desconocido")")
                }
            }
    }

    
    func genreNames(for movie: Movie) -> String {
        let genreNames = movie.genre_ids.compactMap { genres[$0] }
        return genreNames.joined(separator: ", ")
    }
}

