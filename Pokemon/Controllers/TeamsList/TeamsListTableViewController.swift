//
//  TeamsListTableViewController.swift
//  Pokemon
//
//  Created by Parker Coelho on 1/17/23.
//

import UIKit

class TeamsListTableViewController: UITableViewController {
    
    var teams: [Team] = [Team(team: [], teamName: "My team")]
    var coordinator: MainCoordinator?
    var delegate: HomeScreenViewController?
    
    let teamsListCell = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()

         self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: teamsListCell, for: indexPath)

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            teams.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newPokemon: TeamPokemon = TeamPokemon(name: "pikachu", hp: indexPath.row, attack: indexPath.row, defense: indexPath.row, specialAttack: indexPath.row, specialDefense: indexPath.row, speed: indexPath.row, types: [.water], image: .strokedCheckmark)
        let newTeam: Team = Team(team: [newPokemon], teamName: "Team \(indexPath.row)!")
        teams.append(newTeam)
        PersistenceFunctions.saveTeams(teams: teams)
        print("Attempted to save")
    }
}
