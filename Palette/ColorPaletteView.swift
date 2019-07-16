//
//  ColorPaletteView.swift
//  Palette
//
//  Created by Nic Gibson on 7/16/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class ColorPaletteView: UIView {
    
    var colors: [UIColor] {
        didSet {
            buildColorBricks()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpViews()
    }
    
    init(colors: [UIColor] = [], frame: CGRect = .zero) {
        self.colors = colors
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func setUpViews() {
        addSubview(colorStackView)
        colorStackView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, topPadding: 0, bottomPadding: 0, leadingPadding: 0, trailingPadding: 0)
    }
    
    private func generateColorBrick(for color: UIColor) -> UIView {
        let colorBrick = UIView()
        colorBrick.backgroundColor = color
        return colorBrick
    }
    
    private func buildColorBricks() {
        resetColorBricks()
        for color in self.colors {
            let colorBrick = generateColorBrick(for: color)
            self.addSubview(colorBrick)
            self.colorStackView.addArrangedSubview(colorBrick)
        }
        self.layoutIfNeeded()
    }

    private func resetColorBricks() {
        for subView in colorStackView.arrangedSubviews {
            self.colorStackView.removeArrangedSubview(subView)
        }
    }
    
    // Step one
    lazy var colorStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = UIStackView.Alignment.fill
        return stackView
    }()
}
