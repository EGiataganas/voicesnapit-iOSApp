//
//  Settings.swift
//  VoiceSnapIT
//
//  Created by Evangelos Giataganas on 10/12/2017.
//  Copyright © 2017 Evangelos Giataganas. All rights reserved.
//

import UIKit

enum Settings {
    case takePicturesAutomatically
    case useRekognition
    
    func title() -> String {
        switch self {
        case .takePicturesAutomatically:
            return "Take pictures automatically"
        case .useRekognition:
            return "Use Amazon Rekognition"
        }
    }
    
    func key() -> String {
        switch self {
        case .takePicturesAutomatically:
            return "automatic_pictures"
        case .useRekognition:
            return "use_rekognition"
        }
    }
}
