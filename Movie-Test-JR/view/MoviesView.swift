//
//  MoviesView.swift
//  Movie-Test-JR
//
//  Created by Sebastian Marquez Rojas on 05/09/2024.
//

import SwiftUI

struct MoviesView: View {
    @State private var moviesVM = MoviesVM()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading) { // Usa LazyVStack aquí para optimizar la lista
                    ForEach(moviesVM.movies) { item in
                        NavigationLink {
                            MovieDescription(movie: item)
                        } label: {
                            HStack {
                                if let posterPath = item.backdrop_path {
                                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 150)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                                VStack(alignment: .leading) {
                                    Text(item.title)
                                        .font(.title)
                                        .foregroundStyle(.black)
                                    Text(item.overview)
                                        .font(.subheadline)
                                        .foregroundStyle(.gray.opacity(0.9))
                                }
                                .padding(.leading, 10) // Añadir padding a la izquierda si es necesario
                            }
                            .padding() // Padding general para cada item
                        }
                    }
                }
            }
            .navigationTitle("Films")
        }
    }
}
