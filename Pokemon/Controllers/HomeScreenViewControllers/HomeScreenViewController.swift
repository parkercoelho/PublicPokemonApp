//
//  HomeScreenViewController.swift
//  Pokemon
//
//  Created by Parker Coelho on 12/21/22.
//

import UIKit
import PokemonAPI

class HomeScreenViewController: UIViewController {
    // MARK: - Properties

    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    var coordinator: MainCoordinator?
    var goImageSize: CGSize = CGSize(width: 40.0, height: 40.0)
    var compImageSize: CGSize = CGSize(width: 60.0, height: 60.0)
    var teams: [Team] = []
    

    // MARK: - UI Components
    let titleLabel: UILabel = {
        let label = UILabel(statName: "Draft League Team Builder")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")
        label.font = UIFont(name: "American Typewriter Bold", size: 36)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    let teamManagerButton: HomeScreenStackView = {
        let button = HomeScreenStackView(title: "Competitive Teams", image: .add)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.button.addTarget(self, action: #selector(navToTeamsList), for: .touchUpInside)
        return button
    }()
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    let competitiveBattleImage: UIImageView = {
        let trophyConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .large)
        let darkGreen = UIColor(named: "TypeCalcsDarkGreen")
        let image = UIImage(systemName: "trophy.circle", withConfiguration: trophyConfig)?.withTintColor(darkGreen!, renderingMode: .alwaysOriginal)
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = image?.withTintColor(UIColor(named: "TypeCalcsDarkGreen")!)
        return iv
    }()
    let competitiveBattleLabel: UILabel = {
    let label = UILabel(statName: "Competitive")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")
        label.font = UIFont(name: "American Typewriter Bold", size: 16)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    let pokemonGoBattleImage: UIImageView = {
        let darkGreen = UIColor(named: "TypeCalcsDarkGreen")
        let goConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .large)
        let image = UIImage(systemName: "point.3.connected.trianglepath.dotted", withConfiguration: goConfig)?.withTintColor(darkGreen!, renderingMode: .alwaysOriginal)
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = image
        return iv
    }()
    let pokemonGoBattleLabel: UILabel = {
        let label = UILabel(statName: "Go! ")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")
        label.font = UIFont(name: "American Typewriter Bold", size: 16)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        resizeImages()
        addAllSubviews()
        constrainViews()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor(named: "TeaGreen")!.cgColor]
        gradientLayer.zPosition = -2
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        view.layer.addSublayer(gradientLayer)
        makePoGoTappable()
        Task {
            do {
                try await initializeFromPersistedData(pokemon: PersistenceFunctions.loadTeamDictionaries())
                print(teams)
                makeTeamTappable()

                //I could display the button to proceed to the teams here because then user can only tap it once everything has been loaded
            } catch {
                print("error initializing data \(error)")
            }
        }

        print("View did load on home screen")


    }
    
    // MARK: - Functions
    func constrainViews() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 25),
            
            pokemonGoBattleLabel.topAnchor.constraint(equalTo: safeArea.centerYAnchor),
            pokemonGoBattleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 25),
            pokemonGoBattleLabel.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.30),
            
            pokemonGoBattleImage.topAnchor.constraint(equalTo: pokemonGoBattleLabel.bottomAnchor, constant: 10),
            pokemonGoBattleImage.leadingAnchor.constraint(equalTo: pokemonGoBattleLabel.leadingAnchor),
            pokemonGoBattleImage.widthAnchor.constraint(equalTo: pokemonGoBattleLabel.widthAnchor),

            competitiveBattleLabel.topAnchor.constraint(equalTo: pokemonGoBattleLabel.topAnchor),
            competitiveBattleLabel.leadingAnchor.constraint(equalTo: pokemonGoBattleLabel.trailingAnchor, constant: 30),
            competitiveBattleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 30),
            
            competitiveBattleImage.centerYAnchor.constraint(equalTo: pokemonGoBattleImage.centerYAnchor),
            competitiveBattleImage.centerXAnchor.constraint(equalTo: competitiveBattleLabel.centerXAnchor),
        ])
    }
    func resizeImages() {
        let newGoImage = resizeImage(image: pokemonGoBattleImage.image ?? .strokedCheckmark, targetSize: goImageSize)
        pokemonGoBattleImage.image = newGoImage
        
        let newCompImage = resizeImage(image: competitiveBattleImage.image ?? .strokedCheckmark, targetSize: compImageSize)
        competitiveBattleImage.image = newCompImage
    }
    func addAllSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(pokemonGoBattleLabel)
        view.addSubview(competitiveBattleLabel)
        view.addSubview(pokemonGoBattleImage)
        view.addSubview(competitiveBattleImage)
        view.addSubview(containerView)
//        view.addSubview(teamManagerButton)
    }
    func makeTeamTappable() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(navToTeamsList))
        competitiveBattleImage.isUserInteractionEnabled = true
        competitiveBattleImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func makePoGoTappable() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentModal))
        pokemonGoBattleImage.isUserInteractionEnabled = true
        pokemonGoBattleImage.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func presentModal() {
        let modal = PopUpView(frame: self.view.frame, title: "Coming Soon!", message: "We hope to build out a team builder for Pokemon Go in the future!")
        modal.animateIn()
        view.addSubview(modal)
    }

    // MARK: - Navigation

     @objc func navToTeamsList() {
         coordinator?.toTeamsList(teams: teams, delegate: self)
     }
    
    // MARK: - Other functions
    func initializeFromPersistedData(pokemon: [String: [String]]) async throws -> Void {
        for (key, value) in pokemon {
            
            let teamToAdd: Team = Team(team: [], teamName: key)
            for pokemonName in value {
                
                    let fetchedPokemon: TeamPokemon = try await withCheckedThrowingContinuation { continuation in
                        
                        PokemonAPI().pokemonService.fetchPokemon(pokemonName.lowercased()) { result in
                            switch result {
                            case .success(let pokemon):
                                guard let fetchedPokemon = TeamPokemon(pokemon: pokemon) else {return}
                                continuation.resume(returning: fetchedPokemon)
                            case .failure(let error):
                                print(error)
                                continuation.resume(throwing: error)
                            }
                        }
                    }
                teamToAdd.pokemonOnTeam.append(fetchedPokemon)
            }
            self.teams.append(teamToAdd)
            self.teams.sort { team1, team2 in
                team1.teamName < team2.teamName
            }
        }
    }
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

}
