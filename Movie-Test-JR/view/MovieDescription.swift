//
//  MovieDescription.swift
//  Movie-Test-JR
//
//  Created by Sebastian Marquez Rojas on 05/09/2024.
//

import SwiftUI

struct MovieDescription: View {
    @State var budget:Int = 0
    @State  var movie: Movie
    @ObservedObject var moviesVM: MoviesVM
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment:.center){
                    
                    if let posterPath = movie.poster_path{
                        AsyncImage(url: URL(string: "\(apiImage)\(posterPath)")) { image in
                            ZStack{
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 400, height: 450)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .blur(radius: 50)
                                
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 300, height: 450)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                            
                            
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    
                    
                    VStack{
                        Text(movie.title)
                            .font(.largeTitle)
                            .bold()
                        Text(movie.overview)
                            .font(.subheadline)
                            .frame(alignment:.center)
                            .foregroundStyle(.gray.opacity(0.9))
                            .lineLimit(7)
                        
                        Text(moviesVM.genreNames(for: movie))
                            .padding()
                            .background(.ultraThinMaterial)
                        VStack(spacing:5){
                            Text("Budget: \(moviesVM.budget)")
                                .font(.callout)
                            Text("Popularity: \(movie.popularity.formatted(.number.precision(.fractionLength(0...2))))")
                                .font(.caption)
                            Text("Release date: \(movie.release_date)")
                                .font(.caption2)
                        }
                        
                        
                    }.padding()
                    
                    
                    
                }
            }.navigationTitle("Detail")
                .onAppear {
                    
                    moviesVM.getBudget(id: movie.id)
                }
            
        }
    }
    
}
