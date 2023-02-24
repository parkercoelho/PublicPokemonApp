//
//  MainCoordinator.swift
//  Pokemon
//
//  Created by Parker Coelho on 11/5/22.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeScreenViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func toTeamBuilderFromTeamManager(pokemonToExamine: TeamPokemon, delegate: TeamManagerViewController?) {
        let vc = TeamBuilderViewController(pokemon: pokemonToExamine)
        if vc.teamPokemon.image == nil {
            vc.testContainerView.isHidden = true
        }
        vc.delegate = delegate
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    func toTeamManager() {
        let vc = TeamManagerViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    func toTeamManagerFromTeamsList(team: Team, delegate: TeamsListTableViewController) {
        let vc = TeamManagerViewController()
        vc.team = team
        vc.delegate = delegate
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    func toTeamsList(teams: [Team], delegate: HomeScreenViewController) {
        let vc = TeamsListTableViewController()
        vc.teams = teams
        vc.delegate = delegate
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toRecommendations(team: Team, delegate: TeamManagerViewController) {
        let vc = RecommendationsViewController()
        vc.team = team
        vc.delegate = delegate
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
