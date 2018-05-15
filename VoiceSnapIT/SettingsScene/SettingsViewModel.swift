//
//  SettingsViewModel.swift
//  CustomCamera
//
//  Created by Evangelos Giataganas on 10/12/2017.
//  Copyright © 2017 Evangelos Giataganas. All rights reserved.
//

import QuickTableViewController

class SettingsViewModel {
    var settingsStorage = SettingsStorage()
    
    private let settingObjects: [Settings] = [.takePicturesAutomatically, .useRekognition]
    
    lazy var items: [Section] = {
        let action: ((Row) -> Void) = { [weak self] (row) in
            if let row = row as? SwitchRow<SwitchCell> {
                self?.handleChange(row: row)
            }
        }
        
        let rows = self.settingObjects.map { SwitchRow<SwitchCell>(title: $0.title(), switchValue: settingsStorage[$0], action: action) }
        
        return [Section(title: "", rows: rows)]
    }()
    
    func handleChange(row: SwitchRow<SwitchCell>) {
        if let object = settingObjects.first(where: { $0.title() == row.title }) {
            settingsStorage[object] = row.switchValue
        }
    }
}
