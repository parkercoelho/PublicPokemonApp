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
    var teamPokemon: TeamPokemon = TeamPokemon(name: "Squirtle", hp: 45, attack: 55, defense: 65, specialAttack: 75, specialDefense: 85, speed: 120, types: [.water], image: nil)
    
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
    var metaView: UIView = {
        let meta = UIView()
        meta.translatesAutoresizingMaskIntoConstraints = false
        meta.backgroundColor = .clear
        return meta
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
    let abilitiesLabel: UILabel = {
        let label = UILabel()
        label.text = "Abilities:"
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")
        label.font = UIFont(name: "American Typewriter Bold", size: 20)
        label.textAlignment = .center
        return label
    }()
    var abilitiesStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let abilitiesLabelOne: UILabel = {
        let label = UILabel(statName: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")!
        return label
    }()
    let abilitiesLabelContainerOne: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let abilitiesLabelContainerTwo: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let abilitiesLabelContainerThree: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let abilitiesLabelTwo: UILabel = {
        let label = UILabel(statName: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")!
        return label
    }()
    let abilitiesLabelThree: UILabel = {
        let label = UILabel(statName: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")!
        return label
    }()
    let typesLabel: UILabel = {
        let label = UILabel()
        label.text = "Types:"
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")
        label.font = UIFont(name: "American Typewriter Bold", size: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let newTypesStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let typeOneView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.cornerRadius = 10
        return view
    }()
    let typeTwoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        
        view.layer.cornerRadius = 10
        return view
    }()
    let typeLabelOne: UILabel = {
        let label = UILabel(statName: "Type 1")
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ArialRoundedMTBold", size: 12)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let typeLabelTwo: UILabel = {
        let label = UILabel(statName: "Type 2")
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ArialRoundedMTBold", size: 12)
        label.adjustsFontSizeToFitWidth = true
        return label
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
    let hpLabel: UILabel = {
        let label = UILabel(statName: "HP")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")
        return label
    }()
    let attackLabel: UILabel = {
        let label = UILabel(statName: "Att")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")
        return label
    }()
    let defenseLabel: UILabel = {
        let label = UILabel(statName: "Def")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")
        return label
    }()
    let specialAttackLabel: UILabel = {
        let label = UILabel(statName: "Sp. Att")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")
        return label
    }()
    let specialDefenseLabel: UILabel = {
        let label = UILabel(statName: "Sp. Def")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")
        return label
    }()
    let speedLabel: UILabel = {
        let label = UILabel(statName: "Spe")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")
        return label
    }()
    let addToTeamButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "TypeCalcsDarkGreen")
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 3
        button.setTitle("Add to team", for: .normal)
        button.setTitle("Added!", for: .selected)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    var hpInt: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")
        return label
    }()
    var attackInt: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")
        return label
    }()
    var defenseInt: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")
        return label
    }()
    var specialAttackInt: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")
        return label
    }()
    var specialDefenseInt: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")
        return label
    }()
    var speedInt: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")
        return label
    }()
    
    let testContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isHidden = false
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
        reconfigureStatStacks(for: teamPokemon)
    }
    override func viewDidAppear(_ animated: Bool) {
        searchBar.changePlaceholderColor(UIColor(named: "TypeCalcsDarkGreen")!)
        searchBar.changeSearchBarTextColor(UIColor(named: "TypeCalcsDarkGreen")!)
        searchBar.changeImageColor(UIColor(named: "TypeCalcsDarkGreen")!)
    }
    
    // MARK: - UI Functions
    func setUpView() {
        addAllViews()
        configureTableView()
        configureCollectionView()
        configureSearchBar()
        configureMetaView()
        configureStatStackView()
        configureIndividualStatStack(for: hpStack, stat: hpLabel, statInt: hpInt)
        configureIndividualStatStack(for: attackStack, stat: attackLabel, statInt: attackInt)
        configureIndividualStatStack(for: defenseStack, stat: defenseLabel, statInt: defenseInt)
        configureIndividualStatStack(for: specialAttackStack, stat: specialAttackLabel, statInt: specialAttackInt)
        configureIndividualStatStack(for: specialDefenseStack, stat: specialDefenseLabel, statInt: specialDefenseInt)
        configureIndividualStatStack(for: speedStack, stat: speedLabel, statInt: speedInt)

        updateTeamPokemonViews(teamPokemon: teamPokemon)
    }
    func addAllViews() {
        self.view.addSubview(searchBar)
        self.view.addSubview(searchSuggestionsTableView)
        testContainerView.addSubview(pokemonNameLabel)
        testContainerView.addSubview(pokemonImageView)
        testContainerView.addSubview(metaView)
        testContainerView.addSubview(statsStack)
        testContainerView.addSubview(teamCollectionView)
        self.view.addSubview(addToTeamButton)
        view.addSubview(testContainerView)
        
        
    }
    func updateTeamPokemonViews(teamPokemon: TeamPokemon) {
        pokemonImageView.image = teamPokemon.image
        pokemonNameLabel.text = teamPokemon.name.capitalized
        
        teamPokemon.abilities.enumerated().forEach { (n, abilityName) in
            switch n {
            case 0:
                abilitiesLabelOne.text = abilityName
            case 1:
                abilitiesLabelTwo.text = abilityName
            case 2:
                abilitiesLabelThree.text = abilityName
            default:
                print("Error adding abilities to ability stack view")
            }
        }
        createTypeViews(teamPokemon: teamPokemon)
        reconfigureStatStacks(for: teamPokemon)
    }
    
    @objc func addPokemonToDelegateTeam() {
        print("Button tapped")
        if teamPokemon.name == "Squirtle", teamPokemon.speed == 120 {
            // this will ensure they don't add the fake initial pokemon
            print("Please search for a pokemon")
        } else if delegate!.team.pokemonOnTeam.count == 6 {
            let modal = PopUpView(frame: self.view.frame, title: "Whoops!", message: "Your team is already full. Please remove a Pokemon before adding another.")
            self.view.addSubview(modal)
            modal.animateIn()
        }
        else {
        if let delegate = delegate {
            if let bigDelegate = delegate.delegate {
                PersistenceFunctions.addPokemonToTeam(teams: bigDelegate.teams, team: delegate.team, newPokemon: teamPokemon)
                delegate.teamTableView.visibleCells.forEach { cell in
                    cell.contentView.subviews.forEach { view in
                        view.removeFromSuperview()
                    }
                }
                delegate.teamTableView.reloadData()
                delegate.teamCollectionView.reloadData()
                delegate.typeCollectionView.reloadData()
            }
            navigationController?.popViewController(animated: true)
        }
            print("pokemon added")}
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
        hpInt.text = "\(pokemon.hp) "
        attackInt.text = "\(pokemon.attack) "
        defenseInt.text = "\(pokemon.defense) "
        specialAttackInt.text = "\(pokemon.specialAttack) "
        specialDefenseInt.text = "\(pokemon.specialDefense) "
        speedInt.text = "\(pokemon.speed) "
        
        hpStack.arrangedSubviews[2].updateBarColor(on: pokemon.hp)
        attackStack.arrangedSubviews[2].updateBarColor(on: pokemon.attack)
        defenseStack.arrangedSubviews[2].updateBarColor(on: pokemon.defense)
        specialAttackStack.arrangedSubviews[2].updateBarColor(on: pokemon.specialAttack)
        specialDefenseStack.arrangedSubviews[2].updateBarColor(on: pokemon.specialDefense)
        speedStack.arrangedSubviews[2].updateBarColor(on: pokemon.speed)
        
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
    
    func configureIndividualStatStack(for stack: UIStackView, stat: UILabel, statInt: UILabel) {
        stack.addArrangedSubview(stat)
        let barViewContainer = UIView()
        barViewContainer.layer.cornerRadius = 10
        barViewContainer.layer.masksToBounds = true
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(statInt)
        stack.addArrangedSubview(barViewContainer)
        NSLayoutConstraint.activate([
            // instead of making the constant below 50, it should be a variable dependent on phone type
            statInt.leadingAnchor.constraint(equalTo: stat.trailingAnchor),
            statInt.trailingAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: -50),
            barViewContainer.leadingAnchor.constraint(equalTo: statInt.trailingAnchor, constant: 50)])
        
        switch stat.text {
        case "HP":
            barViewContainer.updateBarColor(on: teamPokemon.hp)
            statInt.text = "\(teamPokemon.hp) "
            hpWidthAnchor = barViewContainer.widthAnchor.constraint(equalToConstant: CGFloat(teamPokemon.hp))
            updateBarWidth(widthAnchor: hpWidthAnchor, stat: CGFloat(teamPokemon.hp))

        case "Att":
            barViewContainer.updateBarColor(on: teamPokemon.attack)
            statInt.text = "\(teamPokemon.attack) "
            attackWidthAnchor = barViewContainer.widthAnchor.constraint(equalToConstant: CGFloat(teamPokemon.attack))
            updateBarWidth(widthAnchor: attackWidthAnchor, stat: CGFloat(teamPokemon.attack))
        case "Def":
            barViewContainer.updateBarColor(on: teamPokemon.defense)
            statInt.text = "\(teamPokemon.defense) "
            defenseWidthAnchor = barViewContainer.widthAnchor.constraint(equalToConstant: CGFloat(teamPokemon.defense))
            updateBarWidth(widthAnchor: defenseWidthAnchor, stat: CGFloat(teamPokemon.defense))
        case "Sp. Att":
            barViewContainer.updateBarColor(on: teamPokemon.specialAttack)
            statInt.text = "\(teamPokemon.specialAttack) "
            specialAttackWidthAnchor = barViewContainer.widthAnchor.constraint(equalToConstant: CGFloat(teamPokemon.specialAttack))
            updateBarWidth(widthAnchor: specialAttackWidthAnchor, stat: CGFloat(teamPokemon.specialAttack))
        case "Sp. Def":
            barViewContainer.updateBarColor(on: teamPokemon.specialDefense)
            statInt.text = "\(teamPokemon.specialDefense) "
            specialDefenseWidthAnchor = barViewContainer.widthAnchor.constraint(equalToConstant: CGFloat(teamPokemon.specialDefense))
            updateBarWidth(widthAnchor: specialDefenseWidthAnchor, stat: CGFloat(teamPokemon.specialDefense))
        case "Spe":
            barViewContainer.updateBarColor(on: teamPokemon.speed)
            statInt.text = "\(teamPokemon.speed) "
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
    func configureMetaView() {
        metaView.addSubview(abilitiesLabel)
        metaView.addSubview(abilitiesStackView)
        metaView.addSubview(typesLabel)
        metaView.addSubview(newTypesStack)
        configureAbilitiesStackView()
        configureTypeStackView()
        abilitiesLabel.translatesAutoresizingMaskIntoConstraints = false
        abilitiesStackView.translatesAutoresizingMaskIntoConstraints = false
        typesLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    func configureAbilitiesStackView() {
        abilitiesStackView.alignment = .center
        abilitiesStackView.axis = .vertical
        abilitiesStackView.distribution = .fillEqually
        abilitiesStackView.addArrangedSubview(abilitiesLabelContainerOne)
        abilitiesLabelContainerOne.addSubview(abilitiesLabelOne)
        abilitiesStackView.addArrangedSubview(abilitiesLabelContainerTwo)
        abilitiesLabelContainerTwo.addSubview(abilitiesLabelTwo)
        abilitiesStackView.addArrangedSubview(abilitiesLabelContainerThree)
        abilitiesLabelContainerThree.addSubview(abilitiesLabelThree)
    }
    func configureTypeStackView() {
        newTypesStack.distribution = . fillEqually
        newTypesStack.addArrangedSubview(typeOneView)
        typeOneView.addSubview(typeLabelOne)
        newTypesStack.addArrangedSubview(typeTwoView)
        typeTwoView.addSubview(typeLabelTwo)
    }
    func constrainAbilitiesStackView() {
        NSLayoutConstraint.activate([
            // Container leading anchors matching stack's leading anchor
            abilitiesLabelContainerOne.leadingAnchor.constraint(equalTo: abilitiesStackView.leadingAnchor),
            abilitiesLabelContainerTwo.leadingAnchor.constraint(equalTo: abilitiesStackView.leadingAnchor),
            abilitiesLabelContainerThree.leadingAnchor.constraint(equalTo: abilitiesStackView.leadingAnchor),
            // Container trailing matching stack's trailing
            abilitiesLabelContainerOne.trailingAnchor.constraint(equalTo: abilitiesStackView.trailingAnchor),
            abilitiesLabelContainerTwo.trailingAnchor.constraint(equalTo: abilitiesStackView.trailingAnchor),
            abilitiesLabelContainerThree.trailingAnchor.constraint(equalTo: abilitiesStackView.trailingAnchor),
            // Labels leading matching stack's leading
            abilitiesLabelOne.leadingAnchor.constraint(equalTo: abilitiesStackView.leadingAnchor),
            abilitiesLabelTwo.leadingAnchor.constraint(equalTo: abilitiesStackView.leadingAnchor),
            abilitiesLabelThree.leadingAnchor.constraint(equalTo: abilitiesStackView.leadingAnchor),
            // Labels trailing matching stack's trailing
            abilitiesLabelOne.trailingAnchor.constraint(equalTo: abilitiesStackView.trailingAnchor),
            abilitiesLabelOne.trailingAnchor.constraint(equalTo: abilitiesStackView.trailingAnchor),
            abilitiesLabelOne.trailingAnchor.constraint(equalTo: abilitiesStackView.trailingAnchor),
            
            abilitiesLabelTwo.trailingAnchor.constraint(equalTo: abilitiesStackView.trailingAnchor),
            abilitiesLabelTwo.trailingAnchor.constraint(equalTo: abilitiesStackView.trailingAnchor),
            abilitiesLabelTwo.trailingAnchor.constraint(equalTo: abilitiesStackView.trailingAnchor),

            abilitiesLabelThree.trailingAnchor.constraint(equalTo: abilitiesStackView.trailingAnchor),
            abilitiesLabelThree.trailingAnchor.constraint(equalTo: abilitiesStackView.trailingAnchor),
            abilitiesLabelThree.trailingAnchor.constraint(equalTo: abilitiesStackView.trailingAnchor),

            // One's top anchor
            abilitiesLabelContainerOne.topAnchor.constraint(equalTo: abilitiesStackView.topAnchor),
            abilitiesLabelOne.topAnchor.constraint(equalTo: abilitiesLabelContainerOne.topAnchor),
            abilitiesLabelContainerOne.heightAnchor.constraint(equalTo: abilitiesStackView.heightAnchor,multiplier: 1/3),
            // Two's top anchor
            abilitiesLabelContainerTwo.topAnchor.constraint(equalTo: abilitiesLabelContainerOne.bottomAnchor),
            abilitiesLabelTwo.topAnchor.constraint(equalTo: abilitiesLabelContainerTwo.topAnchor),
            // Three's top anchor
            abilitiesLabelContainerThree.topAnchor.constraint(equalTo: abilitiesLabelContainerTwo.bottomAnchor),
            abilitiesLabelThree.topAnchor.constraint(equalTo: abilitiesLabelContainerThree.topAnchor),

            abilitiesLabelContainerThree.bottomAnchor.constraint(equalTo: abilitiesStackView.bottomAnchor)
        ])
    }
    func constrainTypeStackView() {
        NSLayoutConstraint.activate([
            typeOneView.leadingAnchor.constraint(equalTo: newTypesStack.leadingAnchor),
            typeOneView.trailingAnchor.constraint(equalTo: newTypesStack.centerXAnchor, constant: 1),
            typeOneView.topAnchor.constraint(equalTo: newTypesStack.topAnchor),
            typeOneView.bottomAnchor.constraint(equalTo: newTypesStack.bottomAnchor, constant: 5),
            
            typeLabelOne.leadingAnchor.constraint(equalTo: typeOneView.leadingAnchor),
            typeLabelOne.trailingAnchor.constraint(equalTo: typeOneView.trailingAnchor),
            typeLabelOne.topAnchor.constraint(equalTo: typeOneView.topAnchor),
            typeLabelOne.bottomAnchor.constraint(equalTo: typeOneView.bottomAnchor),
            
            typeTwoView.leadingAnchor.constraint(equalTo: newTypesStack.centerXAnchor, constant: 1),
            typeTwoView.trailingAnchor.constraint(equalTo: newTypesStack.trailingAnchor, constant: 5),
            typeTwoView.topAnchor.constraint(equalTo: newTypesStack.topAnchor),
            typeTwoView.bottomAnchor.constraint(equalTo: newTypesStack.bottomAnchor),
            
            typeLabelTwo.leadingAnchor.constraint(equalTo: typeTwoView.leadingAnchor),
            typeLabelTwo.trailingAnchor.constraint(equalTo: typeTwoView.trailingAnchor),
            typeLabelTwo.topAnchor.constraint(equalTo: typeTwoView.topAnchor),
            typeLabelTwo.bottomAnchor.constraint(equalTo: typeTwoView.bottomAnchor),
        ])
    }
    func createTypeViews(teamPokemon: TeamPokemon) {
        teamPokemon.types.enumerated().forEach { (n, type) in
            var newColor: UIColor = .clear
            var textColor: UIColor = .white
            var typeName: String = ""
            switch type {
            case .normal:
                newColor = UIColor(named: "Normal")!
                textColor = UIColor(named: "TypeCalcsGood")!
                typeName = "Normal"
            case .fire:
                newColor = UIColor(named: "Fire")!
                typeName = "Fire"
            case .water:
                newColor = UIColor(named: "Water")!
                typeName = "Water"
            case .electric:
                typeName = "Electric"
                newColor = UIColor(named: "Electric")!
            case .grass:
                typeName = "Grass"
                newColor = UIColor(named: "Grass")!
            case .ice:
                typeName = "Ice"
                newColor = UIColor(named: "Ice")!
            case .fighting:
                typeName = "Fighting"
                newColor = UIColor(named: "Fighting")!
            case .poison:
                typeName = "Poison"
                newColor = UIColor(named: "Poison")!
            case .ground:
                typeName = "Ground"
                newColor = UIColor(named: "Ground")!
            case .flying:
                typeName = "Flying"
                newColor = UIColor(named: "Flying")!
            case .psychic:
                typeName = "Psychic"
                newColor = UIColor(named: "Psychic")!
            case .bug:
                typeName = "Bug"
                newColor = UIColor(named: "Bug")!
            case .rock:
                typeName = "Rock"
                newColor = UIColor(named: "Rock")!
            case .ghost:
                typeName = "Ghost"
                newColor = UIColor(named: "Ghost")!
            case .dragon:
                typeName = "Dragon"
                newColor = UIColor(named: "Dragon")!
            case .dark:
                typeName = "Dark"
                newColor = UIColor(named: "Dark")!
            case .steel:
                typeName = "Steel"
                newColor = UIColor(named: "Steel")!
            case .fairy:
                typeName = "Fairy"
                newColor = UIColor(named: "Fairy")!
                textColor = UIColor(named: "TypeCalcsGood")!
            }
            if n == 0 {
                typeOneView.backgroundColor = newColor
                typeLabelOne.textColor = textColor
                typeTwoView.backgroundColor = .clear
                typeLabelTwo.textColor = .clear
                typeLabelOne.text = typeName.uppercased()
            }
            else if n == 1 {
                typeTwoView.backgroundColor = newColor
                typeLabelTwo.textColor = textColor
                typeLabelTwo.text = typeName.uppercased()
            }
        }
    }
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
        
        metaView.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor),
        metaView.topAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor),
        metaView.bottomAnchor.constraint(equalTo: pokemonImageView.bottomAnchor),
        metaView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -5),

        abilitiesLabel.leadingAnchor.constraint(equalTo: metaView.leadingAnchor),
        abilitiesLabel.trailingAnchor.constraint(equalTo: metaView.trailingAnchor),
        abilitiesLabel.topAnchor.constraint(equalTo: metaView.topAnchor),
        
        abilitiesStackView.topAnchor.constraint(equalTo: abilitiesLabel.bottomAnchor),
        abilitiesStackView.bottomAnchor.constraint(equalTo: metaView.centerYAnchor),
        abilitiesStackView.leadingAnchor.constraint(equalTo: metaView.leadingAnchor),
        abilitiesStackView.trailingAnchor.constraint(equalTo: metaView.trailingAnchor),
        
        typesLabel.topAnchor.constraint(equalTo: metaView.centerYAnchor, constant: 5),
        typesLabel.leadingAnchor.constraint(equalTo: metaView.leadingAnchor),
        typesLabel.trailingAnchor.constraint(equalTo: metaView.trailingAnchor),
        
        newTypesStack.leadingAnchor.constraint(equalTo: metaView.leadingAnchor),
        newTypesStack.trailingAnchor.constraint(equalTo: metaView.trailingAnchor),
        newTypesStack.topAnchor.constraint(equalTo: typesLabel.bottomAnchor, constant: 5),
        newTypesStack.heightAnchor.constraint(equalToConstant: 40),
        
        statsStack.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 15),
        statsStack.leadingAnchor.constraint(equalTo: pokemonImageView.leadingAnchor, constant: 10),
        statsStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        statsStack.heightAnchor.constraint(equalTo: pokemonImageView.heightAnchor),
        
        addToTeamButton.topAnchor.constraint(equalTo: statsStack.bottomAnchor, constant: 25),
        addToTeamButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
        addToTeamButton.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.42),
        addToTeamButton.heightAnchor.constraint(equalTo: statsStack.heightAnchor, multiplier: 0.33)
                ])
    constrainAbilitiesStackView()
    constrainTypeStackView()
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
    
    convenience init(pokemon: TeamPokemon) {
        self.init()
        self.teamPokemon = pokemon
    }
}

    // MARK: - Extensions


