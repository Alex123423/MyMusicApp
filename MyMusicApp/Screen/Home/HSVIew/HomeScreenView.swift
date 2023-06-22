//
//  HomeScreenView.swift
//  MyMusicApp
//
//  Created by Borisov Nikita on 16.06.2023.
//

import SnapKit
import UIKit

protocol HomeScreenViewDelegate: AnyObject {
    func homeScreenView(_ view: HomeScreenView, didTapSearchButton button: UIButton)
}

class HomeScreenView: UIView {
    
    weak var delegate: HomeScreenViewDelegate?
    
    var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { section,_ in
        return HomeScreenView.createSectionLayout(section: section)
    })
    )
    
    private let bigMusicLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 48)
        label.text = "Music"
        return label
    }()
    
    private let searcButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "search"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewFrame()
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func searchButtonDidTapped() {
        delegate?.homeScreenView(self, didTapSearchButton: searcButton)
        print("view")
    }
    
    private func configureViewFrame() {
        addSubview(bigMusicLbl)
        addSubview(searcButton)
        addSubview(collectionView)
        
        searcButton.addTarget(self, action: #selector(searchButtonDidTapped), for: .touchUpInside)
        
        bigMusicLbl.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
            make.left.equalToSuperview().inset(15)
        }
        searcButton.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerY.equalTo(bigMusicLbl)
            make.right.equalToSuperview().inset(20)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(bigMusicLbl).inset(60)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    //MARK: - CollectionView Settings
    func configureCollectionView() {
        collectionView.backgroundColor = .clear
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(NewSongReusebleViewCell.self, forCellWithReuseIdentifier: NewSongReusebleViewCell.identifire)
        collectionView.register(PopularAlbumCollectionViewCell.self, forCellWithReuseIdentifier: PopularAlbumCollectionViewCell.identifire)
        collectionView.register(RecentlyTrackCollectionViewCell.self, forCellWithReuseIdentifier: RecentlyTrackCollectionViewCell.identifire)
        collectionView.register(TitleHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderCollectionReusableView.identifire)
    }
}

//MARK: - Create Layout Sections Methods Extensions
extension HomeScreenView {
    
    static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
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

