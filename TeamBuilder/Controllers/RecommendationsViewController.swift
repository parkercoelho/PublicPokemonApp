//
//  RecommendationsViewController.swift
//  TeamBuilder
//
//  Created by Parker Coelho on 2/22/23.
//

import UIKit

class RecommendationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    var team: Team? 
    var delegate: TeamManagerViewController?
    var coordinator: MainCoordinator?
    var recommendationsTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addAllSubviews()
        constrainTableView()
        configureTableView()
        
        do { try URLSessionNetworking.fetchStats()}
        catch {
            print("Failure on the networking")
        }
    }
    func addAllSubviews() {
        view.addSubview(recommendationsTable)
    }
    func configureTableView() {
        recommendationsTable.delegate = self
        recommendationsTable.dataSource = self
        
        recommendationsTable.register(RecommendationsTableViewCell.self, forCellReuseIdentifier: "recCell")
    }
    func constrainTableView() {
        NSLayoutConstraint.activate([
            recommendationsTable.topAnchor.constraint(equalTo: safeArea.topAnchor),
            recommendationsTable.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            recommendationsTable.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            recommendationsTable.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let team = team else {return 0}
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recCell", for: indexPath) as? RecommendationsTableViewCell else { return UITableViewCell() }
        cell.setUpCell()
        return cell
    }
}
struct TopLevelObject: Decodable {
    let battles: Int
    var pokemon: DecodedArray
}

struct SpecificPokemon: Decodable {
//    let lead: Double
//    let usage: Double
    let count: Int
    let weight: Double
//    let viability: [Int]
//    let abilities: String
//    let items: String
//    let spreads: Int
//    let moves: String
//    let teammates: String
//    let counters: String
}

struct DecodedArray: Decodable {
    var array: [SpecificPokemon]
    
    private struct DynamicCodingKeys: CodingKey {
        
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        var tempArray = [SpecificPokemon]()
        
        for key in container.allKeys {
            if key.stringValue == "Dragapult" {
                print(key)
                let decodedObject = try container.decode(SpecificPokemon.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
                tempArray.append(decodedObject)}
        }
        array = tempArray
    }
}
