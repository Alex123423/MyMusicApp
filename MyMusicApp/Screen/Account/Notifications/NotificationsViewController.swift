//
//  NotificationsViewController.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-13.
//

import UIKit

final class NotificationsViewController: UIViewController {
    
    private let notificationView = NotificationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setupViews()
        setupConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(NotificationsManager.receivedNotifications)
    }
}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NotificationsManager.receivedNotifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        let notification = NotificationsManager.receivedNotifications[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short

        let dateString = dateFormatter.string(from: notification.date)
        cell.configureCell(trackName: notification.titleText, artistname: notification.bodyText, date: dateString)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 + 15
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            NotificationsManager.receivedNotifications.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            
        }
    }
}

extension NotificationsViewController {
    func setDelegates() {
        notificationView.tableView.delegate = self
        notificationView.tableView.dataSource = self
    }
    
    private func setupViews() {
        view.backgroundColor = .maBackground
        view.addSubview(notificationView)
    }
    
    private func setupConstraints() {
        notificationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notificationView.topAnchor.constraint(equalTo: view.topAnchor),
            notificationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            notificationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            notificationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
