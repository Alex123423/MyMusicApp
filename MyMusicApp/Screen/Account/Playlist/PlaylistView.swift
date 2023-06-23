//
//  PlaylistView.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 15.06.2023.
//

import UIKit

class PlaylistView: UIView {
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "Playlist"
        label.textColor = .white
        label.font = CommonConstant.FontSize.fontBold18
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var searchTextField: UISearchTextField = {
        let textField = UISearchTextField()
        textField.placeholder = "Search"
        textField.tintColor = .white
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .white
        textField.returnKeyType = .search
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.maTextFieldBorder.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

}
