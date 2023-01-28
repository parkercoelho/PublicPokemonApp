//
//  TeamsListTableViewCell.swift
//  Pokemon
//
//  Created by Parker Coelho on 1/17/23.
//

import UIKit

class TeamsListTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    var delegate: TeamsListTableViewController?
    var team: Team?
    
    let teamNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = UIColor(named: "TypeCalcsGood")
        label.textAlignment = .left
        return label
    }()
    let teamCardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.layer.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return view
    }()
    let addToTeamLabel: UILabel = {
        let label = UILabel(statName: "Add a team")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    let addToTeamViewButton: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.white.cgColor
        view.backgroundColor = UIColor(named: "TypeCalcsDarkGreen")!
        
        view.layer.borderWidth = 3
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    func addAllViews() {
        teamCardView.addSubview(teamNameLabel)
        teamCardView.addSubview(teamCollectionView)
        contentView.addSubview(teamCardView)
    }
    func constrainCell() {
        NSLayoutConstraint.activate([
            teamCardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            teamCardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
            teamCardView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            teamCardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            
            teamNameLabel.leadingAnchor.constraint(equalTo: teamCardView.leadingAnchor, constant: 5),
//            teamNameLabel.trailingAnchor.constraint(equalTo: teamCardView.trailingAnchor),
            teamNameLabel.topAnchor.constraint(equalTo: teamCardView.topAnchor),
            teamNameLabel.bottomAnchor.constraint(equalTo: teamCardView.bottomAnchor),
            
            teamCollectionView.leadingAnchor.constraint(equalTo: teamNameLabel.trailingAnchor, constant: 10),
            teamCollectionView.trailingAnchor.constraint(equalTo: teamCardView.trailingAnchor),
            teamCollectionView.topAnchor.constraint(equalTo: teamCardView.topAnchor),
            teamCollectionView.bottomAnchor.constraint(equalTo: teamCardView.bottomAnchor)
        ])
    }
    func setUpNewTeam() {
        contentView.addSubview(addToTeamViewButton)
        addToTeamViewButton.addSubview(addToTeamLabel)
        NSLayoutConstraint.activate([
//            addToTeamViewButton.leadingAnchor.constraint(equalTo: leadingAnchor),
//            addToTeamViewButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            addToTeamViewButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addToTeamViewButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            addToTeamViewButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            addToTeamViewButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            addToTeamLabel.leadingAnchor.constraint(equalTo: addToTeamViewButton.leadingAnchor),
            addToTeamLabel.trailingAnchor.constraint(equalTo: addToTeamViewButton.trailingAnchor),
            addToTeamLabel.topAnchor.constraint(equalTo: addToTeamViewButton.topAnchor),
            addToTeamLabel.bottomAnchor.constraint(equalTo: addToTeamViewButton.bottomAnchor)
        ])
    }
    func setUpCell() {
        configureTeamCollectionView()
        addAllViews()
        constrainCell()
        teamNameLabel.text = team?.teamName ?? "Error occurred"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .red
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        contentView.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    let teamCollectionView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/6.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(TeamCollectionViewCell.self, forCellWithReuseIdentifier: "teamCell")
        collection.backgroundColor = .clear
        return collection
    }()
    
    func configureTeamCollectionView() {
        teamCollectionView.dataSource = self
        teamCollectionView.delegate = self
        teamCollectionView.backgroundColor = .clear
        teamCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cellTeam = team else {
            return 0
        }
        return cellTeam.pokemonOnTeam.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCollectionViewCell
        cell.backgroundColor = .red
        cell.teamsListDelegate = self
        cell.setUpTeamsListTeamCollectionViewCell(indexPath: indexPath)
        
        return cell
    }
}
