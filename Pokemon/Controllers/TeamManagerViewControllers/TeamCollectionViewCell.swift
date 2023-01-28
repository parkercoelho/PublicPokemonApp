//
//  TeamCollectionViewCell.swift
//  Pokemon
//
//  Created by Parker Coelho on 11/23/22.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    var delegate: TeamManagerViewController?
    var teamsListDelegate: TeamsListTableViewCell?
    
    let teamCollectionViewImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "whitePokeBallImage")
        iv.backgroundColor = .clear
        return iv
    }()
    
    override func prepareForReuse() {
        contentView.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    func setUpUpperTeamCollectionViewCell(indexPath: IndexPath) {
        guard let delegate = delegate else {
            return
        }
        let team = delegate.team.pokemonOnTeam
        
        if indexPath.row > 0 && indexPath.row < team.count {
            addImageToTeamCollectionView(pokemon: team[indexPath.row])
        }
        else {
            contentView.addSubview(teamCollectionViewImage)
            NSLayoutConstraint.activate([
                teamCollectionViewImage.heightAnchor.constraint(equalTo: heightAnchor),
                teamCollectionViewImage.widthAnchor.constraint(equalTo: widthAnchor),
                teamCollectionViewImage.centerXAnchor.constraint(equalTo: centerXAnchor),
                teamCollectionViewImage.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
    }
    
    func setUpTeamsListTeamCollectionViewCell(indexPath: IndexPath) {
        guard let teamsListDelegate = teamsListDelegate else {
            return
        }
        guard let team = teamsListDelegate.team?.pokemonOnTeam else {return}
        
        if team.count > 0 {
            addImageToTeamCollectionView(pokemon: team[indexPath.row])
            
        }
    }
    
    func setUpTeamCollectionViewCell(indexPath: IndexPath) {
        guard let delegate = delegate else {
            return
        }
        let team = delegate.team.pokemonOnTeam
        
        if indexPath.row > 0 && indexPath.row <= team.count {
            addImageToTeamCollectionView(pokemon: team[indexPath.row-1])
        }
        
        else if indexPath.row > team.count && indexPath.row <= 6 {
            contentView.addSubview(teamCollectionViewImage)
            NSLayoutConstraint.activate([
                teamCollectionViewImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
                teamCollectionViewImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
                teamCollectionViewImage.centerXAnchor.constraint(equalTo: centerXAnchor),
                teamCollectionViewImage.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
        else if indexPath.row == 7 {
            let label: UILabel = {
                let label = UILabel(statName: "W")
                label.translatesAutoresizingMaskIntoConstraints = false
                label.textAlignment = .center
                return label
            }()
            contentView.addSubview(label)
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: topAnchor),
                label.bottomAnchor.constraint(equalTo: bottomAnchor),
                label.leadingAnchor.constraint(equalTo: leadingAnchor),
                label.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        }
        else if indexPath.row == 8 {
            let label: UILabel = {
                let label = UILabel(statName: "R")
                label.translatesAutoresizingMaskIntoConstraints = false
                label.textAlignment = .center
                return label
            }()
            contentView.addSubview(label)
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: topAnchor),
                label.bottomAnchor.constraint(equalTo: bottomAnchor),
                label.leadingAnchor.constraint(equalTo: leadingAnchor),
                label.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        }
    }
    func addImageToTeamCollectionView(pokemon: TeamPokemon){
        teamCollectionViewImage.image = pokemon.image
        contentView.addSubview(teamCollectionViewImage)
        NSLayoutConstraint.activate([
            teamCollectionViewImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1.0),
            teamCollectionViewImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0),
            teamCollectionViewImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            teamCollectionViewImage.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
