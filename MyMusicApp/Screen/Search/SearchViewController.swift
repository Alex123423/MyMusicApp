//
//  SearchViewController.swift
//  MyMusicApp
//
//  Created by Dmitry Medvedev on 13.06.2023.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    
    private let categories = ["Top searching", "Artist", "Album", "Song", "FilmMusic"]
    
    private var top: [Album]?
    private var artist: [Album]?
    private var album: [Album]?
    private var song: [Album]?
    private var filmMusic: [Album]?
    private var searchData: [Album]?
    private var selectedCategoryIndex: Int?
    private var showAllCategories = false
    private let musicManager = MusicManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCollectionTableViews()
        setupTarget()
        getTop()
        getArtist()
        getAlbum()
        getSong()
        getPodcast()
        selectFirstCollectionViewCell()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        selectFirstCollectionViewCell()
//    }
    
    private func getTop() {
        musicManager.requestData(name: "mix") { result in
            switch result {
            case .success(let data):
                self.top = data
                self.searchView.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getArtist() {
        musicManager.requestData(name: "allArtist") { result in
            switch result {
            case .success(let data):
                self.artist = data
                self.searchView.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getAlbum() {
        musicManager.requestData(name: "album") { result in
            switch result {
            case .success(let data):
                self.album = data
                self.searchView.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getSong() {
        musicManager.requestData(name: "allTrack") { result in
            switch result {
            case .success(let data):
                self.song = data
                self.searchView.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getPodcast() {
        musicManager.requestData(name: "shortFilm") { result in
            switch result {
            case .success(let data):
                self.filmMusic = data
                self.searchView.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupCollectionTableViews() {
        searchView.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        searchView.collectionView.dataSource = self
        searchView.collectionView.delegate = self
        searchView.tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        searchView.tableView.register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: "TableViewHeader")
        searchView.tableView.dataSource = self
        searchView.tableView.delegate = self
        searchView.searchTextField.delegate = self
    }
    
    private func setupTarget() {
        searchView.backButton.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
        searchView.searchTextField.addTarget(self, action: #selector(addCancelButton), for: .editingDidBegin)
        searchView.cancelButton.addTarget(self, action: #selector(removeCancelButton), for: .touchUpInside)
        searchView.searchTextField.addTarget(self, action: #selector(setupDataFromTextField), for: [.editingChanged, .editingDidEnd])
    }
    
    private func stringWithoutSpace(_ text: String) -> String {
        let words = text.components(separatedBy: " ")
        let result = words.joined()
        return result
    }
    
    @objc private func backToHome() {
        dismiss(animated: true)
    }
    
    @objc private func addCancelButton() {
        view.addSubview(searchView.cancelButton)
        searchView.searchTextField.snp.removeConstraints()
        
        searchView.cancelButton.snp.makeConstraints { make in
            make.height.equalTo(14)
            make.trailing.equalToSuperview().offset(-24)
            make.centerY.equalTo(searchView.searchTextField)
            make.width.equalTo(40)
        }
        
        searchView.searchTextField.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(searchView.backButton.snp.trailing).offset(12)
            make.trailing.equalTo(searchView.cancelButton.snp.leading).offset(-8)
        }
    }
    
    @objc private func removeCancelButton() {
        searchView.searchTextField.text = .none
        searchView.searchTextField.endEditing(true)
        searchView.cancelButton.removeFromSuperview()
        searchView.searchTextField.snp.removeConstraints()
        
        searchView.searchTextField.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.trailing.equalToSuperview().offset(-24)
            make.leading.equalTo(searchView.backButton.snp.trailing).offset(12)
        }
        searchData = nil
        searchView.tableView.reloadData()
    }
    
    @objc private func setupDataFromTextField() {
        if searchView.searchTextField.text?.count != 0 {
            guard let text = searchView.searchTextField.text else { return }
            let finalText = stringWithoutSpace(text)
            musicManager.requestData(name: finalText) { result in
                switch result {
                case .success(let data):
                    self.searchData = data
                    self.selectFirstCollectionViewCell()
                    self.checkResults()
                    self.searchView.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            return
        }
    }
    
    private func selectFirstCollectionViewCell() {
        let indexPath = IndexPath(item: 0, section: 0)
        searchView.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
        collectionView(searchView.collectionView, didSelectItemAt: indexPath)
    }
    
    private func checkResults() {
        guard let searchData = searchData else { return }
        if searchData.isEmpty {
            searchView.tableView.removeFromSuperview()
            view.addSubview(searchView.emptyImage)
            
            searchView.emptyImage.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        } else {
            searchView.emptyImage.removeFromSuperview()
            view.addSubview(searchView.tableView)
            
            searchView.tableView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.top.equalTo(searchView.collectionView.snp.bottom).offset(15)
                make.bottom.equalTo(view.safeAreaLayoutGuide)
            }
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchView.collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCell(text: SearchConstant.Text.allCases[indexPath.row].rawValue)
        
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            showAllCategories = true
            selectedCategoryIndex = 0
        } else {
            showAllCategories = false
            selectedCategoryIndex = indexPath.row
        }
        
        searchView.tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if showAllCategories {
            return categories.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedCategoryIndex {
        case 0:
            if searchData == nil {
                switch section {
                case 0:
                    return top?.count ?? 1
                case 1:
                    return artist?.count ?? 1
                case 2:
                    return album?.count ?? 1
                case 3:
                    return song?.count ?? 1
                case 4:
                    return filmMusic?.count ?? 1
                default:
                    return 1
                }
            } else {
                switch section {
                case 0:
                    return searchData?.count ?? 1
                case 1:
                    return searchData?.count ?? 1
                case 2:
                    return searchData?.count ?? 1
                case 3:
                    return searchData?.count ?? 1
                case 4:
                    return searchData?.count ?? 1
                default:
                    return 1
                }
            }
        case 1:
            return artist?.count ?? 1
        case 2:
            return album?.count ?? 1
        case 3:
            return song?.count ?? 1
        case 4:
            return filmMusic?.count ?? 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchView.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        switch selectedCategoryIndex {
        case 0:
            if searchData == nil {
                switch indexPath.section {
                case 0:
                    if let top = top {
                        cell.configureCellWithSecondLabel(image: URL(string: top[indexPath.row].artworkUrl60 ?? ""),
                                                          firstText: top[indexPath.row].trackName,
                                                          secondText: top[indexPath.row].artistName)
                    }
                case 1:
                    if let artist = artist {
                        cell.configureCellWithoutSecondLabel(image: URL(string: artist[indexPath.row].artworkUrl60 ?? ""),
                                                             firstText: artist[indexPath.row].artistName)
                    }
                case 2:
                    if let album = album {
                        cell.configureCellWithSecondLabel(image: URL(string: album[indexPath.row].artworkUrl60 ?? ""),
                                                          firstText: album[indexPath.row].collectionName,
                                                          secondText: album[indexPath.row].artistName)
                    }
                case 3:
                    if let song = song {
                        cell.configureCellWithSecondLabel(image: URL(string: song[indexPath.row].artworkUrl60 ?? ""),
                                                          firstText: song[indexPath.row].trackName,
                                                          secondText: song[indexPath.row].artistName)
                    }
                case 4:
                    if let filmMusic = filmMusic {
                        cell.configureCellWithSecondLabel(image: URL(string: filmMusic[indexPath.row].artworkUrl60 ?? ""),
                                                          firstText: filmMusic[indexPath.row].artistName,
                                                          secondText: filmMusic[indexPath.row].trackName)
                    }
                default:
                    break
                }
            } else {
                guard let searchData = searchData else { return UITableViewCell() }
                switch indexPath.section {
                case 0:
                    cell.configureCellWithSecondLabel(image: URL(string: searchData[indexPath.row].artworkUrl60 ?? ""),
                                                      firstText: searchData[indexPath.row].trackName,
                                                      secondText: searchData[indexPath.row].artistName)
                case 1:
                    cell.configureCellWithoutSecondLabel(image: URL(string: searchData[indexPath.row].artworkUrl60 ?? ""),
                                                         firstText: searchData[indexPath.row].artistName)
                case 2:
                    cell.configureCellWithSecondLabel(image: URL(string: searchData[indexPath.row].artworkUrl60 ?? ""),
                                                      firstText: searchData[indexPath.row].collectionName,
                                                      secondText: searchData[indexPath.row].artistName)
                case 3:
                    cell.configureCellWithSecondLabel(image: URL(string: searchData[indexPath.row].artworkUrl60 ?? ""),
                                                      firstText: searchData[indexPath.row].trackName,
                                                      secondText: searchData[indexPath.row].artistName)
                case 4:
                    cell.configureCellWithSecondLabel(image: URL(string: searchData[indexPath.row].artworkUrl60 ?? ""),
                                                      firstText: searchData[indexPath.row].trackName,
                                                      secondText: searchData[indexPath.row].artistName)
                default:
                    break
                }
            }
        case 1:
            if let artist = artist {
                if artist.isEmpty {
                    
                }
                cell.configureCellWithoutSecondLabel(image: URL(string: artist[indexPath.row].artworkUrl60 ?? ""),
                                                     firstText: artist[indexPath.row].artistName)
            }
        case 2:
            if let album = album {
                cell.configureCellWithSecondLabel(image: URL(string: album[indexPath.row].artworkUrl60 ?? ""),
                                                  firstText: album[indexPath.row].collectionName,
                                                  secondText: album[indexPath.row].artistName)
            }
        case 3:
            if let song = song {
                cell.configureCellWithSecondLabel(image: URL(string: song[indexPath.row].artworkUrl60 ?? ""),
                                                  firstText: song[indexPath.row].trackName,
                                                  secondText: song[indexPath.row].artistName)
            }
        case 4:
            if let filmMusic = filmMusic {
                cell.configureCellWithSecondLabel(image: URL(string: filmMusic[indexPath.row].artworkUrl60 ?? ""),
                                                  firstText: filmMusic[indexPath.row].artistName,
                                                  secondText: filmMusic[indexPath.row].trackName)
            }
        default:
            break
        }
        cell.separatorInset = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = searchView.tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableViewHeader") as? TableViewHeader else { return UIView() }
        
        if showAllCategories {
            header.configure(text: categories[section])
        } else {
            if let index = selectedCategoryIndex {
                header.configure(text: categories[index])
            }
        }
        return header
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var selectedDate: Album?
        
        switch selectedCategoryIndex {
        case 0:
            if searchView.searchTextField.text?.count == 0 {
                switch indexPath.section {
                case 0:
                    selectedDate = top?[indexPath.item]
                case 1:
                    selectedDate = artist?[indexPath.item]
                case 2:
                    selectedDate = album?[indexPath.item]
                case 3:
                    selectedDate = song?[indexPath.item]
                case 4:
                    selectedDate = filmMusic?[indexPath.item]
                default:
                    break
                }
            } else {
                selectedDate = searchData?[indexPath.item]
            }
        case 1:
            selectedDate = artist?[indexPath.item]
        case 2:
            selectedDate = album?[indexPath.item]
        case 3:
            selectedDate = song?[indexPath.item]
        case 4:
            selectedDate = filmMusic?[indexPath.item]
        default:
            break
        }
        
        if let selectedDate = selectedDate {
            print(selectedDate)
            
            let songPlayerVC = SongPlayerViewController()
            songPlayerVC.configureSongPlayerView(sender: selectedDate)
            songPlayerVC.currentAlbum = selectedDate
            songPlayerVC.delegate = self
            songPlayerVC.modalPresentationStyle = .fullScreen
            present(songPlayerVC, animated: true)
        }
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension SearchViewController {
    private func setupViews() {
        view.backgroundColor = .maBackground
        view.addSubview(searchView.backButton)
        view.addSubview(searchView.searchTextField)
        view.addSubview(searchView.collectionView)
        view.addSubview(searchView.tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        searchView.backButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchView.searchTextField)
            make.leading.equalToSuperview().offset(24)
        }
        
        searchView.searchTextField.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.trailing.equalToSuperview().offset(-24)
            make.leading.equalTo(searchView.backButton.snp.trailing).offset(12)
        }
        
        searchView.collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(searchView.searchTextField.snp.bottom).offset(40)
            make.height.equalTo(50)
        }
        
        searchView.tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(searchView.collectionView.snp.bottom).offset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension SearchViewController: TrackMovingDelegate {
    
    private func getTrack(isForward: Bool) -> Album? {
        
        guard let indexPath = searchView.tableView.indexPathForSelectedRow else { return nil }
        searchView.tableView.deselectRow(at: indexPath, animated: true)
        var nextIndexPath: IndexPath!
        if isForward {
            nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
        } else {
            nextIndexPath = IndexPath(row: indexPath.row - 1, section: indexPath.section)
        }
        searchView.tableView.selectRow(at: nextIndexPath, animated: true, scrollPosition: .none)
        let cellViewModel = top?[indexPath.row]
        return cellViewModel
    }
    
    func moveBackForPreviewsTrack() -> Album? {
        print("moveBack")
        return getTrack(isForward: false)
    }
    
    func moveForwardForPreviewsTrack() -> Album? {
        print("moveForward")
        return getTrack(isForward: true)
    }
    
}
