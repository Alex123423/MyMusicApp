//
//  DownloadViewController.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-21.
//

import UIKit

final class DownloadViewController: UIViewController {
    
    private let downloadView = DownloadView()
    private let musicManager = MusicManager.shared
    private let realmManager = RealmManager.shared
    private let player = PlayerManager.shared
    private var downloadedAlbums: [RealmAlbumModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        downloadedAlbums = realmManager.fetchDownloadedAlbums() ?? []
        print("REALM ALBUMS \(downloadedAlbums)")
    }
    
}

extension DownloadViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        downloadedAlbums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        let image = URL(string: downloadedAlbums[indexPath.row].artworkUrl60 ?? "")
        cell.configureCellWithSecondLabel(image: image, firstText: downloadedAlbums[indexPath.row].trackName, secondText: downloadedAlbums[indexPath.row].artistName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        guard let localUrlString = downloadedAlbums[indexPath.row].localFileUrl else { return }
        guard let url = URL(string: localUrlString) else { return }
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: url.path) {
            print("File exists at path: \(url.path)")
        } else {
            print("File does not exist at path: \(url.path)")
        }
        
        print(url)
//        player.playTrackSampleFromLocal(at: )
    }
}

extension DownloadViewController {
    func setDelegates() {
        downloadView.tableView.delegate = self
        downloadView.tableView.dataSource = self
    }
    
    private func setupViews() {
        view.backgroundColor = .maBackground
        view.addSubview(downloadView)
    }
    
    private func setupConstraints() {
        downloadView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            downloadView.topAnchor.constraint(equalTo: view.topAnchor),
            downloadView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            downloadView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            downloadView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

