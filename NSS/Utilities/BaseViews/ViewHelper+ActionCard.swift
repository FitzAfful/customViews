//
//  ViewHelper+InfoView.swift
//  NSS
//
//  Created by Fitzgerald Afful on 25/01/2021.
//

import Foundation
import UIKit
import SnapKit

class ActionCard: UIView {
    private let titleLabel = UILabel()
    private let detailsLabel = UILabel()
    private let imageView = UIImageView()

    private var title: String = "Check pincode"
    private var details: String = "Check your pincode and pay to commence your enrolment"
    private var image: UIImage = UIImage(named: "pincode")!

    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
    }

    convenience init(title: String, details: String, image: UIImage) {
        self.init(frame: CGRect())
        self.title = title
        self.details = details
        self.image = image
        self.createViews()
    }

    func setTitle() {
        titleLabel.attributedText = title.formatAsAttributed(fontSize: 20, color: .blackPearl, isBold: true)
    }

    func setDetails() {
        detailsLabel.attributedText = details.formatAsAttributed(fontSize: 14, color: .subtleGrey, isBold: false)
    }

    func setImage() {
        imageView.image = image
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createViews() {
        createBox()
        createTitleLabel()
        createDetailsLabel()
        createImageView()

        setTitle()
        setDetails()
        setImage()
    }

    func createBox() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0
        self.layer.backgroundColor = UIColor.white.cgColor

        self.snp.makeConstraints({ (make) in
            make.height.equalTo(220)
        })
    }

    func createImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.addSubview(imageView)
        imageView.snp.makeConstraints({ (make) in
            make.height.width.width.equalTo(64)
            make.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(24)
        })
    }

    func createTitleLabel() {
        titleLabel.textColor = UIColor.black
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints({ (make) in
            make.top.left.right.equalToSuperview().inset(24)
            make.height.equalTo(30)
        })
    }

    private func createDetailsLabel() {
        detailsLabel.textColor = UIColor.blackPearl
        detailsLabel.numberOfLines = 2
        detailsLabel.font = .regular(size: 12)
        detailsLabel.textAlignment = .left
        self.addSubview(detailsLabel)
        detailsLabel.snp.makeConstraints({ (make) in
            make.height.equalTo(50)
            make.left.right.equalToSuperview().inset(24)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        })
    }
}
