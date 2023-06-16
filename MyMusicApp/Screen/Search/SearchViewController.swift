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
    
    private let categories = ["Top searching", "Artist", "Album", "Songs", "Playlist"]
    private var selectedCategoryIndex: Int?
    private var showAllCategories = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCollectionTableViews()
        setupFirstCell()
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
    }
    
    @objc private func backToHome() {
        dismiss(animated: true)
    }
    
    private func setupFirstCell() {
        DispatchQueue.main.async {
            self.selectFirstCollectionViewCell()
        }
    }
    
    private func selectFirstCollectionViewCell() {
        let indexPath = IndexPath(item: 0, section: 0)
        searchView.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
        collectionView(searchView.collectionView, didSelectItemAt: indexPath)
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
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell else { return }
        
        cell.configureCellWithSelect()
        
        if indexPath.row == 0 {
            selectedCategoryIndex = nil
            showAllCategories = true
        } else {
            selectedCategoryIndex = indexPath.row
            showAllCategories = false
        }
        
        searchView.tableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell else { return }
        
        cell.configureCellWithoutSelect()
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchView.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        cell.configureCell(image: UIImage(named: "firstOnboarding") ?? nil,
                           firstText: "Madonna",
                           secondText: "Андрей Малахов")
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
