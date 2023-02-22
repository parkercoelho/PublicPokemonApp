//
//  HomeScreenStackView.swift
//  Pokemon
//
//  Created by Parker Coelho on 12/21/22.
//

import UIKit

class HomeScreenStackView: UIStackView {
    
    var title: String
    var image: UIImage

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let button: UIButton = {
        var config = UIButton.Configuration.bordered()
        config.image = .checkmark
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false 
        return button
    }()
    
    init(title: String, image: UIImage) {
        self.title = title
        self.image = image
        super.init(frame: .zero)
        
        
        titleLabel.text = title
        button.configuration?.image = image
        
        constrainViews()
    }
    
    func constrainViews() {
        self.addSubview(titleLabel)
        self.addSubview(button)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
