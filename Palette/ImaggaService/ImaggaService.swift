//
//  ImaggaService.swift
//  Palette
//
//  Created by DevMountain on 4/2/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class ImaggaService{
    
    //MARK: - Properties
    let baseUrl = "https://api.imagga.com/v2/"
    var uploadSession: URLSession

    init(sessionDelegate: URLSessionDelegate?) {
        self.uploadSession = URLSession(configuration: .default, delegate: sessionDelegate, delegateQueue: nil)
    }
    
    func beginUploadToImagga(_ photo: UIImage, completion: @escaping (_ uploadId: String?) -> Void) {
        let uploadRoute: ImaggaRoute = .upload(photo)
        guard let request = uploadRoute.urlRequest else { completion(nil) ; return }
        print(request.url?.absoluteURL ?? "No URL")
        let uploadTask = URLSession.shared.uploadTask(with: request, from: nil) { (data, response, error) in
            if let error = error{
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion(nil)
                return
            }
            guard let data = data else {
                print(response?.description ?? "No Response")
                completion(nil)
                return
            }
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(jsonObject)
                let imaggaResponse = try JSONDecoder().decode(ImaggaUploadResponse.self, from: data)
                let uploadId = imaggaResponse.result.uploadId
                completion(uploadId)
            }catch {
                print("There was as error in \(#function) :  \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
        }
        uploadTask.resume()
    }
}

