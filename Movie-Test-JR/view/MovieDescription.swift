//
//  MovieDescription.swift
//  Movie-Test-JR
//
//  Created by Sebastian Marquez Rojas on 05/09/2024.
//

import SwiftUI

struct MovieDescription: View {
    @State  var movie: Movie
    @State var moviesVM = MoviesVM()
    var body: some View {
        VStack{
            if let posterPath = movie.backdrop_path {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { image in
                    image
                        .resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(width: 300, height: 450)
                } placeholder: {
                    ProgressView()
                }
                
                Text(movie.title)
                    .font(.largeTitle)
                    .bold()
                Text(movie.overview)
                    .font(.subheadline)
                    .lineLimit(4)
                Text(moviesVM.genreNames(for: movie))
                Text("\(movie.popularity)")
                    .font(.caption)
            }
        }
    }
}

