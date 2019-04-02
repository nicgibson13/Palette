//
//  PallettePhotoController.swift
//  Palette
//
//  Created by DevMountain on 4/2/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import Foundation
import UIKit.UIImage

class PalettePhotoController {
    static let shared = PalettePhotoController()
    
    var photos: [PalettePhoto] = []
    
    func createPalletePhoto(image: UIImage, description: String, uploadId: String) {
        let palettePhoto = PalettePhoto(image: image, description: description, uploadId: uploadId)
        photos.append(palettePhoto)
    }
}
