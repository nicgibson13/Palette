//
//  ImaggaUploadResponse.swift
//  Palette
//
//  Created by DevMountain on 4/2/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import Foundation

struct ImaggaUploadResponse: Codable {
    let result: UploadResult
    let status: UploadStatus
}

struct UploadResult: Codable {
    let uploadId: String
    
    enum CodingKeys: String, CodingKey {
        case uploadId = "upload_id"
    }
}

struct UploadStatus: Codable {
    let text: String
    let type: String
}
