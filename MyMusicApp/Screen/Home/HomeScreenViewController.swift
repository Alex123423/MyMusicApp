//
//  HomeScreenViewController.swift
//  MyMusicApp
//
//  Created by Nikita Borisov on 13.06.2023.
//

import UIKit


//MARK: - Screen Sections Enum & TitileHeader String
enum SectionVarieble {
    case section1(model: [Any])
    case section2(model: [Any])
    case section3(model: [Any])
    
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
        setNavController()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        collectionView.backgroundColor = UIColor(named: "background")
    }
    
    func setNavController() {
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
        let attributes = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 60), NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        self.title = "Music"
    }
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(NewSongReusebleViewCell.self, forCellWithReuseIdentifier: NewSongReusebleViewCell.identifire)
        collectionView.register(TitleHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderCollectionReusableView.identifire)
        
        
    }
    //MARK: - Create Layout Sections Methods
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
                    heightDimension: .absolute(300)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 5, trailing: 25)
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(400),
                    heightDimension: .absolute(300)),
                subitem: item,
                count: 1)
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(400),
                    heightDimension: .absolute(300)),
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


extension HomeScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        let type = sections[section]
        //        switch type {
        //        case .section1(let viewModels):
        //            return 5
        //        case .section2(let viewModels):
        //            return 5
        //        case .section3(let viewModels):
        //            return 5
        //        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        let type = sections[indexPath.section]
        //        switch type {
        //        case .section1(model: let model):
        //            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:NewSongReusebleViewCell.identifire , for: indexPath) as? NewSongReusebleViewCell else {
        //                return UICollectionViewCell()
        //            }
        //            return cell
        //        case .section2(model: let model):
        //            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:NewSongReusebleViewCell.identifire , for: indexPath) as? NewSongReusebleViewCell else {
        //                return UICollectionViewCell()
        //            }
        //            return cell
        //        case .section3(model: let model):
        //            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:NewSongReusebleViewCell.identifire , for: indexPath) as? NewSongReusebleViewCell else {
        //                return UICollectionViewCell()
        //            }
        //            return cell
        //        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:NewSongReusebleViewCell.identifire , for: indexPath) as? NewSongReusebleViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        <#code#>
    //    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleHeaderCollectionReusableView.identifire, for: indexPath) as? TitleHeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        //let headerTitle = sections[indexPath.section].title
        header.configure(with:  "New Songs" )
        return header
    }
    
    
}
