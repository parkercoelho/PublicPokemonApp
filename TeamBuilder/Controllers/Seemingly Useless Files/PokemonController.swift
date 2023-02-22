//
//  PokemonController.swift
//  Pokemon
//
//  Created by Parker Coelho on 11/5/22.
//

import UIKit
import PokemonAPI

class PokemonController {
    static let pokeapiURL = URL(string: "https://pokeapi.co/api/v2/")
    static let showdownPokemonURL = URL(string: "https://play.pokemonshowdown.com/data/pokedex.json")
    static let pokemonEndPoint = "pokemon"
    
    static func fetchPokemonFromPoke(searchTerm: String, completion: @escaping (Result<Pokemon, PokemonError>) -> Void) {
        // 1 - URL
        guard let baseURL = pokeapiURL else {return completion(.failure(.invalidURL))}
        let pokemonURL = baseURL.appendingPathComponent(pokemonEndPoint)
        let searchTermURL = pokemonURL.appendingPathComponent(searchTerm.lowercased())
        print(searchTermURL)
        
        // 2 - Data Task
        URLSession.shared.dataTask(with: searchTermURL) { data, _, error in
            
            // 3 - Error Handling
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.dataTaskError))
            }
            // 4 - Check for Data
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            // 5 - Decode Data
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                return completion(.success(pokemon))
            }
            catch {
                print(error)
                return completion(.failure(.dataTaskError))
            }
        }.resume()
    }
    
    
    static func fetchPokemonSprite(pokemon: Pokemon, completion: @escaping (Result<UIImage, PokemonError>) -> Void) {
        // 1 - URL
        let spriteURL = pokemon.sprites.classicSprite
        
        // 2 - DataTask
        URLSession.shared.dataTask(with: spriteURL) { data, _, error in
            
            // 3 - Error handling
            if let error = error {
                print(error)
                return completion(.failure(.dataTaskError))
            }
            // 4 - Data check
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            
            // 5 - Decode Data
            guard let sprite = UIImage(data: data) else {return completion(.failure(.badDecodeImage))}
            return completion(.success(sprite))
            
        }.resume()
    }
    
    static func newFetchPokemonFromPoke(searchTerm: String) async throws -> Pokemon {
        guard let baseURL = pokeapiURL else {
            throw PokemonError.invalidURL
        }
        let pokemonURL = baseURL.appendingPathComponent(pokemonEndPoint)
        let searchTermURL = pokemonURL.appendingPathComponent(searchTerm.lowercased())
        print(searchTermURL)
        
        let (data, _) = try await URLSession.shared.data(from: searchTermURL)
        
        let pokemonResult = try JSONDecoder().decode(Pokemon.self, from: data)
        return pokemonResult
    }
    
    static func newFetchPokemonSprite(pokemon: Pokemon) async throws -> UIImage {
        let spriteURL = pokemon.sprites.classicSprite
        let (data, _) = try await URLSession.shared.data(from: spriteURL)
        
        guard let image = UIImage(data: data) else {
            throw PokemonError.badDecodeImage
        }
        return image
    }
}
