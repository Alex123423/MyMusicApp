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
        cell.settingsButton.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = downloadedAlbums[indexPath.row]
        
        var album = Album()
        album.artistName = index.artistName
        album.trackName = index.trackName
        album.previewUrl = index.localFileUrl
        album.artworkUrl60 = index.artworkUrl60
        
        let songPlayerVC = SongPlayerViewController()
        songPlayerVC.configureSongPlayerView(sender: album)
        songPlayerVC.currentAlbum = album
        songPlayerVC.modalPresentationStyle = .fullScreen
        present(songPlayerVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let trackName = downloadedAlbums[indexPath.row].trackName else { return }
            do {
                try realmManager.deleteDownloadsFromRealm(trackToDelete: trackName)
                print("Track deleted from Realm: \(trackName)")
            } catch {
                print("Error deleting track from Realm: \(error.localizedDescription)")
            }
            downloadedAlbums.remove(at: indexPath.row) // Remove the track from the data source
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade) // Update the table view with the deletion
            tableView.endUpdates()
        }
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

