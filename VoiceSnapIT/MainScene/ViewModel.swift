//
//  ViewModel.swift
//  VoiceSnapIT
//
//  Created by Evangelos Giataganas on 29/10/2017.
//  Copyright © 2017 Evangelos Giataganas. All rights reserved.
//

import CameraManager

let takePicturesAutomaticallyAWSMessage = "Take pictures automatically every 15 seconds using AWS Rekognition"
let takePicturesAutomaticallyMicrosoftMessage = "Take pictures automatically every 15 seconds using Microsoft Computer Vision API"
let doubleTapAWSMessage = "Double tap to take picture using AWS Rekognition"
let doubleTapMicrosoftMessage = "Double tap to take picture using Microsoft Computer Vision API"

class ViewModel {
    let cameraManager: CameraManager
    var imageUploader: ImageUploader
    let stringSynthesizer: StringSynthesizer
    var timer: Timer?
    let settingStorage = SettingsStorage()
    
    init(cameraManager: CameraManager = CameraManager(), imageUploader: ImageUploader = ImageUploader(), stringSynthesizer: StringSynthesizer = StringSynthesizer()) {
        self.cameraManager = cameraManager
        self.imageUploader = imageUploader
        self.stringSynthesizer = stringSynthesizer
    }
    
    func setup(view: UIView) {
        setupCameraManager(view: view)
        
        if settingStorage[.takePicturesAutomatically] && settingStorage[.useRekognition] {
            stringSynthesizer.synthesizeString(string: takePicturesAutomaticallyAWSMessage)
        } else if settingStorage[.takePicturesAutomatically] && !settingStorage[.useRekognition] {
            stringSynthesizer.synthesizeString(string: takePicturesAutomaticallyMicrosoftMessage)
        } else if !settingStorage[.takePicturesAutomatically] && settingStorage[.useRekognition] {
            stringSynthesizer.synthesizeString(string: doubleTapAWSMessage)
        } else if !settingStorage[.takePicturesAutomatically] && !settingStorage[.useRekognition] {
            stringSynthesizer.synthesizeString(string: doubleTapMicrosoftMessage)
        }
    }
    
    func startPicturesTimerIfNeeded() {
        if settingStorage[.takePicturesAutomatically] {
            timer = Timer.scheduledTimer(withTimeInterval: 15, repeats: true, block: { [weak self] (_) in
                self?.takePicture()
            })
        }
    }
    
    func takePicture() {
        self.cameraManager.capturePictureWithCompletion { [weak self] (image, error) in
            if let image = image {
                self?.upload(image: image)
            }
        }
    }
    
    fileprivate func upload(image: UIImage) {
        let imageAnalyserType: ImageAnalyserType = settingStorage[.useRekognition] ? .rekognition : .analyzer
        
        self.imageUploader.uploadImage(image: image, analyserType: imageAnalyserType, resultBlock: { [weak self] (result) in
            if case .success(let string) = result {
                self?.stringSynthesizer.synthesizeString(string: string)
            }
        })
    }
    
    fileprivate func setupCameraManager(view: UIView) {
        _ = self.cameraManager.addPreviewLayerToView(view)
        self.cameraManager.cameraDevice = .back
        self.cameraManager.writeFilesToPhoneLibrary = false
        self.cameraManager.showAccessPermissionPopupAutomatically = true
        self.cameraManager.cameraOutputQuality = .medium
    }
}
