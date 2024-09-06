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
            if let posterPath = movie.poster_path{
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { image in
                    image
                        .resizable()
                         .aspectRatio(contentMode: .fill)
                         .frame(width: 300, height: 450)
                         .clipShape(RoundedRectangle(cornerRadius: 20))
                         
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
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                    .background(.ultraThinMaterial)
                Text("Popularity: \(movie.popularity.formatted(.number.precision(.fractionLength(0...2))))")
                    .font(.caption)
            }
        }
    }
}

