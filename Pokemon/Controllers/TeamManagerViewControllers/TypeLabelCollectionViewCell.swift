//
//  TypeLabelCollectionViewCell.swift
//  Pokemon
//
//  Created by Parker Coelho on 12/2/22.
//

import UIKit

class TypeLabelCollectionViewCell: UICollectionViewCell {

    
    func setUpTypeLabelCell(){
        let typesStackView: UIStackView = {
            let stack = UIStackView()
            stack.contentMode = .scaleAspectFit
            stack.clipsToBounds = true
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            return stack
        }()
        
        self.addSubview(typesStackView)
        configureStackAndAddTypeCells(stack: typesStackView)
        print("configured type label stack")
        constrainTypeLabelCell(stack: typesStackView)
    }
    
    func configureStackAndAddTypeCells(stack: UIStackView) {
        TeamPokemon.PokemonTypeStrings.allCases.forEach { type in
            let label: UILabel = {
                let label = UILabel(statName: type.rawValue.uppercased())
                label.translatesAutoresizingMaskIntoConstraints = false
                label.font = UIFont(name: "ArialRoundedMTBold", size: 9)
                label.textColor = UIColor(named: "TypeCalcsGood")
                let gradientLayer = CAGradientLayer()
                gradientLayer.frame = label.bounds
                gradientLayer.colors = [UIColor.white.cgColor, UIColor.red.cgColor]
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
                label.layer.addSublayer(gradientLayer)
                return label
            }()
            stack.addSubview(label)
        }
    }
    func constrainTypeLabelCell(stack: UIStackView) {
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        stack.subviews.enumerated().forEach { (n, subView) in
            
            if n == 0 {
                NSLayoutConstraint.activate([
                    subView.topAnchor.constraint(equalTo: stack.topAnchor),
                    subView.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
                    subView.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
                    subView.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 1/18)
                ])
            } else {
                NSLayoutConstraint.activate([
                    subView.topAnchor.constraint(equalTo: stack.subviews[n-1].bottomAnchor),
                    subView.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
                    subView.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
                    subView.heightAnchor.constraint(equalTo: stack.subviews[0].heightAnchor)
                ])
            }
        }
    }
}
