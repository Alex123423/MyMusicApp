//
//  FavouritesViewController.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 19.06.2023.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    var favouritesView = FavouritesView()
    private var favouriteAlbums: [RealmAlbumModel] = []
    private let realmManager = RealmManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViews()
        setupHierarchy()
        setConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favouriteAlbums = realmManager.fetchFavouriteAlbums() ?? []
    }
    
    func showTabBar() {
        let tabBar = TabBarViewController().customTabBar
        tabBar.modalTransitionStyle = .flipHorizontal
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
    
    private func setupTableViews() {
        favouritesView.tableView.register(FavouritesTableViewCell.self, forCellReuseIdentifier: "FavouritesTableViewCell")
        favouritesView.tableView.dataSource = self
        favouritesView.tableView.delegate = self
    }
    
    func setupHierarchy() {
        view.backgroundColor = .maBackground
        view.addSubview(favouritesView.topLabel)
        view.addSubview(favouritesView.tableView)
        
    }
    
    func setConstrains() {
        NSLayoutConstraint.activate([
            
            favouritesView.topLabel.bottomAnchor.constraint(equalTo: favouritesView.tableView.topAnchor, constant: -30),
            favouritesView.topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            favouritesView.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            favouritesView.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favouritesView.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favouritesView.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteAlbums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favouritesView.tableView.dequeueReusableCell(withIdentifier: "FavouritesTableViewCell", for: indexPath) as? FavouritesTableViewCell else { return UITableViewCell() }
        let index = favouriteAlbums[indexPath.row]
        let image = URL(string: index.artworkUrl60 ?? "")
        cell.configureCell(image: image, firstText: index.trackName, secondText: index.artistName)
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

extension FavouritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
