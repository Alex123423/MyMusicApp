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
    
    let playView = SongPlayerViewController()
    
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
    
    private let songTitles: UILabel = {
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
        button.setImage(SongConstant.Symbol.pauseButton, for: .normal)
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
    
    private let pictureSongs: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        image.image = UIImage(named: "songImage")
        image.contentMode = .scaleToFill
        //image.layer.masksToBounds = true
        image.layer.cornerRadius = 120
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .maBackground
        playView.view.translatesAutoresizingMaskIntoConstraints = false
        configureView()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSongPlayerView(sender: Album) {
        playView.currentAlbum = sender
        songTitles.text = sender.trackName
        pictureSongs.kf.setImage(with: URL(string: sender.artworkUrl60 ?? ""))
        playView.songPlayer.artistTitle.text = sender.artistName
        playView.songPlayer.songTitle.text = sender.trackName
        playView.playTrack(prewiewUrl: sender.previewUrl)
        playView.prewiewUrlTrack = sender.previewUrl ?? ""
        guard let UirlString600 = (sender.artworkUrl60?.replacingOccurrences(of: "60x60", with: "600x600")) else { return }
        guard let artworkURL = URL(string: UirlString600) else { return }
        playView.songPlayer.pictureSong.kf.setImage(with: artworkURL)
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
        self.playView.view.alpha = -translation.y / 200
    }
    
    func handlePanEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        let velocity = gesture.velocity(in: self.superview)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.transform = .identity
            if translation.y < -200 || velocity.y < -500 {
                self.tabBarDelegate?.maximizeTopAnchorConstraintFunc(model: nil)
            } else {
                self.miniView.alpha = 1
                // тут мы подставим вьюху основного экрана
                self.playView.view.alpha = 0
            }
        }, completion: nil)
    }
    
    @objc func handleDismissalPan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            let translation = gesture.translation(in: self.superview)
            //тут экран Даниила
            self.playView.view.transform = CGAffineTransform(translationX: 0, y: translation.y)
        case .ended:
            let translation = gesture.translation(in: self.superview)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                //тут экран Даниила
                self.playView.view.transform = .identity
                if translation.y > 50 {
                    self.tabBarDelegate?.minimazedTopAnchorConstraintFunc()
                }
            }, completion: nil)
        @unknown default:
            print("unknown default")
        }
    }
    
    @objc func miniViewDidTap() {
        self.tabBarDelegate?.maximizeTopAnchorConstraintFunc(model: nil)
    }
    
    @objc func closeDidTap() {
        
        if tabBarDelegate == nil {
            print("fuck you NIL")
        } else {
            self.tabBarDelegate?.minimazedTopAnchorConstraintFunc()
        }
    }
    
    @objc func playDidTapped(){
        if playView.player.timeControlStatus == .playing {
            playButton.setImage(SongConstant.Symbol.playButton, for: .normal)
            print("play")
            playView.playPause()
        } else if playView.player.timeControlStatus == .paused {
            print("pause")
            playButton.setImage(SongConstant.Symbol.pauseButton, for: .normal)
            playView.playPause()
        }
        
    }
    
    func configureView() {
        
        addSubview(playView.view)
        addSubview(button)
        addSubview(miniView)
        miniView.addSubview(lineView)
        miniView.addSubview(songTitles)
        miniView.addSubview(playButton)
        miniView.addSubview(nextButton)
        miniView.addSubview(pictureSongs)
        
        button.addTarget(self, action: #selector(closeDidTap), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(playDidTapped), for: .touchUpInside)
        
        miniView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(70)
            make.left.right.equalToSuperview()
        }
        
        playView.view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
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
        
        songTitles.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(100)
            make.centerY.equalTo(miniView)
            make.width.equalTo(125)
        }
        
        pictureSongs.snp.makeConstraints { make in
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

