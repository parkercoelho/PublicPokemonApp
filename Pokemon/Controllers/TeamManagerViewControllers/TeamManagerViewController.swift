//
//  TeamManagerViewController.swift
//  Pokemon
//
//  Created by Parker Coelho on 11/26/22.
//

import UIKit
import PokemonAPI

class TeamManagerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    var delegate: TeamsListTableViewController?
    let numberOfTypes: Int = 18
    var team: Team = Team(team: [], teamName: "My team")
    var teamTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "TypeCalcsGood")
        label.textAlignment = .center
        label.font = UIFont(name: "American Typewriter", size: 24)
        return label
    }()
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.teamTableView {
            return 6
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == self.teamTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "teamTableCell") as! TeamTableViewCell
            cell.delegate = self
            cell.constrainCell()
            cell.backgroundColor = .clear
            
            if indexPath.row < team.pokemonOnTeam.count {
                cell.configurePokemonNameLabel(pokemon: team.pokemonOnTeam[indexPath.row])
                cell.configurePokemonImage(pokemon: team.pokemonOnTeam[indexPath.row])
            }
            return cell
        }
        
        let cell = UITableViewCell()
        cell.backgroundColor = .systemBlue
        return cell
    }
    
    // MARK: - UI Components
    var coordinator: MainCoordinator?
    
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    let teamCell = "teamCell"
    let typeCell = "typeCell"
    let calcsSumCell = "calcsSumCell"
    let teamTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(TeamTableViewCell.self, forCellReuseIdentifier: "teamTableCell")
        
        return table
    }()
    
    let teamCollectionView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/9), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(TeamCollectionViewCell.self, forCellWithReuseIdentifier: "teamCell")
        return collection
    }()
    let searchSuggestionsTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.largeContentTitle = "Suggestions"
        return table
    }()
    let pokemonTypeChartStackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack .translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let typeCollectionView: UICollectionView = {
        //Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/9), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        //Horizontal Group
        let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, subitems: [item])

        //Section
        let section = NSCollectionLayoutSection(group: horizontalGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(TypeChartCalculationCollectionViewCell.self, forCellWithReuseIdentifier: "typeCell")
        collection.register(TypeChartCalculationCollectionViewCell.self, forCellWithReuseIdentifier: "calcsSumCell")
        collection.register(TypeCollectionHeaderView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: "HeaderSupplementaryView")
        collection.register(TypeLabelCollectionViewCell.self, forCellWithReuseIdentifier: "typeLabelStack")
        return collection
    }()
    
    
    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
                
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor(named: "TeaGreen")!.cgColor]
        gradientLayer.zPosition = -5
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.shouldRasterize = true
        
        view.layer.addSublayer(gradientLayer)
        view.addSubview(teamTitle)
        view.addSubview(teamTableView)
        view.addSubview(teamCollectionView)
        view.addSubview(searchSuggestionsTableView)
        view.addSubview(typeCollectionView)
        configureTitle()
        configureTeamTableView()
        configureTeamCollectionView()
        configureTableView()
        configureTypeCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
    }

    // MARK: - Helper functions
    func configureTitle() {
        teamTitle.text = team.teamName
        
        NSLayoutConstraint.activate([
            teamTitle.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            teamTitle.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            teamTitle.topAnchor.constraint(equalTo: safeArea.topAnchor)
        ])
    }
    
    func configureTeamTableView() {
        teamTableView.delegate = self
        teamTableView.dataSource = self
        teamTableView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            teamTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            teamTableView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
            teamTableView.topAnchor.constraint(equalTo: teamTitle.bottomAnchor),
            teamTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3)
        ])
    }
    func configureTypeCollectionView() {
        typeCollectionView.dataSource = self
        typeCollectionView.delegate = self
        typeCollectionView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            typeCollectionView.topAnchor.constraint(equalTo: searchSuggestionsTableView.bottomAnchor),
            typeCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            typeCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            typeCollectionView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
    func configureTeamCollectionView() {
        teamCollectionView.dataSource = self
        teamCollectionView.delegate = self
        teamCollectionView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            teamCollectionView.topAnchor.constraint(equalTo: view.centerYAnchor),
            teamCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            teamCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            teamCollectionView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    func configureTableView() {
        searchSuggestionsTableView.delegate = self
        searchSuggestionsTableView.dataSource = self
        NSLayoutConstraint.activate([
            searchSuggestionsTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            searchSuggestionsTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            searchSuggestionsTableView.topAnchor.constraint(equalTo: teamCollectionView.bottomAnchor),
            searchSuggestionsTableView.heightAnchor.constraint(equalToConstant: 0) // change this from zero to a different height to make the table view reappear
        ])
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        if collectionView == self.typeCollectionView {
//            return 6
//        }
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == self.upperTeamCollectionView {
//            return 6
//        }
        return 9
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.teamCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamCell, for: indexPath) as! TeamCollectionViewCell
            cell.backgroundColor = .clear
            cell.delegate = self 
            cell.setUpTeamCollectionViewCell(indexPath: indexPath)
            
            return cell }
        
        
        //setting up the first stack of type labels below
        else if collectionView == self.typeCollectionView, indexPath.row == 0 {
            let typeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "typeLabelStack", for: indexPath) as! TypeLabelCollectionViewCell
            typeCell.setUpTypeLabelCell()
            
            return typeCell
        }
        
        else if collectionView == self.typeCollectionView, indexPath.row > 0, indexPath.row <= 6 {
            let typeCell = collectionView.dequeueReusableCell(withReuseIdentifier: typeCell, for: indexPath) as! TypeChartCalculationCollectionViewCell
            typeCell.delegate = self
            typeCell.setUpCell(at: indexPath)
            return typeCell
        }
        else if collectionView == self.typeCollectionView, indexPath.row > 6 {
            let typeCell = collectionView.dequeueReusableCell(withReuseIdentifier: typeCell, for: indexPath) as! TypeChartCalculationCollectionViewCell
            typeCell.delegate = self
            team.updateAllTeamSums()
            typeCell.setUpSumCell(at: indexPath)
            return typeCell
        }
        else {
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.teamCollectionView {
            
            if indexPath.row > 0 && team.pokemonOnTeam.count < 6 {
                let pokemonToAdd = TeamPokemon(name: "squirtle", hp: 1, attack: 1, defense: 1, specialAttack: 1, specialDefense: 1, speed: 1, types: [.water], image: nil)
                coordinator?.toTeamBuilderFromTeamManager(pokemonToExamine: pokemonToAdd, delegate: self)
            }
            
            if indexPath.row > 0 && indexPath.row <= team.pokemonOnTeam.count {
                coordinator?.toTeamBuilderFromTeamManager(pokemonToExamine: team.pokemonOnTeam[indexPath.row-1], delegate: self)
            }
        }
        else {print("Not TeamCollectionView")}
    }
    
    func fetchSpriteAndUpdateTeamCollectionView(pokemon: Pokemon, cellPokemon: TeamPokemon) {
        PokemonController.fetchPokemonSprite(pokemon: pokemon) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    cellPokemon.image = image
                    self.team.add(pokemon: cellPokemon)
                    self.teamCollectionView.reloadData()
                    self.typeCollectionView.reloadData()
                    self.teamTableView.reloadData()

                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderSupplementaryView", for: indexPath) as! TypeCollectionHeaderView
        return headerView
    }
    

    // MARK: - CollectionView DataSource
}
