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
    static let baseURLPath = "http://api.imagga.com/v2"
    static let authenticationToken = "Basic YWNjXzJmODQ2NWFjYmM2NzQxMDo3Y2Y4ODFjNDViOGI0YzE0YmE4YmY4NWNiMmE3ZTczMw=="
    
    var uploadSession: URLSession

    init(sessionDelegate: URLSessionDelegate? = nil) {
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
    
    func fetchColorsFor(imagePath: String, completion: @escaping ([UIColor]?) -> Void){
        guard let url = URL(string: ImaggaService.baseURLPath)?.appendingPathComponent("colors") else { completion(nil) ; return }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "image_url", value: imagePath)]
        guard let finalUrl = components?.url else { completion(nil) ; return }
        var request = URLRequest(url: finalUrl)
        request.addValue(ImaggaService.authenticationToken, forHTTPHeaderField: "Authorization")
        print(request.url?.absoluteString ?? "Nope")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion(nil)
                return
            }
            guard let data = data else {completion(nil) ; return}
            
            do{
                let decoder = JSONDecoder()
                let imaggaColorResponse = try decoder.decode(ImaggaColorResponse.self, from: data)
                let imaggaColors = imaggaColorResponse.result.colors.imaggaColors
                let colors = imaggaColors.compactMap{ UIColor($0) }
                completion(colors)
            }catch {
                print("There was as error in \(#function) :  \(error) \(error.localizedDescription)")
                completion(nil)
            }
            }.resume()
    }
}
