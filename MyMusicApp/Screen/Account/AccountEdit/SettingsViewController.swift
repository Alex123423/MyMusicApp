//
//  SettingsViewController.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-13.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private let settingsView = SettingsView()
    private let imagePicker = UIImagePickerController()
    private let realmManager = RealmManager.shared
    private let userCell = UserInfoCell()

    private var selectedImage: UIImage? {
        didSet {
            settingsView.avatarImageView.image = selectedImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setDelegates()
    }
}

//MARK: - TableView DataSource and Delegate

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell", for: indexPath) as! UserInfoCell
        cell.delegate = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        switch indexPath.row {
        case 0:
            cell.configureCell(titleText: "Username", textFieldText: realmManager.currentRealmUser?.name ?? "Not set")
        case 1:
            cell.configureCell(titleText: "Email", textFieldText: realmManager.currentRealmUser?.email ?? "Not set")
        case 2:
            cell.configureCell(titleText: "Gender", textFieldText: realmManager.currentRealmUser?.gender ?? "Not set")
            cell.textField.inputView = settingsView.pickerView
        case 3:
            cell.textField.inputView = cell.datePicker
            if let dateOfBirth = RealmManager.shared.currentRealmUser?.dateBirth {
                let dateString = dateFormatter.string(from: dateOfBirth)
                cell.configureCell(titleText: "Date of birth", textFieldText: dateString)
            } else {
                cell.configureCell(titleText: "Date of birth", textFieldText: "Not set")
            }
        default:
            break
        }
        return cell
    }
}

//MARK: - Buttons' delegates

extension SettingsViewController: SettingsViewDelegate {
    
    func settingsView(_ view: SettingsView, didTapchangePassButton button: UIButton) {
        let changePassVC = ChangePassViewController()
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        navigationController?.pushViewController(changePassVC, animated: true)
    }
    
    func settingsView(_ view: SettingsView, didTapcameraButton button: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Choose from Gallery", style: .default) { _ in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        })
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default) { _ in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = button
            popoverController.sourceRect = button.bounds
        }
        present(actionSheet, animated: true, completion: nil)
    }
}

//MARK: - Image Picker delegates

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK: - DatePickerView Delegate

extension SettingsViewController: DatePickerDelegate {
    func didDatePickerValueChanged(datePicker: UIDatePicker) {
        RealmManager.shared.updateDateOfBirth(dateOfBirth: datePicker.date)
    }
}

extension SettingsViewController {
    
    private func setDelegates() {
        settingsView.delegate = self
        settingsView.userInfoTableView.delegate = self
        settingsView.userInfoTableView.dataSource = self
    }
    
    private func setupViews() {
        view.backgroundColor = .maBackground
        view.addSubview(settingsView)
    }
    
    private func setupConstraints() {
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: view.topAnchor),
            settingsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
