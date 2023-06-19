//
//  accountInfoCell.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-15.
//

import UIKit

protocol DatePickerDelegate: AnyObject {
    func didDatePickerValueChanged(datePicker: UIDatePicker)
}

final class UserInfoCell: UITableViewCell {
    
    weak var delegate: DatePickerDelegate?
    
    var titleLabel = UILabel()
    var textField = UITextField()
    var datePicker = UIDatePicker()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        configureElements()
        configureDatePicker()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func datePickerValueChanged(_ datePicker: UIDatePicker) {
        delegate?.didDatePickerValueChanged(datePicker: datePicker)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        textField.text = dateFormatter.string(from: datePicker.date)
    }
    
    private func configureDatePicker() {
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.frame.size = CGSize(width: 0, height: 100)
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }
    
    func configureCell(titleText: String, textFieldText: String) {
        self.titleLabel.text = titleText
        self.textField.text = textFieldText
    }
}

extension UserInfoCell {
    
    private func setupViews() {
        addSubview(titleLabel)
        contentView.addSubview(textField)
    }
    
    private func configureElements() {
        backgroundColor = .maDarkGray
        selectionStyle = .none
        titleLabel.textColor = .maLightGray
        titleLabel.font = CommonConstant.FontSize.font14
        textField.font = CommonConstant.FontSize.font14
        textField.textColor = .white
        textField.textAlignment = .right
        textField.returnKeyType = .done
        textField.autocapitalizationType = .none
        
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
            textField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5),
            textField.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
        ])
    }
}
