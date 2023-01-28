//
//  TeamsListTableViewController.swift
//  Pokemon
//
//  Created by Parker Coelho on 1/17/23.
//

import UIKit
import PokemonAPI

class TeamsListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var teams: [Team] = []
    var coordinator: MainCoordinator?
    var delegate: HomeScreenViewController?
    let teamsListCell = "cell"
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    let teamsListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        teamsListTableView.delegate = self
        teamsListTableView.dataSource = self
        teamsListTableView.backgroundColor = .clear
        teamsListTableView.separatorColor = .clear
        view.addSubview(teamsListTableView)
        NSLayoutConstraint.activate([
            teamsListTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            teamsListTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            teamsListTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            teamsListTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
       ])
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.teamsListTableView.register(TeamsListTableViewCell.self, forCellReuseIdentifier: "cell")
        }
    
    override func viewWillAppear(_ animated: Bool) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor(named: "TeaGreen")!.cgColor]
        gradientLayer.zPosition = -2
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .purple
        navigationController?.navigationBar.standardAppearance = appearance
//        navigationController?.navigationBar.layer.insertSublayer(gradientLayer, at: 0)

//        navigationItem.titleView?.layer.insertSublayer(gradientLayer, at: 0)
    }

    // MARK: - Table view data source
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return teams.count + 1
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == teamsListTableView {
            return teams.count+1
        } else { return 0}
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == teams.count {
            let float = CGFloat(100)
            return float
        }
        
        else { return 50 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: teamsListCell, for: indexPath) as? TeamsListTableViewCell else {return UITableViewCell()}
        
        if indexPath.row < teams.count {
            cell.team = self.teams[indexPath.row]
            cell.setUpCell()
            cell.delegate = self
            cell.backgroundColor = .clear
        }
        else if indexPath.row == teams.count {
            cell.delegate = self
            cell.backgroundColor = .clear
            cell.setUpNewTeam()
        }
        let cellBackgroundView = UIView()
        cellBackgroundView.backgroundColor = UIColor(named: "BackgroundColor")
        cell.selectedBackgroundView = cellBackgroundView
        
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                
        tableView.backgroundColor = UIColor(named: "TypeCalcsRed")
        if indexPath.row < teams.count {
            if editingStyle == .delete {
                PersistenceFunctions.deleteTeam(teams: &self.teams, indexToRemove: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                delegate?.teams = self.teams
            }
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let releaseAction = UIContextualAction(style: .destructive, title: "Release") { (_, _, completionHandler) in
            PersistenceFunctions.deleteTeam(teams: &self.teams, indexToRemove: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.delegate?.teams = self.teams
            completionHandler(true)
        }
        releaseAction.image = UIImage(systemName: "trash")
        releaseAction.backgroundColor = UIColor(named: "TypeCalcsRed")
        let configuration = UISwipeActionsConfiguration(actions: [releaseAction])
        return configuration
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row < teams.count {
            coordinator?.toTeamManagerFromTeamsList(team: teams[indexPath.row], delegate: self)
        }
        
        else if indexPath.row == teams.count {
            let newTeam = Team(team: [], teamName: "Team: \(indexPath.row+1)")
            PersistenceFunctions.addTeam(teams: &self.teams, teamToAdd: newTeam)
            delegate?.teams = self.teams
            tableView.reloadData()
            coordinator?.toTeamManagerFromTeamsList(team: teams[indexPath.row], delegate: self)
        }
    }
    
    
}
