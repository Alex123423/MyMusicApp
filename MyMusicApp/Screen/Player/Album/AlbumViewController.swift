//
//  AlbumViewController.swift.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 15.06.2023.
//

import UIKit

class AlbumViewController: UIViewController {
    
    private let albumView = AlbumView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViews()
        setupHierarchy()
        setConstrains()
    }
    
    private func setupTableViews() {
        albumView.tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        albumView.tableView.dataSource = self
        albumView.tableView.delegate = self
    }
    
    func setupHierarchy() {
        view.backgroundColor = .maBackground
        view.addSubview(albumView.albumImage100)
        view.addSubview(albumView.vStack)
        albumView.vStack.addArrangedSubview(albumView.songLabel)
        albumView.vStack.addArrangedSubview(albumView.artistLabel)
        albumView.vStack.addArrangedSubview(albumView.songTextLabel)
        view.addSubview(albumView.separateImage)
        view.addSubview(albumView.suggestionLabel)
        view.addSubview(albumView.tableView)
    }
    
    func setConstrains() {
        NSLayoutConstraint.activate([
            
            albumView.albumImage100.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            albumView.albumImage100.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //albumView.albumImage100.heightAnchor.constraint(equalTo: 200),
            //albumView.albumImage100.widthAnchor.constraint(equalTo: 200),
            
            albumView.vStack.topAnchor.constraint(equalTo: albumView.albumImage100.bottomAnchor, constant: 30),
            albumView.vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            albumView.separateImage.topAnchor.constraint(equalTo: albumView.vStack.bottomAnchor, constant: 14),
            albumView.separateImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            albumView.separateImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            albumView.suggestionLabel.topAnchor.constraint(equalTo: albumView.separateImage.bottomAnchor, constant: 14),
            albumView.suggestionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            albumView.tableView.topAnchor.constraint(equalTo: albumView.suggestionLabel.bottomAnchor, constant: 14),
            albumView.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            albumView.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            albumView.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func buttonTapped() {
        albumView.songTextLabel.isHidden = !albumView.songTextLabel.isHidden
    }

}

extension AlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = albumView.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        cell.configureCell(image: UIImage(named: "firstOnboarding") ?? nil, firstText: "Madonna", secondText: "Андрей Малахов")
       // cell.separatorInset = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 21
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Suggestion"
//    }
}

extension AlbumViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

