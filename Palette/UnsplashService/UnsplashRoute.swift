//
//  UnsplashRoute.swift
//  Palette
//
//  Created by DevMountain on 4/2/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import Foundation

enum UnsplashRoute {
    
    static let baseUrl = "https://api.unsplash.com/"
    static let clientId = "b9a4743e8c3fc2ff4cd6800bfeedfdcb40f2c803dd119a72eed7e626503b9daa"
    
    case random
    case featured
    
    var path: String {
        switch self {
        case .random:
            return "/photos/random"
        case .featured:
            return "/photos/"
        }
    }
    
    var fullUrl: URL? {
        guard let url = URL(string: UnsplashRoute.baseUrl)?.appendingPathComponent(path) else { return nil }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            URLQueryItem(name: "client_id", value: UnsplashRoute.clientId),
            URLQueryItem(name: "count", value: "15")
        
        ]
        return components?.url
    }
}
