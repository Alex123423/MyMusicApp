//
//  accountInfoCell.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-15.
//

import UIKit

final class UserInfoCell: UITableViewCell {
    
     let titleLabel = UILabel()
    var textField = UITextField()
    var datePicker = UIDatePicker()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        configureElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(titleLabel)
        contentView.addSubview(textField)
    }
    
    private func showDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.frame.size = CGSize(width: 0, height: 100)
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)

        textField.inputView = datePicker
    }
    
    @objc private func datePickerValueChanged(_ datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        textField.text = dateFormatter.string(from: datePicker.date)
    }
    
    func configureElements() {
        textField.delegate = self
        backgroundColor = .maDarkGray
        selectionStyle = .none
        titleLabel.textColor = .maLightGray
        titleLabel.font = CommonConstant.FontSize.font14
        textField.font = CommonConstant.FontSize.font14
        textField.textColor = .white
        textField.contentMode = .right
        
        let placeholderText = "Some text"
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: CommonConstant.FontSize.font14
        ]
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                             attributes: placeholderAttributes)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            textField.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 5),
        ])
    }
}

extension UserInfoCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField === self.textField && titleLabel.text == "Date of birth" {
            showDatePicker()
        }
    }
}
