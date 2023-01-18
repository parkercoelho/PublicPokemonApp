//
//  UpperTeamCollectionViewCell.swift
//  Pokemon
//
//  Created by Parker Coelho on 12/20/22.
//

import UIKit

class UpperTeamCollectionViewCell: UICollectionViewCell {
        var delegate: TeamManagerViewController?
        
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
        
        func addImageToTeamCollectionView(pokemon: TeamPokemon){
            teamCollectionViewImage.image = pokemon.image
            contentView.addSubview(teamCollectionViewImage)
            NSLayoutConstraint.activate([
                teamCollectionViewImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
                teamCollectionViewImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
                teamCollectionViewImage.centerXAnchor.constraint(equalTo: centerXAnchor),
                teamCollectionViewImage.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
    func addNameLabelToTeamCollectionView(pokemon: TeamPokemon) {
        let label: UILabel = {
            let label = UILabel(statName: pokemon.name)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        contentView.addSubview(label)
    }
}
