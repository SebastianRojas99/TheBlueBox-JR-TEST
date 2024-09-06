//
//  Error.swift
//  Movie-Test-JR
//
//  Created by Sebastian Marquez Rojas on 05/09/2024.
//
import Foundation

struct APIError: Error {
    var message: String
    var statusCode: Int?
    
    init(message: String, statusCode: Int? = nil) {
        self.message = message
        self.statusCode = statusCode
    }
}
