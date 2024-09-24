//
//  ContentView.swift
//  Movie-Test-JR
//
//  Created by Sebastian Marquez Rojas on 05/09/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var moviesVM: MoviesVM
    var body: some View {
        MoviesView(moviesVM: moviesVM)
    }
}
