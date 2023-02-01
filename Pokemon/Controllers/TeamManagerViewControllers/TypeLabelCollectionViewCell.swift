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
            let backgroundView: UIView = {
                let view = UIView()
                view.translatesAutoresizingMaskIntoConstraints = false
                view.layer.cornerRadius = 10
                view.layer.borderColor = UIColor(named: "BackgroundColor")!.cgColor
//                view.layer.borderWidth = 1
                return view
            }()
            let label: UILabel = {
                let label = UILabel(statName: type.rawValue.uppercased())
                label.translatesAutoresizingMaskIntoConstraints = false
                if self.frame.width < 40.0 {
                    label.font = UIFont(name: "ArialRoundedMTBold", size: 7)}
                else if self.frame.width > 40.0 {
                    label.font = UIFont(name: "ArialRoundedMTBold", size: 8)
                }
                label.textColor = .white
                if type == .normal {
                    label.textColor = UIColor(named: "TypeCalcsGood")
                }
                if type == .fairy {
                    label.textColor = UIColor(named: "TypeCalcsGood")

                }
                return label
            }()
            
            backgroundView.addSubview(label)
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
            ])
            label.textAlignment = .center
            
            stack.addSubview(backgroundView)
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
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = subView.frame
            gradientLayer.zPosition = -5
            gradientLayer.startPoint = CGPoint(x: subView.frame.origin.x, y: subView.frame.origin.y)
            print(gradientLayer.startPoint)
            gradientLayer.endPoint = CGPoint(x: subView.frame.origin.x + subView.frame.width, y: subView.frame.origin.y)
            
            print(gradientLayer.endPoint)
            gradientLayer.shouldRasterize = true
            print("The number is \(n)")
            
            switch n {
            case 0:
                subView.backgroundColor = UIColor(named: "TeaGreen")
            case 1:
                subView.backgroundColor = UIColor(named: "Fire")
            case 2:
                subView.backgroundColor = UIColor(named: "Water")
            case 3:
                subView.backgroundColor = UIColor(named: "Electric")
            case 4:
                subView.backgroundColor = UIColor(named: "Grass")
            case 5:
                subView.backgroundColor = UIColor(named: "Ice")
            case 6:
                subView.backgroundColor = UIColor(named: "Fighting")
            case 7:
                subView.backgroundColor = UIColor(named: "Poison")
            case 8:
                subView.backgroundColor = UIColor(named: "Ground")
            case 9:
                subView.backgroundColor = UIColor(named: "Flying")
            case 10:
                subView.backgroundColor = UIColor(named: "Psychic")
            case 11:
                subView.backgroundColor = UIColor(named: "Bug")
            case 12:
                subView.backgroundColor = UIColor(named: "Rock")
            case 13:
                subView.backgroundColor = UIColor(named: "Ghost")
            case 14:
                subView.backgroundColor = UIColor(named: "Dragon")
            case 15:
                subView.backgroundColor = UIColor(named: "Dark")
            case 16:
                subView.backgroundColor = UIColor(named: "Steel")
            case 17:
                subView.backgroundColor = UIColor(named: "Fairy")
            default:
                subView.backgroundColor = UIColor(named: "Normal")
            }
        }
    }
}
