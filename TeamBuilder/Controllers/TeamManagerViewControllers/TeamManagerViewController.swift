//
//  TeamManagerViewController.swift
//  Pokemon
//
//  Created by Parker Coelho on 11/26/22.
//

import UIKit
import PokemonAPI

class TeamManagerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UITextFieldDelegate {
    
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
    var editableTeamTitle: UITextField = {
        let t = UITextField()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.textColor = UIColor(named: "TypeCalcsGood")
        t.textAlignment = .center
        t.font = UIFont(name: "American Typewriter", size: 24)
        return t
    }()
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == editableTeamTitle {
        return true}
        else {return true}
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Text finished editing")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let delegate = delegate else {return false}
        var boolToReturn = true
        
        if textField.text!.isEmpty {
            textField.placeholder = "Type something"
            return false
        }
        else if textField.text!.lowercased() == team.teamName.lowercased() {
            textField.text = textField.text!.capitalized
            textField.resignFirstResponder()
            return true}
        else {
            delegate.teams.forEach { team in
                if team.teamName.lowercased() == textField.text!.lowercased() {
                    textField.text = ""
                    textField.placeholder = "Use another name"
                    boolToReturn = false
                }
            }
            if boolToReturn {
                team.teamName = textField.text!.capitalized
                PersistenceFunctions.saveTeams(teams: delegate.teams)
                delegate.teamsListTableView.reloadData()
                textField.resignFirstResponder()
            }
            return boolToReturn
        }
    }
    
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
            let cellBackgroundView = UIView()
            cellBackgroundView.backgroundColor = UIColor(named: "BackgroundColor")
            cell.selectedBackgroundView = cellBackgroundView
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
        table.separatorColor = .clear
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
        collection.isScrollEnabled = false
        collection.register(TypeChartCalculationCollectionViewCell.self, forCellWithReuseIdentifier: "typeCell")
        collection.register(TypeChartCalculationCollectionViewCell.self, forCellWithReuseIdentifier: "calcsSumCell")
        collection.register(TypeCollectionHeaderView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: "HeaderSupplementaryView")
        collection.register(TypeLabelCollectionViewCell.self, forCellWithReuseIdentifier: "typeLabelStack")
        return collection
    }()
    let containerScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = true
        scroll.isDirectionalLockEnabled = true
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    let scrollContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
//        view.addSubview(teamTitle)
        view.addSubview(editableTeamTitle)
        view.addSubview(containerScrollView)
        containerScrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(teamTableView)
        scrollContentView.addSubview(teamCollectionView)
        scrollContentView.addSubview(searchSuggestionsTableView)
        scrollContentView.addSubview(typeCollectionView)
        
//        containerScrollView.topAnchor.constraint(equalTo: teamTitle.bottomAnchor).isActive = true
        containerScrollView.topAnchor.constraint(equalTo: editableTeamTitle.bottomAnchor).isActive = true
        
        containerScrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        containerScrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        containerScrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            scrollContentView.topAnchor.constraint(equalTo: containerScrollView.topAnchor),
            scrollContentView.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: containerScrollView.bottomAnchor),
            scrollContentView.centerXAnchor.constraint(equalTo: containerScrollView.centerXAnchor)
        ])
        
        configureTitle()
        configureTeamTableView()
        configureTeamCollectionView()
        configureTableView()
        configureTypeCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
    }

    @objc func endEditing() {
        editableTeamTitle.endEditing(true)
    }
    
    // MARK: - Helper functions
    func configureTitle() {
        editableTeamTitle.text = team.teamName
        editableTeamTitle.delegate = self
        
        NSLayoutConstraint.activate([
            editableTeamTitle.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            editableTeamTitle.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            editableTeamTitle.topAnchor.constraint(equalTo: safeArea.topAnchor)
        ])
    }
    func configureTeamTableView() {
        teamTableView.delegate = self
        teamTableView.dataSource = self
        teamTableView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            teamTableView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 10),
            teamTableView.trailingAnchor.constraint(equalTo: scrollContentView.centerXAnchor, constant: -20),
            teamTableView.topAnchor.constraint(equalTo: scrollContentView.topAnchor),
            teamTableView.heightAnchor.constraint(equalTo: scrollContentView.heightAnchor, multiplier: 1/3)
            
        ])
    }
    func configureTeamCollectionView() {
        teamCollectionView.dataSource = self
        teamCollectionView.delegate = self
        teamCollectionView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            teamCollectionView.topAnchor.constraint(equalTo: teamTableView.bottomAnchor),
            teamCollectionView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 10),
            teamCollectionView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -10),
            teamCollectionView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    func configureTypeCollectionView() {
        typeCollectionView.dataSource = self
        typeCollectionView.delegate = self
        typeCollectionView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            typeCollectionView.topAnchor.constraint(equalTo: teamCollectionView.bottomAnchor),
            typeCollectionView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 10),
            typeCollectionView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -10),
            typeCollectionView.heightAnchor.constraint(equalToConstant: 500),
            typeCollectionView.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor)
        ])
    }
    func configureTableView() {
        searchSuggestionsTableView.delegate = self
        searchSuggestionsTableView.dataSource = self
        NSLayoutConstraint.activate([
            searchSuggestionsTableView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            searchSuggestionsTableView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= team.pokemonOnTeam.count {
            coordinator?.toTeamBuilderFromTeamManager(pokemonToExamine: TeamPokemon(name: "Squirtle", hp: 20, attack: 20, defense: 20, specialAttack: 20, specialDefense: 20, speed: 120, types: [.electric], image: nil), delegate: self)
        }
        else if indexPath.row < team.pokemonOnTeam.count {
            coordinator?.toTeamBuilderFromTeamManager(pokemonToExamine: team.pokemonOnTeam[indexPath.row], delegate: self)
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let releaseAction = UIContextualAction(style: .destructive, title: "Release") { (_, _, completionHandler) in
            if let delegate = self.delegate {
                PersistenceFunctions.deletePokemonFromTeam(teams: delegate.teams, team: self.team, indexToRemove: indexPath.row)
                tableView.reloadData()
                self.teamCollectionView.reloadData()
                completionHandler(true)
            }
        }
        releaseAction.image = UIImage(systemName: "trash")
        releaseAction.backgroundColor = UIColor(named: "TypeCalcsRed")
        let configuration = UISwipeActionsConfiguration(actions: [releaseAction])
        return configuration
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.teamCollectionView {
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
