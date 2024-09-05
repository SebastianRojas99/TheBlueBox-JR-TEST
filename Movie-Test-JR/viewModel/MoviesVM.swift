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
class MoviesVM{
    
    var movies:[Movie] = []
    
    init() {
        getAllMovies()
    }
    
    func getAllMovies(){
        AF
            .request(
                api,
                method: .get
            )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Response.self){response in
                switch response.result{
                case .success(let data):
                    self.movies = Array(data.results)
                    print("successful")
                case .failure(let error):
                    print("error en la api: ",error)
                }
            }
    }
    func getById(id:Int){
        
    }
}
