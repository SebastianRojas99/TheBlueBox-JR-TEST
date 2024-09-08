//
//  MoviesView.swift
//  Movie-Test-JR
//
//  Created by Sebastian Marquez Rojas on 05/09/2024.
//

import SwiftUI

struct MoviesView: View {
    @State private var moviesVM = MoviesVM()
    @AppStorage("darkMode") private var darkMode: Bool = false
    @State private var showMessage = false
    
    var body: some View {
        NavigationStack {
            List(moviesVM.movies, id: \.id) { movie in
                NavigationLink {
                    MovieDescription(movie: movie)
                } label: {
                    HStack(alignment: .center, spacing: 10) {
                        if let posterPath = movie.backdrop_path {
                            AsyncImage(url: URL(string: "\(apiImage)\(posterPath)")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100)
                                    .padding(8)
                                    .border(.gray, width: 0.4)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        VStack(alignment: .leading, spacing: 10) {
                            Text(movie.title)
                                .font(.title)
                            Text(movie.overview)
                                .font(.subheadline)
                                .foregroundStyle(.gray.opacity(0.9))
                                .lineLimit(3)
                        }
                    }
                }
                .onAppear {
                    if movie.id == moviesVM.movies.last?.id {
                        if moviesVM.currentPage < moviesVM.maxPage {
                            moviesVM.getAllMovies()
                        } else if moviesVM.currentPage == moviesVM.maxPage && !showMessage {
                            showMessage = true
                        }
                    }
                    if movie.id == moviesVM.movies.first?.id {
                        showMessage = false
                    }
                }
            }
            .navigationTitle("Films")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        darkMode.toggle()
                    } label: {
                        Image(systemName: darkMode ? "moon.stars.fill" : "sun.max.fill")
                            .resizable()
                            .font(.title)
                            .foregroundStyle(darkMode ? .gray.opacity(0.7) : .yellow.opacity(0.7))
                    }
                }
            }
            Text(showMessage ? "Maximo alcanzado" : "")
        }
        .preferredColorScheme(darkMode ? .dark : .light)
    }
}
