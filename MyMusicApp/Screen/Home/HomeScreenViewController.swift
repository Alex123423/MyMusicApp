//
//  HomeScreenViewController.swift
//  MyMusicApp
//
//  Created by Nikita Borisov on 13.06.2023.
//

import UIKit


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

class HomeScreenViewController: UIViewController {
    
    private var sections = [SectionVarieble]()
    
    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { section,_ in
        return HomeScreenViewController.createSectionLayout(section: section)
    })
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        //setNavController()
        configureModels()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        collectionView.backgroundColor = UIColor(named: "background")
    }
    //MARK: - NavigationController Settings
//    func setNavController() {
//        self.navigationController?.navigationBar.barTintColor = UIColor.clear
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
//        let attributes = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 60), NSAttributedString.Key.foregroundColor:UIColor.white]
//        navigationController?.navigationBar.largeTitleTextAttributes = attributes
//        self.title = "Music"
//
//        let searchButton = UIBarButtonItem(
//            barButtonSystemItem: .search,
//            target: self,
//            action:  #selector(searchTapped))
//        searchButton.tintColor = .white
//        searchButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        navigationItem.rightBarButtonItem = searchButton
//    }
//
//    @objc func searchTapped() {
//        // тут мутим транзишн на экран поиска
//    }

    //MARK: - CollectionView Settings
    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(NewSongReusebleViewCell.self, forCellWithReuseIdentifier: NewSongReusebleViewCell.identifire)
        collectionView.register(PopularAlbumCollectionViewCell.self, forCellWithReuseIdentifier: PopularAlbumCollectionViewCell.identifire)
        collectionView.register(RecentlyTrackCollectionViewCell.self, forCellWithReuseIdentifier: RecentlyTrackCollectionViewCell.identifire)
        collectionView.register(TitleHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderCollectionReusableView.identifire)
        
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
        collectionView.reloadData()
    }
}

//MARK: - CollectionView Extensions
extension HomeScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
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
    
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        <#code#>
    //    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleHeaderCollectionReusableView.identifire, for: indexPath) as? TitleHeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        let headerTitle = sections[indexPath.section].title
        header.configure(with: headerTitle )
        return header
    }
}

//MARK: - Create Layout Sections Methods Extensions
extension HomeScreenViewController {
    
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        let supplementaryView = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(380),
                    heightDimension: .absolute(40)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
        ]
        switch section {
        case 0:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(150),
                    heightDimension: .absolute(100)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 2, trailing: 2)
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(150),
                    heightDimension: .absolute(200)),
                subitem: item,
                count: 1)
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(150),
                    heightDimension: .absolute(200)),
                subitem: verticalGroup,
                count: 1)
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.boundarySupplementaryItems = supplementaryView
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        case 1:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(400),
                    heightDimension: .absolute(250)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 5, trailing: 25)
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(400),
                    heightDimension: .absolute(250)),
                subitem: item,
                count: 1)
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(400),
                    heightDimension: .absolute(250)),
                subitem: verticalGroup,
                count: 1)
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.boundarySupplementaryItems = supplementaryView
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        case 2:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(100)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 2, trailing: 15)
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(100)),
                subitem: item,
                count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = supplementaryView
            return section
        default:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(120)),
                subitem: item,
                count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = supplementaryView
            return section
        }
    }
}
