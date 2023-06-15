//
//  TableViewHeader.swift
//  MyMusicApp
//
//  Created by Dmitry Medvedev on 15.06.2023.
//

import UIKit
import SnapKit

final class TableViewHeader: UITableViewHeaderFooterView {
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Top searching"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .maBackground
        addSubview(headerLabel)
        setupConstraints()
    }
    
    func configure(text: String) {
        headerLabel.text = text
    }
    
    private func setupConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.centerY.equalToSuperview()
        }
    }
}
