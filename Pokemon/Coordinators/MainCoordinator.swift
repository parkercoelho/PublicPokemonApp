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
        let vc = TeamBuilderViewController()
        vc.delegate = delegate 
        vc.coordinator = self
//        vc.teamPokemon = pokemonToExamine
//        vc.fetchAndCreateTeamPokemon(searchTerm: pokemonToExamine)
//        guard let pokemon = vc.selectedTeamPokemon else {return}
//        vc.team.add(pokemon: pokemon)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toTeamManager() {
        let vc = TeamManagerViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toTeamsList() {
        let vc = TeamsListTableViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
