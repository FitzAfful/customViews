//
//  ViewHelper+InfoView.swift
//  NSS
//
//  Created by Fitzgerald Afful on 25/01/2021.
//

import Foundation
import UIKit
import SnapKit

class PaymentMethodView: UIView {
    private let titleLabel = UILabel()
    private let detailsLabel = UILabel()
    private let imageView = UIImageView()

    private var title: String = "Mobile Money"
    private var image: UIImage = UIImage(named: "Bank")!

    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
    }

    convenience init(title: String, image: UIImage) {
        self.init(frame: CGRect())
        self.title = title
        self.image = image
        self.createViews()
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
        createImageView()
    }

    func createBox() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.borderGrey.cgColor
        self.layer.backgroundColor = UIColor.white.cgColor

        self.snp.makeConstraints({ (make) in
            make.height.equalTo(104)
        })
    }

    func createImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.addSubview(imageView)
        imageView.snp.makeConstraints({ (make) in
            make.height.width.width.equalTo(24)
            make.centerY.equalToSuperview().offset(-15)
            make.centerX.equalToSuperview()
        })
    }

    func createTitleLabel() {
        titleLabel.textColor = UIColor.blackPearl
        titleLabel.numberOfLines = 0
        titleLabel.font = .medium(size: 16)
        titleLabel.textAlignment = .center
        titleLabel.text = title
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview().inset(24)
            make.centerY.equalToSuperview().offset(15)
            make.height.equalTo(30)
        })
    }
}
