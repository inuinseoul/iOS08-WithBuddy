//
//  PurposeChartView.swift
//  WithBuddy
//
//  Created by 박정아 on 2021/11/11.
//

import UIKit

final class PurposeChartView: UIView {
    
    private let nameLabel = NameLabel()
    private let titleLabel = TitleLabel()
    private let whiteView = WhiteView()
    private let stackView = UIStackView()
    private let firstPurposeView = PurposeView()
    private let secondPurposeView = PurposeView()
    private let thirdPurposeView = PurposeView()
    private let fourthPurposeView = PurposeView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configure()
    }
    
    func update(name: String) {
        self.nameLabel.text = name
    }
    
    func update(purposeList: [String]) {
        self.firstPurposeView.update(purpose: purposeList.indices ~= 0 ? purposeList[0] : "기타")
        self.secondPurposeView.update(purpose: purposeList.indices ~= 1 ? purposeList[1] : "기타")
        self.thirdPurposeView.update(purpose: purposeList.indices ~= 2 ? purposeList[2] : "기타")
        self.fourthPurposeView.update(purpose: purposeList.indices ~= 3 ? purposeList[3] : "기타")
    }
    
    private func configure() {
        self.configureNameLabel()
        self.configureWhiteView()
        self.configureTitleLabel()
        self.configureStackView()
        self.configurePurposeView()
    }
    
    private func configureNameLabel() {
        self.addSubview(self.nameLabel)
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }
    
    private func configureTitleLabel() {
        self.addSubview(self.titleLabel)
        self.titleLabel.text = "님의 만남 목적"
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.nameLabel.centerYAnchor)
        ])
    }
    
    private func configureWhiteView() {
        self.addSubview(self.whiteView)
        self.whiteView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.whiteView.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
            self.whiteView.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 10),
            self.whiteView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.whiteView.heightAnchor.constraint(equalToConstant: 100),
            self.whiteView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func configureStackView() {
        self.whiteView.addSubview(self.stackView)
        self.stackView.spacing = 10
        self.stackView.alignment = .center
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.centerXAnchor.constraint(equalTo: self.whiteView.centerXAnchor),
            self.stackView.centerYAnchor.constraint(equalTo: self.whiteView.centerYAnchor),
            self.stackView.heightAnchor.constraint(equalTo: self.whiteView.heightAnchor)
        ])
    }
    
    private func configurePurposeView() {
        self.stackView.addArrangedSubview(self.firstPurposeView)
        self.stackView.addArrangedSubview(self.secondPurposeView)
        self.stackView.addArrangedSubview(self.thirdPurposeView)
        self.stackView.addArrangedSubview(self.fourthPurposeView)
    }

}
