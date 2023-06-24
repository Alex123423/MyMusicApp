//
//  HomeScreenViewController.swift
//  MyMusicApp
//
//  Created by Nikita Borisov on 13.06.2023.
//

import UIKit
import SnapKit
import ProgressHUD
//MARK: - Screen Sections Enum & TitileHeader String
enum SectionVarieble {
    case section1(model: [Album])
    case section2(model: [Album])
    case section3(model: [Album])
    
    var title : String {
        switch self {
        case .section1:
            return "New Song"
        case .section2:
            return "Popular album"
        case .section3:
            return "Recently Music"
        }
    }
}

class HomeScreenViewController: UIViewController {
    
    private var sections = [SectionVarieble]()
    
    let homeView = HomeScreenView()
    
    var newScreenDelegate: TabBarViewControllerDelegate?
    
    private let musicManager = MusicManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("2")
        view.backgroundColor = .maBackground
        //configureModels()
        fetchData()
        setDelegate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureViewFrame()
    }
    
    //MARK: - Configure ViewFrame
    private func configureViewFrame() {
        view.addSubview(homeView)
        
        homeView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        homeView.delegate = self
        homeView.collectionView.dataSource = self
        homeView.collectionView.delegate = self
    }
    
    //MARK: - Data Fetch Methods
    private func fetchData() {
        
        var newSong: [Album]?
        var popAlbum: [Album]?
        var newTrack: [Album]?
        
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        
        musicManager.requestData(name: "dj") { result in
            defer {
                group.leave()
            }
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                newSong = data
            }
        }
        musicManager.requestData(name: "album") { result in
            defer {
                group.leave()
            }
            switch result {
            case .failure(let error):
                print(error)
                
            case .success(let data):
                popAlbum = data
                print(popAlbum)
                
            }
        }
        musicManager.requestData(name: "mix") { result in
            defer {
                group.leave()
            }
            switch result {
            case .failure(let error):
                print(error)
                
            case .success(let data):
                newTrack = data
                //print(popAlbum)
                
            }
        }
        group.notify(queue: .main) {
            guard let newSongs = newSong,
                  let popAlbums = popAlbum,
                    let newPop = newTrack else {
                return
            }
            self.configureModels(newSongs: newSongs, popAlbums: popAlbums, newPop: newPop)
        }
    }
    
    private func configureModels(newSongs: [Album], popAlbums: [Album], newPop: [Album]) {
        
        sections.append(.section1(model: newSongs))
        sections.append(.section2(model: popAlbums))
        sections.append(.section3(model: newPop))
        
        homeView.collectionView.reloadData()
    }
}

//MARK: - CollectionView DataSource/Delegate Extensions
extension HomeScreenViewController: UICollectionViewDataSource {
    
}

extension HomeScreenViewController: UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type {
        case .section1(let viewModels):
            return viewModels.count
        case .section2(let viewModels):
            return viewModels.count
        case .section3(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type = sections[indexPath.section]
        switch type {
        case .section1(let model):
            let viewModel = model[indexPath.row]
            self.newScreenDelegate?.maximizeTopAnchorConstraintFunc(model: viewModel)
        case .section2(let model):
            let vc = AlbumViewController()
            vc.configureView(model: model)
            present(vc, animated: true)
        case .section3(let model):
            let viewModel = model[indexPath.row]
            self.newScreenDelegate?.maximizeTopAnchorConstraintFunc(model: viewModel)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = sections[indexPath.section]
        switch type {
        case .section1(model: let model):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:NewSongReusebleViewCell.identifire , for: indexPath) as? NewSongReusebleViewCell else {
                return UICollectionViewCell()
            }
            let indexData = model[indexPath.row]
            cell.configureCells(model: indexData)
            return cell
        case .section2(model: let model):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:PopularAlbumCollectionViewCell.identifire , for: indexPath) as? PopularAlbumCollectionViewCell else {
                return UICollectionViewCell()
            }
            let indexData = model[indexPath.row]
            cell.configureCells(model: indexData)
            return cell
        case .section3(model: let model):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:RecentlyTrackCollectionViewCell.identifire , for: indexPath) as? RecentlyTrackCollectionViewCell else {
                return UICollectionViewCell()
            }
            let indexData = model[indexPath.row]
            cell.configureCells(model: indexData)
            cell.trackNumberLbl.text = "0\(indexPath.row+1)"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleHeaderCollectionReusableView.identifire, for: indexPath) as? TitleHeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        let headerTitle = sections[indexPath.section].title
        header.configure(with: headerTitle )
        return header
    }
}

extension HomeScreenViewController: HomeScreenViewDelegate {
    
    func homeScreenView(_ view: HomeScreenView, didTapSearchButton button: UIButton) {
        let searVC = SearchViewController()
        //searVC.modalPresentationStyle = .fullScreen
        present(searVC, animated: true)
    }
    
}



