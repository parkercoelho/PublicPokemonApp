//
//  Persistence.swift
//  Pokemon
//
//  Created by Parker Coelho on 1/24/23.
//

import Foundation

class PersistenceFunctions {
    static func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let filename = "pokemonteams.json"
        let fullURL = documentsDirectory.appendingPathComponent(filename)
        return fullURL
    }
    static func saveTeams(teams: [Team]) {
        let je = JSONEncoder()
        var pokemonDictionary: [String: [String]] = [:]
        teams.forEach { team in
            var pokemonNames: [String] = []
            team.pokemonOnTeam.forEach { pokemon in
                pokemonNames.append(pokemon.name)
            }
            pokemonDictionary[team.teamName] = pokemonNames
        }
        do {
            let data = try je.encode(pokemonDictionary)
            try data.write(to: fileURL())
        } catch let e {
            print("error saving teams \(e)")
        }
    }
    static func loadTeamDictionaries() -> [String: [String]] {
        do {
            let data = try Data(contentsOf: fileURL())
            let jd = JSONDecoder()
            let teamDictionaries = try jd.decode([String: [String]].self, from: data)
            return teamDictionaries
        } catch let e {
            print ("error loading team names: \(e)")
            return [:]
        }
    }
    static func addTeam(teams: inout [Team], teamToAdd: Team) {
        teams.append(teamToAdd)
        saveTeams(teams: teams)
    }
    static func deleteTeam(teams: inout [Team], indexToRemove: Int) {
        teams.remove(at: indexToRemove)
        saveTeams(teams: teams)
    }
    static func deletePokemonFromTeam(teams: [Team], team: Team, indexToRemove: Int) {
        team.pokemonOnTeam.remove(at: indexToRemove)
        saveTeams(teams: teams)
    }
    static func addPokemonToTeam(teams: [Team], team: Team, newPokemon: TeamPokemon) {
        team.add(pokemon: newPokemon)
        saveTeams(teams: teams)
    }
}
