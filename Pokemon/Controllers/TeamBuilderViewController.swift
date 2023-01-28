//
//  TeamBuilderViewController.swift
//  Pokemon
//
//  Created by Parker Coelho on 11/5/22.

import UIKit
import PokemonAPI

class TeamBuilderViewController: UIViewController {
    // MARK: -  Properties
    var coordinator: MainCoordinator?
    var selectedTeamPokemon: TeamPokemon?
    var delegate: TeamManagerViewController?
    var teamPokemon: TeamPokemon = TeamPokemon(name: "squirtle", hp: 45, attack: 55, defense: 65, specialAttack: 75, specialDefense: 85, speed: 120, types: [.water], image: nil)
    
    var hpWidthAnchor: NSLayoutConstraint!
    var attackWidthAnchor: NSLayoutConstraint!
    var defenseWidthAnchor: NSLayoutConstraint!
    var specialAttackWidthAnchor: NSLayoutConstraint!
    var specialDefenseWidthAnchor: NSLayoutConstraint!
    var speedWidthAnchor: NSLayoutConstraint!
    
    
    // MARK: - UI Components
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    let searchBar: UISearchBar = {
        let search = UISearchBar()
        print(search.subviews)
        return search
    }()
    let searchSuggestionsTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        return table
    }()
    let teamCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(TeamCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collection
    }()
    var statsStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    let pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Insert name here"
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")
        label.font = UIFont(name: "American Typewriter Bold", size: 36)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    let pokemonImageView: UIImageView = {
        let image = UIImageView()
        image.image = .strokedCheckmark
        return image
    }()
    let abilitiesStackView: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    let hpStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    let attackStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    let defenseStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    let specialAttackStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    let specialDefenseStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    let speedStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    let hpLabel = {return UILabel(statName: "hp")}()
    let attackLabel = {return UILabel(statName: "attack")}()
    let defenseLabel = {return UILabel(statName: "defense")}()
    let specialAttackLabel = {return UILabel(statName: "special attack")}()
    let specialDefenseLabel = {return UILabel(statName: "special defense")}()
    let speedLabel = {return UILabel(statName: "speed")}()
    let addToTeamButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 12
        button.setTitle("Add to team", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    let testContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isHidden = true
        return view
    }()
    
    var searchSuggestions: [String] = ["Squirtle","pikachu"]
    
    // MARK: - Lifecycle Methods

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

        addToTeamButton.addTarget(self, action: #selector(addPokemonToDelegateTeam), for: .touchUpInside)
        setUpView()
        constrainViews()
        //testing updating below
        reconfigureStatStacks(for: teamPokemon)
    }
    override func viewDidAppear(_ animated: Bool) {
        searchBar.changePlaceholderColor(UIColor(named: "TypeCalcsDarkGreen")!)
        searchBar.changeSearchBarTextColor(UIColor(named: "TypeCalcsDarkGreen")!)
        searchBar.changeImageColor(UIColor(named: "TypeCalcsDarkGreen")!)
    }
    
    // MARK: - UI Functions
    func setUpView() {
        view.backgroundColor = .white
        addAllViews()
        configureTableView()
        configureCollectionView()
        configureSearchBar()
        configureStatStackView()
        configureIndividualStatStack(for: hpStack, stat: hpLabel)
        configureIndividualStatStack(for: attackStack, stat: attackLabel)
        configureIndividualStatStack(for: defenseStack, stat: defenseLabel)
        configureIndividualStatStack(for: specialAttackStack, stat: specialAttackLabel)
        configureIndividualStatStack(for: specialDefenseStack, stat: specialDefenseLabel)
        configureIndividualStatStack(for: speedStack, stat: speedLabel)
        configureAbilitiesStackView()
        
        updateTeamPokemonViews(teamPokemon: teamPokemon)
    }
    func addAllViews() {
//
//        self.view.addSubview(searchBar)
//        self.view.addSubview(pokemonNameLabel)
//        self.view.addSubview(pokemonImageView)
//        self.view.addSubview(abilitiesStackView)
//        self.view.addSubview(statsStack)
//        self.view.addSubview(teamCollectionView)
//        self.view.addSubview(addToTeamButton)
//
        self.view.addSubview(searchBar)
        self.view.addSubview(searchSuggestionsTableView)
        testContainerView.addSubview(pokemonNameLabel)
        testContainerView.addSubview(pokemonImageView)
        testContainerView.addSubview(abilitiesStackView)
        testContainerView.addSubview(statsStack)
        testContainerView.addSubview(teamCollectionView)
        testContainerView.addSubview(addToTeamButton)
        view.addSubview(testContainerView)
    }
    func updateTeamPokemonViews(teamPokemon: TeamPokemon) {
        pokemonImageView.image = teamPokemon.image
        pokemonNameLabel.text = teamPokemon.name.capitalized
        //set up abilities later
        reconfigureStatStacks(for: teamPokemon)
    }
    
    @objc func addPokemonToDelegateTeam() {
        print("Button tapped")
        delegate?.team.add(pokemon: teamPokemon)
        print("pokemon added")
        delegate?.teamTableView.reloadData()
        delegate?.teamCollectionView.reloadData()
        delegate?.typeCollectionView.reloadData()
    }
    
    // MARK: - Configurations
    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.clearBackgroundColor()
        searchBar.placeholder = "Search for a new team pokemon"
        searchBar.keyboardType = .default
        searchBar.autocorrectionType = .no
    }
    func configureTableView() {
        searchSuggestionsTableView.delegate = self
        searchSuggestionsTableView.dataSource = self
        NSLayoutConstraint.activate([
            searchSuggestionsTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            searchSuggestionsTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            searchSuggestionsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            searchSuggestionsTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        searchSuggestionsTableView.isHidden = true
    }
    func configureCollectionView() {
        teamCollectionView.backgroundColor = .white
        teamCollectionView.delegate = self
        teamCollectionView.dataSource = self
        NSLayoutConstraint.activate([
            teamCollectionView.leadingAnchor.constraint(equalTo: pokemonNameLabel.leadingAnchor),
            teamCollectionView.trailingAnchor.constraint(equalToSystemSpacingAfter: safeArea.trailingAnchor, multiplier: 1.25),
            teamCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            teamCollectionView.heightAnchor.constraint(equalTo: searchBar.heightAnchor)
        ])
        teamCollectionView.isHidden = true
    }
    func reconfigureStatStacks(for pokemon: TeamPokemon) {
        hpStack.arrangedSubviews[1].updateBarColor(on: pokemon.hp)
        attackStack.arrangedSubviews[1].updateBarColor(on: pokemon.attack)
        defenseStack.arrangedSubviews[1].updateBarColor(on: pokemon.defense)
        specialAttackStack.arrangedSubviews[1].updateBarColor(on: pokemon.specialAttack)
        specialDefenseStack.arrangedSubviews[1].updateBarColor(on: pokemon.specialDefense)
        speedStack.arrangedSubviews[1].updateBarColor(on: pokemon.speed)
        
        updateBarWidth(widthAnchor: hpWidthAnchor, stat: CGFloat(pokemon.hp))
        updateBarWidth(widthAnchor: attackWidthAnchor, stat: CGFloat(pokemon.attack))
        updateBarWidth(widthAnchor: defenseWidthAnchor, stat: CGFloat(pokemon.defense))
        updateBarWidth(widthAnchor: specialAttackWidthAnchor, stat: CGFloat(pokemon.specialAttack))
        updateBarWidth(widthAnchor: specialDefenseWidthAnchor, stat: CGFloat(pokemon.specialDefense))
        updateBarWidth(widthAnchor: speedWidthAnchor, stat: CGFloat(pokemon.speed))
    }
    
    func updateBarWidth(widthAnchor: NSLayoutConstraint, stat: CGFloat) {
        
        let safeWidthHalf = safeArea.layoutFrame.width / 2
        let ratio = stat/safeWidthHalf
        
        widthAnchor.constant = 25 + (ratio * safeWidthHalf)
        widthAnchor.isActive = true
    }
    
    func configureIndividualStatStack(for stack: UIStackView, stat: UILabel) {
        stack.addArrangedSubview(stat)
        let barViewContainer = UIView()
        barViewContainer.layer.cornerRadius = 10
        barViewContainer.layer.masksToBounds = true
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(barViewContainer)
        NSLayoutConstraint.activate([
            // instead of making the constant below 50, it should be a variable dependent on phone type
            barViewContainer.leadingAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: -50)])
        
        switch stat.text {
        case "hp":
            barViewContainer.updateBarColor(on: teamPokemon.hp)
            hpWidthAnchor = barViewContainer.widthAnchor.constraint(equalToConstant: CGFloat(teamPokemon.hp))
            updateBarWidth(widthAnchor: hpWidthAnchor, stat: CGFloat(teamPokemon.hp))

        case "attack":
            barViewContainer.updateBarColor(on: teamPokemon.attack)
            attackWidthAnchor = barViewContainer.widthAnchor.constraint(equalToConstant: CGFloat(teamPokemon.attack))
            updateBarWidth(widthAnchor: attackWidthAnchor, stat: CGFloat(teamPokemon.attack))
        case "defense":
            barViewContainer.updateBarColor(on: teamPokemon.defense)
            defenseWidthAnchor = barViewContainer.widthAnchor.constraint(equalToConstant: CGFloat(teamPokemon.defense))
            updateBarWidth(widthAnchor: defenseWidthAnchor, stat: CGFloat(teamPokemon.defense))
        case "special attack":
            barViewContainer.updateBarColor(on: teamPokemon.specialAttack)
            specialAttackWidthAnchor = barViewContainer.widthAnchor.constraint(equalToConstant: CGFloat(teamPokemon.specialAttack))
            updateBarWidth(widthAnchor: specialAttackWidthAnchor, stat: CGFloat(teamPokemon.specialAttack))
        case "special defense":
            barViewContainer.updateBarColor(on: teamPokemon.specialDefense)
            specialDefenseWidthAnchor = barViewContainer.widthAnchor.constraint(equalToConstant: CGFloat(teamPokemon.specialDefense))
            updateBarWidth(widthAnchor: specialDefenseWidthAnchor, stat: CGFloat(teamPokemon.specialDefense))
        case "speed":
            barViewContainer.updateBarColor(on: teamPokemon.speed)
            speedWidthAnchor = barViewContainer.widthAnchor.constraint(equalToConstant: CGFloat(teamPokemon.speed))
            updateBarWidth(widthAnchor: speedWidthAnchor, stat: CGFloat(teamPokemon.speed))
        default:NSLayoutConstraint.activate([
            barViewContainer.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -180 + CGFloat(Double(stat.text ?? "100") ?? 100))])
        }
        
        
    }
    
    func configureStatStackView() {
        statsStack.addArrangedSubview(hpStack)
        statsStack.addArrangedSubview(attackStack)
        statsStack.addArrangedSubview(defenseStack)
        statsStack.addArrangedSubview(specialAttackStack)
        statsStack.addArrangedSubview(specialDefenseStack)
        statsStack.addArrangedSubview(speedStack)
        
        statsStack.alignment = .leading
        statsStack.distribution = .equalSpacing
        statsStack.axis = .vertical
    }
    func configureAbilitiesStackView() {
        abilitiesStackView.addArrangedSubview(UILabel(statName: "create Ability Label"))
    
        abilitiesStackView.alignment = .center
        abilitiesStackView.axis = .vertical
        abilitiesStackView.distribution = .fillEqually
    }
    // what is the best way to constrain/lay out things like stack views, table/collection views? Like do I constrain all the labels
    func constrainViews() {
        self.view.subviews.forEach {$0.translatesAutoresizingMaskIntoConstraints = false}
        testContainerView.subviews.forEach {$0.translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            testContainerView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            testContainerView.bottomAnchor.constraint(equalTo: addToTeamButton.topAnchor),
            testContainerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            testContainerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            searchBar.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.05),
            
            pokemonNameLabel.topAnchor.constraint(equalTo: teamCollectionView.bottomAnchor, constant: 10),
            pokemonNameLabel.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.05),
            pokemonNameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            
            
            pokemonImageView.topAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor),
            pokemonImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            pokemonImageView.trailingAnchor.constraint(equalTo: safeArea.centerXAnchor),
            pokemonImageView.widthAnchor.constraint(equalTo: pokemonImageView.heightAnchor),
            
            pokemonNameLabel.centerXAnchor.constraint(equalTo: pokemonImageView.centerXAnchor),
            
            abilitiesStackView.topAnchor.constraint(equalTo: pokemonImageView.topAnchor),
            abilitiesStackView.bottomAnchor.constraint(equalTo: pokemonImageView.bottomAnchor),
            abilitiesStackView.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor),
            abilitiesStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            statsStack.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor),
            statsStack.leadingAnchor.constraint(equalTo: pokemonImageView.leadingAnchor, constant: 10),
            statsStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            statsStack.heightAnchor.constraint(equalTo: pokemonImageView.heightAnchor),
            
            addToTeamButton.topAnchor.constraint(equalTo: statsStack.bottomAnchor, constant: 25),
            addToTeamButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 10),
            addToTeamButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10)
                    ])
    }
    func fetchAndCreateTeamPokemon(searchTerm: String) {
        guard let delegate = delegate else {return}
        PokemonAPI().pokemonService.fetchPokemon(searchTerm.lowercased()) {result in
            switch result {
            case .success(let pokemon):
                self.teamPokemon = TeamPokemon(pokemon: pokemon)!
                delegate.team.add(pokemon: self.teamPokemon)
                print(delegate.team.pokemonOnTeam)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func newFetchAndCreateTeamPokemon(searchTerm: String) async throws -> TeamPokemon {
        let fetchedTeamPokemon: TeamPokemon = try await withCheckedThrowingContinuation ({ continuation in
            PokemonAPI().pokemonService.fetchPokemon(searchTerm.lowercased()) { result in
                switch result {
                case .success(let fetchedPokemon):
                    guard let fetchedTeamPokemon = TeamPokemon(pokemon: fetchedPokemon) else {return}
                    continuation.resume(returning: fetchedTeamPokemon)
                case .failure(let error):
                    print(error)
                    continuation.resume(throwing: error)
                }
            }
        })
        return fetchedTeamPokemon
    }
    
}

    // MARK: - Extensions


extension TeamBuilderViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //
        teamCollectionView.isHidden = true
        testContainerView.isHidden = true 
        searchSuggestionsTableView.isHidden = false
        searchSuggestionsTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("clicked")
        guard let text = searchBar.text else {return}
        Task {
            do {
                let fetchedPokemon = try await newFetchAndCreateTeamPokemon(searchTerm: text)
                teamPokemon = fetchedPokemon
                updateTeamPokemonViews(teamPokemon: teamPokemon)
                searchSuggestionsTableView.isHidden = true
                testContainerView.isHidden = false
            }
            catch {
                print("Request failed with error: \(error)")
            }
        }
    }
}

