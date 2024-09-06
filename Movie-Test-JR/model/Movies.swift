//
//  Movies.swift
//  Movie-Test-JR
//
//  Created by Sebastian Marquez Rojas on 05/09/2024.
//

import Foundation


struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let backdrop_path: String?
    let poster_path:String?
    let genre_ids:[Int]
    let popularity:Double
    let release_date:String    
}

struct Response:Codable{
    var results:[Movie]
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct GenreResponse: Codable {
    let genres: [Genre]
}

struct MovieDetails: Codable {
    let budget: Int
}
