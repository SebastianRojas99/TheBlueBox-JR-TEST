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
        NavigationStack{
            ScrollView{
                LazyVStack(alignment:.leading){
                    ForEach(moviesVM.movies){item in
                        HStack{
                            Image(systemName: "arrow.right")
                                .font(.title3)
                            VStack(alignment: .leading){
                                Text(item.title)
                                    .font(.title)
                                Text(item.overview)
                                    .font(.subheadline)
                            }
                        }       
                    }
                }
            }
        }.navigationTitle("Films")
    }
}

