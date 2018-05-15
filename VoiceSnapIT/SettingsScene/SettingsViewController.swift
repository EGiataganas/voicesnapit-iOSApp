//
//  SettingsViewController.swift
//  CustomCamera
//
//  Created by Evangelos Giataganas on 10/12/2017.
//  Copyright © 2017 Evangelos Giataganas. All rights reserved.
//

import QuickTableViewController

class SettingsViewController: QuickTableViewController {

    let viewModel = SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableContents = viewModel.items
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
