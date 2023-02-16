////
////  ViewController.swift
////  Pokemon
////
////  Created by Parker Coelho on 11/5/22.
////
//
//import UIKit
//import PokemonAPI
//
//class PokemonViewController: UIViewController {
//    
//    // MARK: - Properties
//    var safeArea: UILayoutGuide {
//        return self.view.safeAreaLayoutGuide
//    }
//    var coordinator: MainCoordinator?
//    
//    // MARK: - LifeCycle Methods
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .clear
//        pokemonSearchBar.delegate = self
//        setUpView()
//        constrainViews()
//        makeIDTappable()
//        PokemonAPI().pokemonService.fetchPokemon("bulbasaur") { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let pokemon):
//                    self.pokemonName.text = pokemon.name ?? "Failed"
//                    guard let spriteUrl = URL(string: pokemon.sprites?.frontDefault ?? "failure") else {return}
//                    if let data = try? Data(contentsOf: spriteUrl) {
//                        self.pokemonImage.image = UIImage(data: data)
//                    }
//                    
//                    print(pokemon.types![0])
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        }
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(false)
//        
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = view.bounds
//        gradientLayer.colors = [UIColor.white.cgColor, UIColor(named: "TeaGreen")!.cgColor]
//        gradientLayer.zPosition = -1
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
//        
//        view.layer.addSublayer(gradientLayer)
//
//    }
//
//    
//    // MARK: - Helper methods
//    func fetchSpriteAndUpdateViews(pokemon: Pokemon) {
//        PokemonController.fetchPokemonSprite(pokemon: pokemon) { result in
//            DispatchQueue.main.async {
//                
//                switch result {
//                    
//                case .success(let fetchedPokemon):
//                    print(fetchedPokemon)
//                    self.pokemonImage.image = fetchedPokemon
//                    self.pokemonName.text = pokemon.name
//                    self.pokemonID.text = String(pokemon.id)
//                case .failure(let error):
//                    self.presentErrorToUser(localizedError: error as! LocalizedError)
//                }
//            }
//        }
//    }
//
//    
//    func setUpView() {
//        addAllSubViews()
//    }
//    func makeIDTappable() {
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(navToTeamBuilder))
//        pokemonID.isUserInteractionEnabled = true
//        pokemonID.addGestureRecognizer(tapGestureRecognizer)
//    }
//    
//    @objc func navToTeamBuilder() {
//        //        fetchTeamPokemonTest()
////        guard let name = pokemonName.text else {return}
////        PokemonController.fetchTeamPokemon
////        coordinator?.toTeamBuilder(pokemonToExamine: "pikachu")
//        coordinator?.toTeamManager()
//    }
//
//    func addAllSubViews() {
//        self.view.addSubview(pokemonSearchBar)
//        self.view.addSubview(pokemonImage)
//        self.view.addSubview(pokemonName)
//        self.view.addSubview(pokemonID)
//    }
//    func constrainViews() {
//        pokemonSearchBar.translatesAutoresizingMaskIntoConstraints = false
//        pokemonImage.translatesAutoresizingMaskIntoConstraints = false
//        pokemonName.translatesAutoresizingMaskIntoConstraints = false
//        pokemonID.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            pokemonSearchBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
//            pokemonSearchBar.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.1),
//            pokemonSearchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
//            pokemonSearchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
//            
//            pokemonImage.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
//            pokemonImage.topAnchor.constraint(equalTo: pokemonSearchBar.bottomAnchor),
//            pokemonImage.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.25),
//            pokemonImage.widthAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.25),
//            
//            pokemonName.topAnchor.constraint(equalTo: pokemonImage.bottomAnchor),
//            pokemonName.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
//            pokemonName.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
//            pokemonName.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.15),
//            
//            pokemonID.topAnchor.constraint(equalTo: pokemonName.bottomAnchor),
//            pokemonID.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
//            pokemonID.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
//            pokemonID.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
//        ])
//    }
//    // MARK: - UI Components
//    let pokemonSearchBar: UISearchBar = {
//        let searchBar = UISearchBar()
//        searchBar.backgroundColor = .clear
//        searchBar.tintColor = .clear
//        searchBar.barTintColor = UIColor(named: "BackgroundColor")
//        return searchBar
//    }()
//    let pokemonImage: UIImageView = {
//        let imageView = UIImageView()
//        return imageView
//    }()
//    let pokemonName: UILabel = {
//        let label = UILabel()
//        label.text = "Insert name here"
//        return label
//    }()
//    let pokemonID: UILabel = {
//        let label = UILabel()
//        label.text = "Pokemon ID here"
//        return label
//    }()
//}
//// MARK: - extensions
//
//extension PokemonViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let searchTerm = pokemonSearchBar.text, !searchTerm.isEmpty else {return}
//        
//        // here is where the original fetch takes place
//        
//        PokemonAPI().pokemonService.fetchPokemon(searchTerm.lowercased()) {result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let pokemon):
//                    self.pokemonName.text = pokemon.name ?? "Failed"
//                    guard let spriteUrl = URL(string: pokemon.sprites?.frontDefault ?? "failed URL for Sprite") else {return}
//                    if let data = try? Data(contentsOf: spriteUrl) {
//                        self.pokemonImage.image = UIImage(data: data)}
//                    guard let id = pokemon.id else {return}
//                    self.pokemonID.text = String(id)
//                case .failure(let error):
//                    print("Failed here")
//                    print(error)
//                }
//            }
//        }
////        PokemonController.fetchPokemonFromPoke(searchTerm: searchTerm) { result in
////            DispatchQueue.main.async {
////                switch result {
////
////                case .success(let pokemon):
////
////                    self.fetchSpriteAndUpdateViews(pokemon: pokemon)
////
////                case .failure(let error):
////                    print(error)
////                }
////            }
////        }
//    }
//}
