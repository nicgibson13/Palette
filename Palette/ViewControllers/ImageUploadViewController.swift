//
//  ImageUploadViewController.swift
//  Palette
//
//  Created by DevMountain on 4/2/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class ImageUploadViewController: UIViewController{
    
    var imagePickerService: ImagePickerService!
    var imaggaService: ImaggaService!
    var uploadProgress: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        imagePickerService = ImagePickerService(delegateViewController: self)
        imaggaService = ImaggaService(sessionDelegate: self)
        uploadButton.addTarget(self, action: #selector(selectNewImage), for: .touchUpInside)
    }
    
    @objc func selectNewImage() {
        imagePickerService.presentImagePickerWith(alertTitle: "Select an image for upload", message: "We'll show it to you in a table view with some colors")
    }
    
    func updateProgressView(){
        uploadProgressView.setProgress(uploadProgress, animated: true)
    }
    
    
    //MARK: - View Setup
    override func loadView() {
        super.loadView()
        addAllSubViews()
        constrainViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        constrainViews()
    }
    
    func addAllSubViews() {
        view.addSubview(uploadImageView)
        view.addSubview(uploadButton)
        view.addSubview(uploadProgressView)
    }
    
    func constrainViews(){
        constrainUploadImageView()
        constrainUploadButton()
        constrainUploadProgressView()
    }
    
    func constrainUploadImageView() {
        uploadImageView.translatesAutoresizingMaskIntoConstraints = false
        uploadImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        uploadImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        uploadImageView.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 32, paddingRight: 32, width: 200, height: 200)
        
//        uploadImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        uploadImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        uploadImageView.heightAnchor.constraint(equalToConstant: 200)
//        uploadImageView.widthAnchor.constraint(equalToConstant: 200)
    }
    
    func constrainUploadButton() {
        uploadButton.anchor(top: uploadImageView.bottomAnchor, bottom: nil, leading: uploadImageView.leadingAnchor, trailing: uploadImageView.trailingAnchor, paddingTop: 16, paddingBottom: 0, paddingLeft: 0, paddingRight: 0)
    }
    
    func constrainUploadProgressView() {
        uploadProgressView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 32, paddingBottom: 0, paddingLeft: 32, paddingRight: 32, width: nil, height: nil)
    }
    
    lazy var uploadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Upload An Image", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    lazy var uploadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    lazy var uploadProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progress = 0
        progressView.tintColor = .blue
        progressView.backgroundColor = .lightGray
        return progressView
    }()
}

extension ImageUploadViewController: ImagePickerServiceDelegate {
    func imageSelected(_ photo: UIImage) {
        self.uploadImageView.image = photo
        imaggaService.beginUploadToImagga(photo) { (uploadId) in
            guard let uploadId = uploadId else {
                print("NO UPLOAD ID")
                return
            }
            let photo = PalettePhoto(image: photo, description: "Boom goes the dynamite", uploadId: uploadId)
            print(photo)
        }
    }
}

extension ImageUploadViewController: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        let uploadProgress = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
        self.uploadProgress = uploadProgress
        updateProgressView()
    }
}
