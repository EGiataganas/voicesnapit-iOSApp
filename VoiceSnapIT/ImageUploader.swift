//
//  ImageUploader.swift
//  VoiceSnapIT
//
//  Created by Evangelos Giataganas on 29/10/2017.
//  Copyright © 2017 Evangelos Giataganas. All rights reserved.
//

import UIKit
import Alamofire

enum ImageUploaderResult {
    case success(string: String)
    case error
}

enum ImageAnalyserType {
    case analyzer
    case rekognition
}

struct ImageUploader {
    lazy var uploadManager: SessionManager = {
        return .default
    }()
    
    let uploadBaseURL = "http:/voicesnapit-dev.eu-west-1.elasticbeanstalk.com/"
    
    let analyzerEndpoint = "analyzer"
    let rekognitionEndpoint = "rekognition"
    
    func base64EncodedImage(fromImage image: UIImage) -> String {
        return UIImagePNGRepresentation(image)?.base64EncodedString() ?? ""
    }

    mutating func uploadImage(image: UIImage, analyserType: ImageAnalyserType, resultBlock: ((ImageUploaderResult)->())?) {
        let encodedImage = base64EncodedImage(fromImage: image)
        
        var url = uploadBaseURL
        url += analyserType == .rekognition ? rekognitionEndpoint : analyzerEndpoint
        
        uploadManager.request(url, method: .post, parameters: ["image":encodedImage]).validate(statusCode: 200..<300).response { (response) in
            if let data = response.data,
                let stringToRead = String.init(data: data, encoding: .utf8),
                response.error == nil {
                resultBlock?(.success(string: stringToRead))
            }
            else {
                resultBlock?(.error)
            }
        }
    }
}
