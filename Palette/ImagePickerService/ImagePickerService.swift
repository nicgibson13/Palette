//
//  ImagePickerService.swift
//  Palette
//
//  Created by DevMountain on 4/2/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class ImagePickerService: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    weak var delegate: ImagePickerServiceDelegate?
    
    init(delegateViewController: ImagePickerServiceDelegate){
        self.delegate = delegateViewController
        super.init()
    }
    
    func presentImagePickerWith(alertTitle: String, message: String?){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let alert: UIAlertController!
        
        if UIDevice.current.userInterfaceIdiom == .phone{
            alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .actionSheet)
        }else{
            alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
                imagePicker.sourceType = .photoLibrary
                UIImagePickerController.availableMediaTypes(for: .photoLibrary)
                self.delegate?.present(imagePicker, animated: true, completion: nil)
            }))
        }
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
                imagePicker.sourceType = .camera
                imagePicker.cameraCaptureMode = .photo
                self.delegate?.present(imagePicker, animated: true, completion: nil)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.delegate?.present(alert, animated: true, completion: nil)
    }
    
    @objc public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        picker.dismiss(animated: true) {
            self.delegate?.imageSelected(photo)
        }
    }
}


protocol ImagePickerServiceDelegate: class where Self: UIViewController{
    
    func imageSelected(_ photo: UIImage)
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
}
