//
//  ImaggaRoute.swift
//  Palette
//
//  Created by DevMountain on 4/2/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import Foundation
import UIKit.UIImage

enum ImaggaRoute {
    
    typealias HTTPMethod = String
    
    case colors(String)
    case upload(UIImage)
    
    var method: HTTPMethod {
        switch self {
        case .upload:
            return "POST"
        case .colors:
            return "GET"
        }
    }
    
    var path: String {
        switch self {
        case .upload:
            return "/uploads"
        case .colors:
            return "/colors"
        
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .colors(let contentID):
            return ["content": contentID, "extract_object_colors": 0]
        case.upload(let image):
            guard let imageData = image.jpegData(compressionQuality: 0.2) else {return [:]}
            let imgString = imageData.base64EncodedData()
            return ["image_base64" : imgString]
        }
    }
    
    var bodyData: Data? {
        do {
            let bodyData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            return bodyData
        }catch {
            print("There was as error in \(#function) :  \(error) \(error.localizedDescription)")
            return nil
        }
        
    }
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: "") else { return nil }
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method
        request.httpBody = bodyData
//        request.setValue(ImaggaRoute.authenticationToken, forHTTPHeaderField: "Authorization")
        return request
    }
}
