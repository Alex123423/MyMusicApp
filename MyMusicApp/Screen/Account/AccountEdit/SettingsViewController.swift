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
    private let authManager = AuthManager.shared
    private let userCell = UserInfoCell()
    
    private var selectedImage: UIImage? {
        didSet {
            settingsView.avatarImageView.image = selectedImage
//            if let imageData = selectedImage?.pngData() {
                let resizedImage = selectedImage?.resizedImage(to: CGSize(width: 200, height: 200)) // Adjust the size as needed
                // Compress the image as JPEG data
                guard let compressedData = resizedImage?.jpegData(compressionQuality: 0.8) else {
                    return
                }
                realmManager.updateAvatarImageData(compressedData)
//            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUIForCurrentUser(button: settingsView.changePassButton)
    }
    
    //for hiding ChangePass button
    func updateUIForCurrentUser(button: UIButton) {
        if authManager.getCurrentEmailUser() != nil {
            // User is an email user
            button.isHidden = false
        } else {
            // User is not logged in
            button.isHidden = true
        }
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
            cell.textField.delegate = self
        case 1:
            cell.configureCell(titleText: "Email", textFieldText: realmManager.currentRealmUser?.email ?? "Not set")
            cell.textField.delegate = self
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

//MARK: - TextField Delegates

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let cell = textField.superview?.superview as? UserInfoCell,
              let indexPath = settingsView.userInfoTableView.indexPath(for: cell) else {
            return
        }
        
        switch indexPath.row {
        case 0: // Username text field
            if let newUsername = cell.textField.text {
                realmManager.updateUsername(username: newUsername)
            }
        case 1: // Email text field
            if let newEmail = cell.textField.text {
                authManager.updateEmail(with: newEmail, presenterVC: self)
            }
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - SettingsView delegates

extension SettingsViewController: SettingsViewDelegate {
    
    func settingsView(_ view: SettingsView, didTapchangePassButton button: UIButton) {
        let changePassVC = ChangePassViewController()
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        navigationController?.pushViewController(changePassVC, animated: true)
    }
    
    //Gender selection
    func settingsView(_ view: SettingsView, didSelectGenderRow row: Int) {
        let indexPath = IndexPath(row: 2, section: 0)
        
        if let cell = settingsView.userInfoTableView.cellForRow(at: indexPath) as? UserInfoCell {
            if row == 0 {
                cell.textField.text = "Male"
                realmManager.updateGender(gender: cell.textField.text ?? "Not set")
            } else {
                cell.textField.text = "Female"
                realmManager.updateGender(gender: cell.textField.text ?? "Not set")
            }
        }
    }
    
    func settingsView(_ view: SettingsView, didTapcameraButton button: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        
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
        if let originalImage = info[.originalImage] as? UIImage {
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

extension UIImage {
    func resizedImage(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
