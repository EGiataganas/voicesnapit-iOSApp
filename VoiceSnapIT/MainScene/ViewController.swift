//
//  ViewController.swift
//  VoiceSnapIT
//
//  Created by Evangelos Giataganas on 29/10/2017.
//  Copyright © 2017 Evangelos Giataganas. All rights reserved.
//

import UIKit

private let buttonMarginSpace = 10
private let buttonSize = 50

final class ViewController: UIViewController {
    lazy var viewModel: ViewModel = {
       return ViewModel()
    }()
    
    lazy var settingButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "settings-icon"), style: .plain, target: self, action: #selector(ViewController.settingButtonPressed))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        viewModel.setup(view: view)
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.viewTapped))
        tapRecognizer.delegate = self
        tapRecognizer.numberOfTapsRequired = 2
        tapRecognizer.cancelsTouchesInView = true
        view.addGestureRecognizer(tapRecognizer)
        
        viewModel.startPicturesTimerIfNeeded()
    }
    
    @objc func settingButtonPressed() {
        navigationController?.show(SettingsViewController(), sender: nil)
    }
    
    private func setupViews() {
        title = "Voice Snap It"
        navigationItem.rightBarButtonItem = settingButton
    }
    
    @objc func viewTapped() {
        viewModel.takePicture()
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
