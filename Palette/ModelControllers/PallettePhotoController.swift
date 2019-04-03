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
//
//    func fetchAndCreatePalettePhotos(for unsplashRoute: UnsplashRoute, completion: @escaping ([PalettePhoto]?) -> ()) {
//        UnsplashService.shared.fetchFromUnsplash(for: unsplashRoute) { (unsplashPhotos) in
//            guard let unsplashPhotos = unsplashPhotos else { return }
//            let group = DispatchGroup()
//            for photo in unsplashPhotos {
//                group.enter()
//                ImaggaService().fetchColorsFor(imagePath: photo.urls.small, completion: { (immaggaColors) in
//                    <#code#>
//                })
//            }
//        }
//    }
}
