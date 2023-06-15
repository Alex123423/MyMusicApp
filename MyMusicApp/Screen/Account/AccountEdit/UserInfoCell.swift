//
//  accountInfoCell.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-15.
//

import UIKit

class UserInfoCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let textField = UITextField()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        backgroundColor = .maDarkGray
        // Configure label appearance
        // ...

        // Configure text field appearance
        // ...
    }

    private func setupConstraints() {
        // Add and configure constraints for the label and text field
        // ...
    }
}
