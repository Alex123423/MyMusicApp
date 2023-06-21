//
//  DownloadViewController.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-21.
//

import UIKit

class DownloadViewController: UIViewController {
    
    private let downloadView = DownloadView()
    private let musicManager = MusicManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        print(musicManager.dowloadedTracks.count)
        setDelegates()
    }
}

extension DownloadViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        musicManager.dowloadedTracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .red
        return cell
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

