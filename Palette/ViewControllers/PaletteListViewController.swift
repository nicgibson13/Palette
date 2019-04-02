//
//  PaletteListViewController.swift
//  Palette
//
//  Created by DevMountain on 4/1/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class PaletteListViewController: UIViewController {
    
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    override func loadView() {
        super.loadView()
        addAllSubViews()
        setUpStackView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureTableView()
    }
    
    func addAllSubViews(){
        view.addSubview(calmButton)
        view.addSubview(energeticButton)
        view.addSubview(freshButton)
        view.addSubview(buttonStackView)
        view.addSubview(paletteTableView)
    }
    
    func setUpStackView() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(calmButton)
        buttonStackView.addArrangedSubview(energeticButton)
        buttonStackView.addArrangedSubview(freshButton)
        buttonStackView.anchor(top: safeArea.topAnchor, bottom: nil, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0)
        paletteTableView.anchor(top: buttonStackView.bottomAnchor, bottom: safeArea.bottomAnchor, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, paddingTop: 8, paddingBottom: 0, paddingLeft: 0, paddingRight: 0)
    }
    
    func configureTableView() {
        paletteTableView.dataSource = self
        paletteTableView.delegate = self
        paletteTableView.register(PaletteTableViewCell.self, forCellReuseIdentifier: "colorCell")
    }
    
    //MARK: - Views
    let calmButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Calm", for: .normal)
        return button
    }()
    
    let energeticButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Energetic", for: .normal)
        return button
    }()
    
    let freshButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Fresh", for: .normal)
        return button
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    let paletteTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
}

extension PaletteListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let imageViewSpace: CGFloat = (view.frame.width - (2 * SpacingConstants.outerHorizontalPadding))
        let titleLabelSpace: CGFloat = SpacingConstants.oneLineElementHight
        let colorPaletteViewSpace: CGFloat = SpacingConstants.oneLineElementHight
        let verticalPadding: CGFloat = (5 * SpacingConstants.verticalObjectBuffer)
        return imageViewSpace + titleLabelSpace + colorPaletteViewSpace + verticalPadding
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PalettePhotoController.shared.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath) as! PaletteTableViewCell
        let palletPhoto = PalettePhotoController.shared.photos[indexPath.row]
        cell.palletPhoto = palletPhoto
        return cell
    }
}
