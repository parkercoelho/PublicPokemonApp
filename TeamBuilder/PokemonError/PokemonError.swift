//
//  PokemonError.swift
//  Pokemon
//
//  Created by Parker Coelho on 11/5/22.
//

import Foundation

enum PokemonError: LocalizedError {
    case invalidURL
    case dataTaskError
    case noData
    case badDecodeImage
    
    var errorDescription: String? {
        switch self {
            
        case .invalidURL:
            return "unable to reach the URL"
        case .dataTaskError:
            return "print out the localized error"
        case .noData:
            return "no data returned"
        case .badDecodeImage:
            return "image couldn't be decoded"
        }
    }
}


