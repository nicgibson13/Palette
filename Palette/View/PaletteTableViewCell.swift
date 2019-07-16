//
//  PaletteTableViewCell.swift
//  Palette
//
//  Created by Nic Gibson on 7/16/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class PaletteTableViewCell: UITableViewCell {
    
    var photo: UnsplashPhoto? {
        didSet {
            updateViews()
        }
    }
    
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpViews()
    }

    // MARK: - Class methods
    func updateViews() {
        guard let photo = photo else {return}
        fetchAndSetImage(for: photo)
        fetchAndSetColors(for: photo)
        paletteTitleLabel.text = photo.description
    }
    
    func fetchAndSetImage(for photo: UnsplashPhoto) {
        UnsplashService.shared.fetchImage(for: photo) { (image) in
            DispatchQueue.main.async {
                self.paletteImageView.image =  image
            }
        }
    }
    
    func fetchAndSetColors(for photo: UnsplashPhoto) {
        ImaggaService.shared.fetchColorsFor(imagePath: photo.urls.regular) { (colors) in
            DispatchQueue.main.async {
                guard let colors = colors else {return}
                self.colorPaletteView.colors = colors
            }
        }
    }
    
    // Step three
    func setUpViews() {
        addAllSubViews()
        let imageWidth = (contentView.frame.width - (SpacingConstants.outerHorizontalPadding * 2))
        paletteImageView.anchor(top: contentView.topAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, topPadding: SpacingConstants.outerVerticalPadding, bottomPadding: 0, leadingPadding: SpacingConstants.outerHorizontalPadding, trailingPadding: -SpacingConstants.outerHorizontalPadding, width: imageWidth, height: imageWidth)
        
        paletteTitleLabel.anchor(top: paletteImageView.bottomAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, topPadding: SpacingConstants.verticalObjectBuffer, bottomPadding: 0, leadingPadding: SpacingConstants.outerHorizontalPadding, trailingPadding: -SpacingConstants.outerHorizontalPadding, width: nil, height: SpacingConstants.oneLineElementHeight)
        
        colorPaletteView.anchor(top: paletteTitleLabel.bottomAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, topPadding: SpacingConstants.verticalObjectBuffer, bottomPadding: SpacingConstants.outerVerticalPadding, leadingPadding: SpacingConstants.outerHorizontalPadding, trailingPadding: -SpacingConstants.outerHorizontalPadding, width: nil, height: SpacingConstants.twoLineElementHeight)
        
        colorPaletteView.clipsToBounds = true
        colorPaletteView.layer.cornerRadius = (SpacingConstants.twoLineElementHeight / 2)
    }
    
    // MARK: - Subviews
    
    
    // Step two
    func addAllSubViews() {
        self.addSubview(paletteImageView)
        self.addSubview(paletteTitleLabel)
        self.addSubview(colorPaletteView)
    }
    
    lazy var paletteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = (contentView.frame.height / 50)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // Step one
    lazy var paletteTitleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var colorPaletteView: ColorPaletteView = {
        let paletteView = ColorPaletteView()
        return paletteView
    }()
    
}
