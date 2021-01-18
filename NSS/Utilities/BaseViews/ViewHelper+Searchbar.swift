//
//  ViewHelper.swift
//  NSS
//
//  Created by Fitzgerald Afful on 17/01/2021.
//

import Foundation
import UIKit
import SnapKit

class BaseSearchBar: UIView {
    let textField = UITextField()
    let searchImageView = UIImageView()
    var placeholder = String()

    var text: String {
        return textField.text!
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(placeholder: String) {
        self.init(frame: CGRect())
        self.placeholder = placeholder
        self.createViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createViews() {
        createBox()
        createSearchIcon()
        createTextField()
    }

    func createBox() {
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.borderGrey.cgColor

        self.snp.makeConstraints({ (make) in
            make.height.equalTo(48)
        })
    }

    func createSearchIcon() {
        searchImageView.contentMode = .scaleAspectFit
        searchImageView.image = UIImage(named: "search")!.maskWithColor(color: .gullGray)
        self.addSubview(searchImageView)
        searchImageView.snp.makeConstraints({ (make) in
            make.height.width.equalTo(20)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(15)
        })
    }

    func createTextField() {
        textField.backgroundColor = UIColor.white
        textField.textColor = UIColor.black
        textField.font = .regular(size: 16)
        textField.placeholder = placeholder
        // textField.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        // textField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        textField.keyboardType = .default
        textField.returnKeyType = .search

        self.addSubview(textField)
        textField.snp.makeConstraints({ (make) in
            make.height.equalToSuperview()
            make.centerY.equalToSuperview()
            make.left.equalTo(searchImageView.snp.right).offset(12)
            make.right.equalToSuperview().inset(100)
        })

        self.enableTapToSelectTextField()
    }

    @objc func editingDidBegin() {
        self.layer.borderColor = UIColor.defaultGreen.cgColor
        self.layer.borderWidth = 2.0
    }

    @objc func editingDidEnd() {
        self.layer.borderColor = UIColor.borderGrey.cgColor
        self.layer.borderWidth = 1.0
    }

    override var isUserInteractionEnabled: Bool {
        didSet {
            if isUserInteractionEnabled {
                self.layer.backgroundColor = UIColor.white.cgColor
                textField.backgroundColor = UIColor.white
            } else {
                self.layer.backgroundColor = UIColor.disabledWhite.cgColor
                textField.backgroundColor = UIColor.disabledWhite
            }
        }
    }
}
