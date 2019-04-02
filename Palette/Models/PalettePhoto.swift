//
//  PalettePhoto.swift
//  Palette
//
//  Created by DevMountain on 4/1/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class PalettePhoto {
    let image: UIImage
    let description: String
    let uploadId: String
    
    init(image: UIImage, description: String, uploadId: String){
        self.image = image
        self.description = description
        self.uploadId = uploadId
    }
}
