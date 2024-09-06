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
    
    var body: some View {
        NavigationStack{
            List(moviesVM.movies) { item in
                NavigationLink{
                    
                    MovieDescription(movie: item)
                }label: {
                    HStack(alignment: .center, spacing: 10) {
                        if let posterPath = item.backdrop_path {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100)
                                    .padding(8)
                                    .border(.gray,width: 0.4)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        VStack(alignment: .leading, spacing: 10) {
                            Text(item.title)
                                .font(.title)
                            Text(item.overview)
                                .font(.subheadline)
                                .foregroundStyle(.gray.opacity(0.9))
                                .lineLimit(3)
                        }
                    }
                }

                
            }
            .navigationTitle("Films")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        darkMode.toggle()
                    }label: {
                        Image(systemName: darkMode ? "moon.stars.fill" : "sun.max.fill")
                            .resizable()
                            .font(.title)
                            .foregroundStyle(darkMode ? .gray.opacity(0.7) : .yellow.opacity(0.7))
                    }
                }
            }
            
        }.preferredColorScheme(darkMode ? .dark : .light)
    }}
