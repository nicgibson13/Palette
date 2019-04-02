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
    var palletPhoto: PalettePhoto? {
        didSet{
           updateViews()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        print("Begin 🥶 Initalizing PaletteTableViewCell")
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        print("End 🥶 Initalizing PaletteTableViewCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        print("Begin 🥶 Updating Constraints for PaletteTableViewCell")
        super.updateConstraints()
        print("End  🥶 Updating Constraints for PaletteTableViewCell")
    }
    
    override func layoutSubviews() {
        print("Begin 🥶 Laying Out Subviews for PaletteTableViewCell")
        setUpViews()
        super.layoutSubviews()
        print("End 🥶 Laying Out Subviews for PaletteTableViewCell")
    }
    
    func updateViews(){
        paletteImageView.image = palletPhoto?.image
        paletteTitleLabel.text = palletPhoto?.description
        colorPaletteView.colors = [#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1),#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)]
        colorPaletteView.colorStackView.arrangedSubviews.first?.layer.cornerRadius = 12
        colorPaletteView.layer.masksToBounds = true
        colorPaletteView.colorStackView.layer.masksToBounds = true
        colorPaletteView.colorStackView.arrangedSubviews.forEach{ $0.layer.masksToBounds = true }
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
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFit
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
