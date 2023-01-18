//
//  TypeCollectionHeaderView.swift
//  Pokemon
//
//  Created by Parker Coelho on 11/28/22.
//

import UIKit

class TypeCollectionHeaderView: UICollectionReusableView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .strokedCheckmark
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImage()
    }
    
    func configureImage() {
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
