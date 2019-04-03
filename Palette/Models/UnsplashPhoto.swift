//
//  UnsplashPhoto.swift
//  Palette
//
//  Created by DevMountain on 4/2/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import Foundation

struct UnsplashPhoto: Decodable {
    
    let urls: URLGroup
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case urls
        case description = "alt_description"
    }
}

struct URLGroup: Decodable {
    let small: String
}