extension TeamBuilderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchSuggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .darkGray
        cell.textLabel?.text = searchSuggestions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension UILabel {
    convenience init(statName: String) {
        self.init(frame: .zero)
        self.text = statName
    }
}
extension UIView {
    func updateBarColor(on stat: Int) {
        if stat < 60 {
            self.backgroundColor = UIColor(named: "AlertRed")
        }
        else if stat < 85 {
            self.backgroundColor = .orange
        }
        else if stat < 105 {
            self.backgroundColor = .yellow
        }
        else if stat < 130 {
            self.backgroundColor = .green
        }
        else {
            self.backgroundColor = .cyan
        }
    }
}
extension UISearchBar {
    public var textField: UITextField? {
            if #available(iOS 13, *) {
                return searchTextField
            }
            let subViews = subviews.flatMap { $0.subviews }
            guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
                return nil
            }
            return textField
        }
    
    func clearBackgroundColor() {
            guard let UISearchBarBackground: AnyClass = NSClassFromString("UISearchBarBackground") else { return }

            for view in subviews {
                for subview in view.subviews where subview.isKind(of: UISearchBarBackground) {
                    subview.alpha = 0
                }
            }
    }
    func changePlaceholderColor(_ color: UIColor) {
        guard let UISearchBarTextFieldLabel: AnyClass = NSClassFromString("UISearchBarTextFieldLabel"),
                    let field = textField else {
                    return
                }
                for subview in field.subviews where subview.isKind(of: UISearchBarTextFieldLabel) {
                    (subview as! UILabel).textColor = color
                }
    }
    func changeSearchBarTextColor(_ color: UIColor) {
        if let textField = self.value(forKey: "searchField") as? UITextField {
            textField.textColor = color
        }
    }
    func changeImageColor(_ color: UIColor) {
        if let textField = self.value(forKey: "searchField") as? UITextField {
            if let leftView = textField.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = color
            }
        }
    }
}
