//
//  PopUpView.swift
//  Pokemon
//
//  Created by Parker Coelho on 2/16/23.
//

import Foundation
import UIKit

class PopUpView: UIView {
    let alertTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Test Title"
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")
        label.textAlignment = .center
        label.font = UIFont(name: "American Typewriter Bold", size: 24)
        label.numberOfLines = 2
        return label
    }()
    
    let alertMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Test alert"
        label.textColor = UIColor(named: "TypeCalcsDarkGreen")
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = UIFont(name: "American Typewriter", size: 16)
        return label
    }()
    
    lazy var alertStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [alertTitleLabel, alertMessageLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    let alertMessageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 24
        view.backgroundColor = .white
        return view
    }()
    
    @objc func animateOut() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
            self.alertMessageContainerView.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        }) { (complete) in
            if complete {
                self.removeFromSuperview()
            }
        }
    }
    
    @objc func animateIn() {
        self.alpha = 0
        self.alertMessageContainerView.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
            self.alertMessageContainerView.transform = .identity
            self.alpha = 1
        })
    }
    
    init(frame: CGRect, title: String, message: String) {
        super.init(frame: frame)
        alertTitleLabel.text = title
        alertMessageLabel.text = message
        alertMessageContainerView.layer.borderColor = UIColor(named: "TypeCalcsDarkGreen")!.cgColor
        alertMessageContainerView.layer.borderWidth = 5
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
//        self.backgroundColor = UIColor(named: "TypeCalcsDarkGreen")!.withAlphaComponent(0.8)
        self.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        self.frame = UIScreen.main.bounds
        self.addSubview(alertMessageContainerView)
        
        alertMessageContainerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        alertMessageContainerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        alertMessageContainerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75).isActive = true
        alertMessageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.33).isActive = true

        alertMessageContainerView.addSubview(alertStack)

        alertStack.centerXAnchor.constraint(equalTo: alertMessageContainerView.centerXAnchor).isActive = true
        alertStack.widthAnchor.constraint(equalTo: alertMessageContainerView.widthAnchor, multiplier: 0.90).isActive = true
        alertStack.centerYAnchor.constraint(equalTo: alertMessageContainerView.centerYAnchor).isActive = true
        alertStack.heightAnchor.constraint(equalTo: alertMessageContainerView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(alertMessageContainerView)
        alertMessageContainerView.addSubview(alertMessageLabel)
    }
    
    func constrainViews() {
        NSLayoutConstraint.activate([
            alertMessageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            alertMessageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            alertMessageContainerView.topAnchor.constraint(equalTo: topAnchor),
            alertMessageContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            alertMessageLabel.leadingAnchor.constraint(equalTo: alertMessageContainerView.leadingAnchor),
            alertMessageLabel.topAnchor.constraint(equalTo: alertMessageContainerView.topAnchor),
            alertMessageLabel.bottomAnchor.constraint(equalTo: alertMessageContainerView.bottomAnchor),
            alertMessageLabel.trailingAnchor.constraint(equalTo: alertMessageContainerView.trailingAnchor),

        ])
    }
    
    func setUpView(alertMessage: String, backgroundColor: UIColor){
        self.backgroundColor = .red
        alertMessageContainerView.backgroundColor = backgroundColor
        alertMessageLabel.text = alertMessage
        
    }
}
