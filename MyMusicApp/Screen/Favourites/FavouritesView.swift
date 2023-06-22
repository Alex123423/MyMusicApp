//
//  FavouritesView.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 19.06.2023.
//

import UIKit
import SnapKit

final class FavouritesView {
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "Favourites"
        label.textColor = .white
        label.font = CommonConstant.FontSize.fontBold18
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

}
