//
//  NewTestVC.swift
//  MyMusicApp
//
//  Created by Borisov Nikita on 20.06.2023.

import UIKit
import SnapKit

class NewTestVC: UIView {
    
    var tabBarDelegate : TabBarViewControllerDelegate?
    
    let homeScreen = HomeScreenViewController()
    
    var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        let image = UIImage(named: "drag")
        button.setImage(image, for: .normal)
        button.layer.masksToBounds = true
        button.alpha = 0.5
        button.tintColor = .white
        return button
    }()
    
    let miniView: UIView = {
        let stack = UIView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = UIColor(named: CommonConstant.Color.greenPlayer)
        return stack
    }()
    
    private let lineView: UIView = {
        let stack = UIView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .black
        return stack
    }()
    
    private let songTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Come to me"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.5150605259)
        button.layer.cornerRadius = 25
        let image = UIImage(named: "Playing")
        button.setImage(image, for: .normal)
        button.layer.masksToBounds = true
        button.tintColor = .black
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.5150605259)
        button.layer.cornerRadius = 25
        let image = UIImage(named: "skip_next")
        button.setImage(image, for: .normal)
        button.layer.masksToBounds = true
        button.tintColor = .black
        return button
    }()
    
    private let pictureSong: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        image.image = UIImage(named: "songImage")
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 120
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray2
        configureView()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGestures() {
        miniView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(miniViewDidTap)))
        
        miniView.addGestureRecognizer(UIPanGestureRecognizer(
            target: self,
            action: #selector(handlePan)))
        
        addGestureRecognizer(UIPanGestureRecognizer(
            target: self,
            action: #selector(handleDismissalPan)))
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            print("")
        case .changed:
            handlePanChanged(gesture: gesture)
        case .ended:
            handlePanEnded(gesture: gesture)
        @unknown default:
            print("")
        }
    }
    
    func handlePanChanged(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        self.transform = CGAffineTransform(translationX: 0, y: translation.y)
        
        let newAlpha = 1 + translation.y / 200
        self.miniView.alpha = newAlpha < 0 ? 0 : newAlpha
        // тут мы подставим вьюху основного экрана
        //self.maxizedStackView.alpha = -translation.y / 200
    }
    
    func handlePanEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        let velocity = gesture.velocity(in: self.superview)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.transform = .identity
            if translation.y < -200 || velocity.y < -500 {
                self.tabBarDelegate?.maximizeTopAnchorConstraintFunc()
            } else {
                self.miniView.alpha = 1
                // тут мы подставим вьюху основного экрана
                //self.maxizedStackView.alpha = 0
            }
        }, completion: nil)
    }
    
    @objc func handleDismissalPan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            let translation = gesture.translation(in: self.superview)
            //тут экран Даниила
            self.transform = CGAffineTransform(translationX: 0, y: translation.y)
        case .ended:
            let translation = gesture.translation(in: self.superview)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                //тут экран Даниила
                self.transform = .identity
                if translation.y > 50 {
                    self.tabBarDelegate?.minimazedTopAnchorConstraintFunc()
                }
            }, completion: nil)
        @unknown default:
            print("unknown default")
        }
    }
    
    @objc func miniViewDidTap() {
        self.tabBarDelegate?.maximizeTopAnchorConstraintFunc()
    }
    
    @objc func closeDidTap() {
        
        if tabBarDelegate == nil {
            print("fuck you NIL")
        } else {
            self.tabBarDelegate?.minimazedTopAnchorConstraintFunc()
        }
    }
    
    func configureView() {
        
        addSubview(button)
        addSubview(miniView)
        miniView.addSubview(lineView)
        miniView.addSubview(songTitle)
        miniView.addSubview(playButton)
        miniView.addSubview(nextButton)
        miniView.addSubview(pictureSong)
        
        button.addTarget(self, action: #selector(closeDidTap), for: .touchUpInside)
        
        miniView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(70)
            make.left.right.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(-1)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        playButton.snp.makeConstraints { make in
            make.right.equalTo(nextButton).inset(65)
            make.height.width.equalTo(50)
            make.centerY.equalTo(miniView)
        }
        
        nextButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(25)
            make.height.width.equalTo(50)
            make.centerY.equalTo(miniView)
        }
        
        songTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(100)
            make.centerY.equalTo(miniView)
        }
        
        pictureSong.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(25)
            make.height.width.equalTo(50)
            make.centerY.equalTo(miniView)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(30)
        }
    }
    
}

