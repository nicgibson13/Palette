//
//  PaletteTableViewCell.swift
//  Palette
//
//  Created by DevMountain on 4/1/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class PaletteTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    var unsplashPhoto: UnsplashPhoto? {
        didSet{
           updateViews()
        }
    }
    
    override func layoutSubviews() {
        setUpViews()
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        colorPaletteView.colors = [UIColor.lightGray, UIColor.darkGray]
    }
    
    func updateViews(){
        guard let unsplashPhoto = unsplashPhoto else { return }
        fetchAndSetImage(for: unsplashPhoto)
        fetchAndSetColors(for: unsplashPhoto)
        paletteTitleLabel.text = unsplashPhoto.description
    }
    
    func fetchAndSetImage(for unsplashPhoto: UnsplashPhoto) {
        UnsplashService.shared.fetchImage(for: unsplashPhoto) { (image) in
            DispatchQueue.main.async {
                self.paletteImageView.image = image
            }
        }
    }
    
    func fetchAndSetColors(for unsplashPhoto: UnsplashPhoto) {
        ImaggaService().fetchColorsFor(imagePath: unsplashPhoto.urls.small) { (colors) in
            DispatchQueue.main.async { [unowned self] in
                guard let colors = colors else { return }
                self.colorPaletteView.colors = colors
            }
        }
    }
    
    func setUpViews(){
        addAllSubviews()
        paletteImageView.anchor(top: contentView.topAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, paddingTop: SpacingConstants.verticalObjectBuffer, paddingBottom: 0, paddingLeft: 16, paddingRight: 16, width: contentView.frame.width - 32, height: contentView.frame.width - 32)
        paletteTitleLabel.anchor(top: paletteImageView.bottomAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, paddingTop: SpacingConstants.verticalObjectBuffer, paddingBottom: 0, paddingLeft: 16, paddingRight: 16, width: nil, height: 24)
        colorPaletteView.anchor(top: paletteTitleLabel.bottomAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, paddingTop: SpacingConstants.verticalObjectBuffer, paddingBottom: SpacingConstants.verticalObjectBuffer, paddingLeft: 16, paddingRight: 16, width: nil, height: 24)
    }
    
    func addAllSubviews() {
        addSubview(paletteImageView)
        addSubview(paletteTitleLabel)
        addSubview(colorPaletteView)
    }
    
    //MARK: - Subviews
    lazy var paletteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var paletteTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 22)
        return label
    }()
    
    lazy var colorPaletteView: ColorPaletteView = {
        let paletteView = ColorPaletteView()
        return paletteView
    }()
}
