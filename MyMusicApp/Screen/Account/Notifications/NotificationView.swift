//
//  NotificationView.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-23.
//

import UIKit

final class NotificationView: UIView {
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        configureElements()
        setupConstraints()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NotificationView {
    
    func setupTableView() {
        tableView.register(NotificationCell.self, forCellReuseIdentifier: "NotificationCell")
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .maLightGray
        tableView.backgroundColor = .maBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureElements() {
    }
    
    private func setupViews() {
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
}
