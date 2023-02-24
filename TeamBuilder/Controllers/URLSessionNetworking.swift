//
//  URLSessionNetworking.swift
//  TeamBuilder
//
//  Created by Parker Coelho on 2/23/23.
//

import Foundation

protocol URLSessionNetworkingProtocol {
    static func fetchStats() throws -> Void
}

class URLSessionNetworking: URLSessionNetworkingProtocol {
    
    static func fetchStats() throws -> Void {
        guard let baseURL = URL(string: "https://raw.githubusercontent.com/pkmn/smogon/main/data/stats/gen9nationaldex.json") else { return }
        
        URLSession.shared.dataTask(with: baseURL) { data, response, error in
            if let error = error {
                print("There was an error \(error): \(error.localizedDescription)")
            }
            guard let data = data else {
                print("error with data")
                return
            }
            
            do {
                let jsonRes = try JSONSerialization.jsonObject(with: data, options: [])
                let jd = JSONDecoder()
                let newPokemon = try jd.decode(TopLevelObject.self, from: data)
                print(newPokemon)
                dump(newPokemon.pokemon.array)
                print("The count of the array is \(newPokemon.pokemon.array.count)")
            }
            catch let e {
                print("error decoding data \(e)")
            }
        }.resume()
    }
}


