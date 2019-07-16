//
//  PaletteListViewController.swift
//  Palette
//
//  Created by Nic Gibson on 7/16/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

// Programmatic constraints is a 3 part process
// 1 - Declare our view
// 2 - Add our subviews
// 3 - Constrain our views

import UIKit

class PaletteListViewController: UIViewController {
    
    var photos: [UnsplashPhoto] = []
    
    var buttons: [UIButton] {
       return [randomButton, featuredButton, doubleRainbowButton]
    }
    
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    override func loadView() {
        super.loadView()
        addAllSubViews()
        setUpStackView()
        constrainViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureTableView()
        activateButtons()
        selectButton(featuredButton)
        searchForCategory(.featured)
    }
    
    func searchForCategory(_ route: UnsplashRoute) {
        UnsplashService.shared.fetchFromUnsplash(for: route) { (photos) in
            DispatchQueue.main.async {
                guard let photos = photos else {return}
                self.photos = photos
                self.paletteTableView.reloadData()
            }
        }
    }
    
    // MARK: - View Setup
    // Part two - Add subViews
    func addAllSubViews() {
        self.view.addSubview(featuredButton)
        self.view.addSubview(doubleRainbowButton)
        self.view.addSubview(randomButton)
        self.view.addSubview(buttonStackView)
        self.view.addSubview(paletteTableView)
    }
    
    func setUpStackView() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(featuredButton)
        buttonStackView.addArrangedSubview(doubleRainbowButton)
        buttonStackView.addArrangedSubview(randomButton)
        buttonStackView.topAnchor.constraint(equalTo: self.safeArea.topAnchor).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: (self.view.frame.maxX / 20)).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -(self.view.frame.maxX / 20)).isActive = true
    }
    
    func configureTableView() {
        paletteTableView.delegate = self
        paletteTableView.dataSource = self
        paletteTableView.register(PaletteTableViewCell.self, forCellReuseIdentifier: "paletteCell")
        paletteTableView.allowsSelection = false
    }
    
    func constrainViews() {
        buttonStackView.anchor(top: safeArea.topAnchor, bottom: nil, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, topPadding: 0, bottomPadding: 0, leadingPadding: (self.view.frame.maxX / 20), trailingPadding: -(self.view.frame.maxX / 20))
        paletteTableView.anchor(top: buttonStackView.bottomAnchor, bottom: safeArea.bottomAnchor, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, topPadding: (buttonStackView.frame.height / 2), bottomPadding: 0, leadingPadding: 0, trailingPadding: 0)
    }
    
    // IBAction
    func activateButtons() {
        buttons.forEach{ $0.addTarget(self, action: #selector(searchButtonTapped(sender:)), for: .touchUpInside)}
    }
    
    @objc func searchButtonTapped(sender: UIButton) {
        selectButton(sender)
        switch sender {
        case featuredButton:
            searchForCategory(.featured)
        case randomButton:
            searchForCategory(.random)
        case doubleRainbowButton:
            searchForCategory(.doubleRainbow)
        default:
            print("Error, button not found")
        }
    }
    
    func selectButton(_ button: UIButton) {
        buttons.forEach{ $0.setTitleColor(UIColor.lightGray, for: .normal)
            button.setTitleColor(UIColor(named: "devmountainBlue"), for: .normal)
            
        }
    }
    
    // MARK: - View declaration
    // Part One
    let featuredButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Featured", for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let doubleRainbowButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Double Rainbow", for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let randomButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Random", for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    let paletteTableView: UITableView = {
       let tableView = UITableView()
        return tableView
    }()
}

// MARK: - Tableview Conformance
extension PaletteListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let imageViewSpace: CGFloat = (view.frame.width - (2 * SpacingConstants.outerHorizontalPadding))
        let titleLabelSpace: CGFloat = SpacingConstants.oneLineElementHeight
        let outerVerticalSpacing: CGFloat = (2 * SpacingConstants.outerVerticalPadding)
        let verticalPadding: CGFloat = (3 * SpacingConstants.verticalObjectBuffer)
        return imageViewSpace + titleLabelSpace + outerVerticalSpacing + verticalPadding
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paletteCell", for: indexPath) as! PaletteTableViewCell
        let photo = photos[indexPath.row]
        cell.photo = photo
        return cell
    }
    
    
}
