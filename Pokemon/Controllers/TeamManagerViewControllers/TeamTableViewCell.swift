//
//  TeamTableViewCell.swift
//  Pokemon
//
//  Created by Parker Coelho on 12/20/22.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
    var delegate: TeamManagerViewController?
    
    let pokeBallImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "whitePokeBallImage")
        iv.backgroundColor = .clear
        return iv
    }()
    
    let pokemonNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = UIColor(named: "TypeCalcsGood")
        label.textAlignment = .center
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        contentView.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    func constrainCell() {
        contentView.addSubview(pokeBallImageView)
        
        NSLayoutConstraint.activate([
            pokeBallImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pokeBallImageView.heightAnchor.constraint(equalTo: heightAnchor),
            pokeBallImageView.widthAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    func configurePokemonNameLabel(pokemon: TeamPokemon) {
        pokemonNameLabel.text = pokemon.name
        contentView.addSubview(pokemonNameLabel)
        
        NSLayoutConstraint.activate([
            pokemonNameLabel.leadingAnchor.constraint(equalTo: pokeBallImageView.trailingAnchor, constant: 5),
            pokemonNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
            pokemonNameLabel.topAnchor.constraint(equalTo: topAnchor),
            pokemonNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
