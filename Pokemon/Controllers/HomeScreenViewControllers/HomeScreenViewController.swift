//
//  HomeScreenViewController.swift
//  Pokemon
//
//  Created by Parker Coelho on 12/21/22.
//

import UIKit

class HomeScreenViewController: UIViewController {
    // MARK: - Properties

    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    var coordinator: MainCoordinator?

    // MARK: - UI Components
    let teamManagerButton: HomeScreenStackView = {
        let button = HomeScreenStackView(title: "Competitive Teams", image: .add)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.button.addTarget(self, action: #selector(navToTeamsList), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(teamManagerButton)
        constrainViews()
        makeTeamTappable()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor(named: "TeaGreen")!.cgColor]
        gradientLayer.zPosition = -2
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        view.layer.addSublayer(gradientLayer)
    }
    
    // MARK: - Functions
    func constrainViews() {
        NSLayoutConstraint.activate([
            teamManagerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            teamManagerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            teamManagerButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            teamManagerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25)
        ])
    }

    func makeTeamTappable() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(navToTeamsList))
        teamManagerButton.isUserInteractionEnabled = true
        teamManagerButton.addGestureRecognizer(tapGestureRecognizer)
    }


    // MARK: - Navigation

     @objc func navToTeamsList() {
         coordinator?.toTeamsList()
     }

}
