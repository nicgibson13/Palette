//
//  PaletteTabBarController.swift
//  Palette
//
//  Created by DevMountain on 4/1/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class PaletteTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let photosListNav = UINavigationController(rootViewController: PaletteListViewController())
        let imageUploadNav = UINavigationController(rootViewController: ImageUploadViewController())
        self.viewControllers = [photosListNav, imageUploadNav]
        
    }

}
