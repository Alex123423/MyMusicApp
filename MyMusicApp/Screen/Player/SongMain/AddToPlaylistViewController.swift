//
//  AddToPlaylistViewController.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 25.06.2023.
//

import UIKit

class AddToPlaylistViewController: UIViewController {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .maCustomYellow
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let addLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Add to My Playlist"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierarchy()
        setConstrains()
    }
    
    func setupHierarchy() {
        view.addSubview(containerView)
        view.addSubview(addLabel)
        
    }

    func setConstrains() {
        NSLayoutConstraint.activate([
            
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 33),
            containerView.widthAnchor.constraint(equalToConstant: 260),
            
            addLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            addLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            addLabel.heightAnchor.constraint(equalToConstant: 20),
            addLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}
