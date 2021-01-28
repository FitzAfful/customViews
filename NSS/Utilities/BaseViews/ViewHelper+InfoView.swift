//
//  ViewHelper+InfoView.swift
//  NSS
//
//  Created by Fitzgerald Afful on 25/01/2021.
//

import Foundation
import UIKit
import SnapKit

class InfoView: UIView {
    let label = UILabel()
    let iconImageView = UIImageView()
    var type: ViewType!

    enum ViewType {
        case infoBanner
        case badIdentityScore
        case fairIdentityScore
        case goodIdentityScore
    }

    var message: NSAttributedString = NSAttributedString() {
        didSet {
            label.attributedText = message
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(message: NSAttributedString, type: ViewType = .infoBanner) {
        self.init(frame: CGRect())
        self.type = type
        self.createViews()
        self.label.attributedText = message
        self.message = message
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createViews() {
        createBox()
        if self.type == .infoBanner {
            createIcon()
        }
        createLabel()
    }

    func createBox() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        switch self.type {
        case .badIdentityScore:
            self.layer.borderColor = UIColor.cinnabar.cgColor
            self.layer.backgroundColor = UIColor.cinnabar.withAlphaComponent(0.2).cgColor
        case .fairIdentityScore:
            self.layer.borderColor = UIColor.borderYellow.cgColor
            self.layer.backgroundColor = UIColor.borderYellow.withAlphaComponent(0.2).cgColor
        case .goodIdentityScore:
            self.layer.borderColor = UIColor.defaultGreen.cgColor
            self.layer.backgroundColor = UIColor.defaultGreen.withAlphaComponent(0.2).cgColor
        default:
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.backgroundColor = UIColor.zircon.cgColor
        }

        self.snp.makeConstraints({ (make) in
            make.height.equalTo(48)
        })
    }

    func createIcon() {
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = UIImage(named: "help-tools")!
        self.addSubview(iconImageView)
        iconImageView.snp.makeConstraints({ (make) in
            make.height.width.equalTo(20)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(15)
        })
    }

    func createLabel() {
        label.textColor = UIColor.black
        label.numberOfLines = 0
        self.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.height.equalToSuperview()
            make.centerY.equalToSuperview()
            if self.type == .infoBanner {
                make.left.equalTo(iconImageView.snp.right).offset(12)
            } else {
                make.left.equalToSuperview().inset(24)
            }
            make.right.equalToSuperview().inset(24)
        })
    }
}
