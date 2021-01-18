//
//  ViewHelper.swift
//  NSS
//
//  Created by Fitzgerald Afful on 17/01/2021.
//

import Foundation
import UIKit
import SnapKit

extension ViewHelper {

    struct TextField {

    }

}

class BaseTextField: UIView {
    let textField = UITextField()
    var placeholder = String()

    enum TextFieldType {
        case email
        case password
        case normal
    }

    var text: String {
        return textField.text!
    }

    var type: TextFieldType = .normal

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(placeholder: String, type: TextFieldType = .normal) {
        self.init(frame: CGRect())
        self.type = type
        self.placeholder = placeholder
        self.createViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createViews() {
        createBox()
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

    func createTextField() {
        textField.backgroundColor = UIColor.white
        textField.textColor = UIColor.black
        textField.font = .regular(size: 16)
        textField.placeholder = placeholder
        textField.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)

        switch type {
        case .email:
            textField.keyboardType = .emailAddress
            textField.autocapitalizationType = .none
        case .password:
            textField.isSecureTextEntry = true
        default:
            textField.keyboardType = .default
        }

        self.addSubview(textField)
        textField.snp.makeConstraints({ (make) in
            make.height.equalToSuperview()
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(15)
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

class LabeledTextField: UIView {
    var textField = BaseTextField()
    var titleLabel = UILabel()
    var errorLabel = UILabel()
    var placeholder = String()
    var title: String? = String()

    var type: BaseTextField.TextFieldType = .normal

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(title: String?, placeholder: String, type: BaseTextField.TextFieldType = .normal) {
        self.init(frame: CGRect())
        self.type = type
        self.title = title
        self.placeholder = placeholder
        self.createViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createViews() {

        if title != nil {
            titleLabel = createTitleLabel(title: title!)
            self.addSubview(titleLabel)
            titleLabel.snp.makeConstraints({(make) in
                make.height.equalTo(22)
            })
        }

        textField = BaseTextField(placeholder: placeholder, type: type)
        self.addSubview(textField)
        textField.snp.makeConstraints({ (make) in
            make.height.equalTo(48)
            make.left.right.equalToSuperview()
            if title != nil {
                make.top.equalTo(titleLabel.snp.bottom).offset(5)
            } else {
                make.top.equalToSuperview().inset(15)
            }
        })

        errorLabel = createErrorLabel()
        self.addSubview(errorLabel)
        errorLabel.snp.makeConstraints({(make) in
            make.left.equalToSuperview().inset(15)
            make.top.equalTo(textField.snp.bottom).offset(0)
            make.height.equalTo(22)
        })

        self.setErrorMessage(nil)
    }

    func createTitleLabel(title: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.font = .regular(size: 14)
        titleLabel.text = title
        titleLabel.textColor = .subtleGrey
        return titleLabel
    }

    func createErrorLabel() -> UILabel {
        let errorLabel = UILabel()
        errorLabel.font = .regular(size: 14)
        errorLabel.textColor = .cinnabar
        errorLabel.isHidden = true
        return errorLabel
    }

    func setErrorMessage(_ message: String? = nil) {
        if let errorMessage = message {
            errorLabel.text = errorMessage
            errorLabel.isHidden = false
        } else {
            errorLabel.isHidden = true
        }
    }
}
