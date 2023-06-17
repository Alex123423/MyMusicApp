//
//  HomeScreenViewController.swift
//  MyMusicApp
//
//  Created by Nikita Borisov on 13.06.2023.
//

import UIKit
import SnapKit
import Firebase
import GoogleSignIn
import RealmSwift

//MARK: - Screen Sections Enum & TitileHeader String
enum SectionVarieble {
    case section1(model: [HomeScreenViewReusebleModel])
    case section2(model: [HomeScreenViewReusebleModel])
    case section3(model: [HomeScreenViewReusebleModel])
    
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

final class HomeScreenViewController: UIViewController {
    
    private var sections = [SectionVarieble]()
    
    let homeView = HomeScreenView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .maBackground
        configureModels()
        setDelegate()
        getCurrentGoogleUser()
        print(Auth.auth().currentUser?.displayName)
        print(Auth.auth().currentUser?.email)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureViewFrame()
    }
    
    func getCurrentGoogleUser() {
        guard let currentGoogleUser = GIDSignIn.sharedInstance.currentUser else { return }
        let userID = currentGoogleUser.userID
        let fullName = currentGoogleUser.profile?.name
        let email = currentGoogleUser.profile?.email
        let profileImageURL = currentGoogleUser.profile?.imageURL(withDimension: 320)
        
        print("GOOGLE CURRENT USER INFO:")
        print("User ID: \(userID ?? "")")
        print("Full Name: \(fullName ?? "")")
        print("Email: \(email ?? "")")
        print("Profile Image URL: \(profileImageURL?.absoluteString ?? "")")
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
    
    
    private func configureModels() {
        
        let mainResult = [HomeScreenViewReusebleModel(trackName: "Какой то трек", artistName: "Артист", imageCover: "imageimage"),HomeScreenViewReusebleModel(trackName: "Новый альбом", artistName: "Афигенный артист", imageCover: "image2"),HomeScreenViewReusebleModel(trackName: "Nhtr nhtr", artistName: "ertgrtg артист", imageCover: "imageimage")]
        
        sections.append(.section1(model: mainResult))
        sections.append(.section2(model: mainResult))
        sections.append(.section3(model: mainResult))
        
        //        sections.append(.section1(model: mainResult.compactMap({_ in
        //            return HomeScreenViewReusebleModel(
        //                trackName:  "Какой то трек",
        //                artistName: "Артист",
        //                imageCover: "imageimage")
        //        })))
        //
        //        sections.append(.section2(model: mainResult.compactMap({_ in
        //            return HomeScreenViewReusebleModel(
        //                trackName: "Новый альбом",
        //                artistName: "Афигенный артист",
        //                imageCover: "imageimage")
        //        })))
        //
        //        sections.append(.section3(model: mainResult.compactMap({_ in
        //            return HomeScreenViewReusebleModel(
        //                trackName: "Новый трек",
        //                artistName: "Исполнитель",
        //                imageCover: "imageimage")
        //        })))
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
        // здесь делаем транзишены на следующие экраны
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
        searVC.modalPresentationStyle = .fullScreen
        present(searVC, animated: true)
    }
    
}

