//
//  TypeChartCollectionViewCell.swift
//  Pokemon
//
//  Created by Parker Coelho on 11/30/22.
//

import UIKit

class TypeChartCalculationCollectionViewCell: UICollectionViewCell {
    var delegate: TeamManagerViewController?
    
    static var teamWeaknesses: [Double] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    static var teamResistances: [Double] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

    override func prepareForReuse() {
        contentView.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    let red = UIColor(named: "AlertRed")
    let green = UIColor(named: "TypeCalcsGood")
    let darkGreen = UIColor(named: "TypeCalcsDarkGreen")
    
    func setUpCell(at indexPath: IndexPath) {
        guard let delegate = delegate else {
            return
        }
        
        let pokemonTypeChartStackView: UIStackView = {
            let stack = UIStackView()
            stack.contentMode = .scaleAspectFit
            stack.clipsToBounds = true
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.layer.borderWidth = 1
            stack.layer.borderColor = UIColor(named: "TeaGreen")?.cgColor
            stack.layer.cornerRadius = 10.0
            return stack
        }()
        if indexPath.row <= delegate.team.pokemonOnTeam.count {
        configureAndAddCalculationsStacks(stack: pokemonTypeChartStackView, indexPath: indexPath)
        contentView.addSubview(pokemonTypeChartStackView)
            constrainCalculationsStackSubViews(stack: pokemonTypeChartStackView)
        }
        else if indexPath.row > delegate.team.pokemonOnTeam.count {
            configureEmptyStack(stack: pokemonTypeChartStackView, indexPath: indexPath)
            contentView.addSubview(pokemonTypeChartStackView)
            constrainCalculationsStackSubViews(stack: pokemonTypeChartStackView)
        }
    }
    
    func setUpSumCell(at indexPath: IndexPath) {
        
        guard let delegate = delegate else {
            return
        }
        
        let pokemonTypeChartStackView: UIStackView = {
            let stack = UIStackView()
            stack.contentMode = .scaleAspectFit
            stack.clipsToBounds = true
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.layer.borderWidth = 1
            stack.layer.borderColor = UIColor(named: "TeaGreen")?.cgColor
            stack.layer.cornerRadius = 10.0
            return stack
        }()
        
        if indexPath.row == 7 {
            configureSumsStackViews(for: pokemonTypeChartStackView, weaknessOrResistance: delegate.team.teamWeaknesses)
            print("added weaknesses")
            contentView.addSubview(pokemonTypeChartStackView)
            constrainCalculationsStackSubViews(stack: pokemonTypeChartStackView)
        }
        else if indexPath.row == 8 {
            configureSumsStackViews(for: pokemonTypeChartStackView, weaknessOrResistance: delegate.team.teamResistances)
            print("added resistances")
            contentView.addSubview(pokemonTypeChartStackView)
            constrainCalculationsStackSubViews(stack: pokemonTypeChartStackView)
        }
    }
    
    func configureEmptyStack(stack: UIStackView, indexPath: IndexPath) {
        TypeChartCalculationCollectionViewCell.teamWeaknesses.enumerated().forEach { (n, calc) in
            let emptyLabel: UILabel = {
                let label = UILabel(statName: " ")
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            
            setUpLabel(number: n, label: emptyLabel, stack: stack, textColor: .black)
        }
    }
    
    func configureAndAddCalculationsStacks(stack: UIStackView, indexPath: IndexPath) {
        guard let teamPokemon = delegate?.team.pokemonOnTeam[indexPath.row-1] else {return}
                                                    
        teamPokemon.typeDamageMultiples.enumerated().forEach { (n, calc) in
                    switch calc {
                    case 0:
                        let label: UILabel = {
                            let label = UILabel(statName: "--")
                            label.translatesAutoresizingMaskIntoConstraints = false
                            return label
                        }()
                        setUpLabel(number: n, label: label, stack: stack, textColor: darkGreen)
                    case 0.25:
                        let label: UILabel = {
                            let label = UILabel(statName: "1/4")
                            label.translatesAutoresizingMaskIntoConstraints = false
                            return label
                        }()
                        setUpLabel(number: n, label: label, stack: stack, textColor: darkGreen)
                    case 0.5:
                        let label: UILabel = {
                            let label = UILabel(statName: "1/2")
                            label.translatesAutoresizingMaskIntoConstraints = false
                            return label
                        }()
                        setUpLabel(number: n, label: label, stack: stack, textColor: darkGreen)
                    case 2:
                        let label: UILabel = {
                            let label = UILabel(statName: "2X")
                            label.translatesAutoresizingMaskIntoConstraints = false
                            return label
                        }()
                        setUpLabel(number: n, label: label, stack: stack, textColor: red)
                    case 4:
                        let label: UILabel = {
                            let label = UILabel(statName: "4X")
                            label.translatesAutoresizingMaskIntoConstraints = false
                            return label
                        }()
                        setUpLabel(number: n, label: label, stack: stack, textColor: red)
                    default:
                        let label: UILabel = {
                            let label = UILabel(statName: "")
                            label.translatesAutoresizingMaskIntoConstraints = false
                            return label
                        }()
                        setUpLabel(number: n, label: label, stack: stack, textColor: nil)
                    }
                }
        
    }
    
    func setUpLabel(number: Int, label: UILabel, stack: UIStackView, textColor: UIColor?) {
        if number % 2 != 0 {
            label.backgroundColor = UIColor(named: "BackgroundColor")
        }
        else {
            label.backgroundColor = UIColor(named: "TypeCollectionViewRow")
        }
        label.textAlignment = .center
        label.textColor = textColor
        stack.addSubview(label)
    }
    
    // I may be able to use a switch on the forEach in adding the labels with the default being the Double, and the specified cases being 0, also could add background colors in switch
    func configureSumsStackViews(for stack: UIStackView, weaknessOrResistance: [Double]) {
        weaknessOrResistance.enumerated().forEach { (n, double) in
            let label: UILabel = {
                let label = UILabel(statName: String(Int(double)))
                label.translatesAutoresizingMaskIntoConstraints = false
                label.layer.cornerRadius = 10
                label.textColor = UIColor(named: "TypeCalcsGood")
                label.clipsToBounds = true
                return label
            }()
            setUpLabel(number: n, label: label, stack: stack, textColor: UIColor(named: "TypeCalcsDarkGreen"))
            if Int(label.text!) ?? 0 > 2 && Int(label.text!) ?? 0 < 4 {
                if weaknessOrResistance == self.delegate!.team.teamResistances {
                    label.backgroundColor = UIColor(named: "TypeCalcsGood")
                }
                else {label.backgroundColor = UIColor(named: "AlertRed") }
            }
            else if Int(label.text!) ?? 0 >= 4 {
                if weaknessOrResistance == self.delegate!.team.teamResistances {
                    label.backgroundColor = UIColor(named: "TypeCalcsDarkGreen")
                    label.textColor = .white
                }
                else {label.backgroundColor = UIColor(named: "TypeCalcsRed")
                    label.textColor = .white
                }
            }

        }
    }
    
    func constrainCalculationsStackSubViews(stack: UIStackView) {
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)])
        
        stack.subviews.enumerated().forEach { (n, view) in
            if n == 0 {
                NSLayoutConstraint.activate([view.topAnchor.constraint(equalTo: stack.topAnchor),
                                             view.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
                                             view.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
                                             view.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 1/18)])
            }
            else {
                NSLayoutConstraint.activate([
                    view.topAnchor.constraint(equalTo: stack.subviews[n-1].bottomAnchor),
                    view.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
                    view.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
                    view.heightAnchor.constraint(equalTo: stack.subviews[0].heightAnchor)
                ])}
        }
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
