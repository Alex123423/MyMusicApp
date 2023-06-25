//
//  AlbumViewController.swift.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 15.06.2023.
//

import UIKit
import Kingfisher

class AlbumViewController: UIViewController {
    
    private let albumView = AlbumView()

    var album = [Album]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViews()
        setupHierarchy()
        setConstrains()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
       // album.removeAll()
    }
    
    func setupHierarchy() {
        view.backgroundColor = .maBackground
        view.addSubview(albumView.albumImage)
        view.addSubview(albumView.vStack)
        albumView.vStack.addArrangedSubview(albumView.songLabel)
        albumView.vStack.addArrangedSubview(albumView.artistLabel)
       // view.addSubview(albumView.songText)
        view.addSubview(albumView.showMoreButton)
        view.addSubview(albumView.separateImage)
        view.addSubview(albumView.suggestionLabel)
        view.addSubview(albumView.tableView)
    }
    
    func setConstrains() {
        NSLayoutConstraint.activate([
            
            albumView.albumImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            albumView.albumImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            albumView.albumImage.heightAnchor.constraint(equalToConstant: 200),
            albumView.albumImage.widthAnchor.constraint(equalToConstant: 200),
            
            albumView.vStack.topAnchor.constraint(equalTo: albumView.albumImage.bottomAnchor, constant: 30),
            albumView.vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
//            albumView.songText.topAnchor.constraint(equalTo: albumView.vStack.bottomAnchor, constant: 20),
//            albumView.songText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),

            albumView.showMoreButton.topAnchor.constraint(equalTo: albumView.vStack.bottomAnchor, constant: 20),
            albumView.showMoreButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),

            albumView.separateImage.topAnchor.constraint(equalTo: albumView.showMoreButton.bottomAnchor, constant: 14),
            albumView.separateImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            albumView.separateImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            albumView.suggestionLabel.topAnchor.constraint(equalTo: albumView.separateImage.bottomAnchor, constant: 14),
            albumView.suggestionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),

            albumView.tableView.topAnchor.constraint(equalTo: albumView.suggestionLabel.bottomAnchor, constant: 14),
            albumView.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            albumView.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            albumView.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableViews() {
        albumView.tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "AlbumTableViewCell")
        albumView.tableView.dataSource = self
        albumView.tableView.delegate = self
    }
    
    func configTextFieldButton() {
        albumView.showMoreButton.setTitle("Show more", for: .normal)
        albumView.showMoreButton.setTitle("Show less", for: .selected)
        albumView.showMoreButton.addTarget(self, action: #selector(showMoreButtonTapped), for: .touchUpInside)
    }
    
    @objc func showMoreButtonTapped(_ sender: UIButton) {
           sender.isSelected = !sender.isSelected

           if sender.isSelected {
               albumView.songText.numberOfLines = 0 // Показать все строки текста
           } else {
               albumView.songText.numberOfLines = 3 // Вернуться к начальному количеству строк
           }
       }
    
    func configureView(model: [Album]) {
        guard let UirlString600 = (model.first?.artworkUrl60?.replacingOccurrences(of: "60x60", with: "600x600")) else { return }
        album = model
        albumView.albumImage.kf.setImage(with: URL(string: UirlString600))
        albumView.artistLabel.text = model.first?.artistName
    }
}

extension AlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func formatNumber(_ number: Int) -> String {
        if number < 10 {
            return String(format: "0%d", number)
        } else {
            return String(number)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = albumView.tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as? AlbumTableViewCell else { return UITableViewCell() }
        let model = album[indexPath.row]
        cell.configureCell(model: model)
//        cell.separatorInset = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 0)
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
        let model = album[indexPath.row]
        let vc = SongPlayerViewController()
        vc.configureSongPlayerView(sender: model)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

