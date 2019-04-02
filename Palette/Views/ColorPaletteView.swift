//
//  ColorPaletteView.swift
//  Palette
//
//  Created by DevMountain on 4/1/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class ColorPaletteView: UIView {
    
    var colors: [UIColor]{
        didSet{
            buildColorBricks()
        }
    }
    
    override func updateConstraints() {
        print("Begin 💩 Updating Constraints for ColorStackView")
        super.updateConstraints()
        print("End 💩  Updating Constraints for ColorStackView")
    }
    
    override func layoutSubviews() {
        print("Begin 💩 Laying Out Subviews for ColorStackView")
        super.layoutSubviews()
        setUpViews()
        print("Begin 💩  Laying Out Subviews for ColorStackView")
    }
    
    init(colors: [UIColor] = [], frame: CGRect = .zero) {
        print("Begin 💩  INitializing ColorStackView")
        self.colors = colors
        super.init(frame: frame)
        print("End 💩 INitializing ColorStackView")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        addSubview(colorStackView)
        colorStackView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0)
        buildColorBricks()
    }
    
    private func generateColorBrick(for color: UIColor) -> UIView {
        let colorBrick = UIView()
        colorBrick.backgroundColor = color
        return colorBrick
    }
    
    private func buildColorBricks(){
        resetColorBricks()
        for color in colors {
            let colorBrick = generateColorBrick(for: color)
            if color == colors.first {
                colorBrick.roundCorners(cornerRadius: 12, corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
            }else if color == colors.last{
                colorBrick.roundCorners(cornerRadius: 12, corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
            }
            addSubview(colorBrick)
            colorStackView.addArrangedSubview(colorBrick)
        }
    }
    
    private func resetColorBricks() {
        for subView in colorStackView.arrangedSubviews {
            colorStackView.removeArrangedSubview(subView)
        }
    }
    
    //MARK: - SubViews
    lazy var colorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = UIStackView.Alignment.fill
        stackView.axis = .horizontal
        return stackView
    }()
}