extension TeamBuilderViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //
        teamCollectionView.isHidden = true
        testContainerView.isHidden = true
        searchSuggestionsTableView.isHidden = true
        searchSuggestionsTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("clicked")
        guard let text = searchBar.text else {return}
        searchBar.resignFirstResponder()
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
                if text.lowercased().contains("hisu") {
                    let modal = PopUpView(frame: self.view.frame, title: "Searching Hisui?", message: "Check your spelling. For example, search like this: Goodra-hisui")
                    self.view.addSubview(modal)
                    modal.animateIn()
                }
                else if text.lowercased().contains("alol") {
                    let modal = PopUpView(frame: self.view.frame, title: "Searching Alola?", message: "Check your spelling. For example, search like this: Ninetales-alola")
                    self.view.addSubview(modal)
                    modal.animateIn()
                }
                else {
                    let modal = PopUpView(frame: self.view.frame, title: "Whoops!", message: "No Pokemon was found. Please double check your spelling")
                    self.view.addSubview(modal)
                    modal.animateIn()

                }
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
            self.backgroundColor = UIColor(named: "Fire")
        }
        else if stat < 85 {
            self.backgroundColor = UIColor(named: "AlertRed")
        }
        else if stat < 105 {
            self.backgroundColor = UIColor(named: "Electric")
        }
        else if stat < 130 {
            self.backgroundColor = UIColor(named: "Grass")
        }
        else {
            self.backgroundColor = UIColor(named: "Ice")
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
