//
//  SettingsStorage.swift
//  VoiceSnapIT
//
//  Created by Evangelos Giataganas on 10/12/2017.
//  Copyright © 2017 Evangelos Giataganas. All rights reserved.
//

import UIKit
import Foundation

struct SettingsStorage {
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    subscript(setting: Settings) -> Bool {
        get {
            return userDefaults.bool(forKey: setting.key())
        }
        set {
            return userDefaults.set(newValue, forKey: setting.key())
        }
    }
}
