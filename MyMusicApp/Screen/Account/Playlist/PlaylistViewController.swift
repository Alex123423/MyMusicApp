//
//  PlaylistViewController.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-14.
//

import UIKit

class PlaylistViewController: UIViewController {
    
    var playlistView = PlaylistView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViews()
        setupHierarchy()
        setConstrains()
    }
    
    func showTabBar() {
        let tabBar = TabBarViewController().customTabBar
        tabBar.modalTransitionStyle = .flipHorizontal
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
    
    private func setupTableViews() {
        playlistView.tableView.register(PlaylistTableViewCell.self, forCellReuseIdentifier: "PlaylistTableViewCell")
        playlistView.tableView.dataSource = self
        playlistView.tableView.delegate = self
    }
    
    func setupHierarchy() {
        view.backgroundColor = .maBackground
        view.addSubview(playlistView.searchTextField)
        view.addSubview(playlistView.tableView)
        
    }
    
    func setConstrains() {
        NSLayoutConstraint.activate([
            playlistView.searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            playlistView.searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            playlistView.searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            playlistView.searchTextField.heightAnchor.constraint(equalToConstant: 36),
            
            playlistView.tableView.topAnchor.constraint(equalTo: playlistView.searchTextField.bottomAnchor, constant: 20),
            playlistView.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playlistView.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playlistView.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PlaylistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = playlistView.tableView.dequeueReusableCell(withIdentifier: "PlaylistTableViewCell", for: indexPath) as? PlaylistTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(image: UIImage(named: "firstOnboarding") ?? nil, firstText: "Madonna", secondText: "Андрей Малахов")
        cell.separatorInset = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 21
    }
}

extension PlaylistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
