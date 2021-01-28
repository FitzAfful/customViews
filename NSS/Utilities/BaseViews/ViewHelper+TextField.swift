/////////////////////////////////////
// Copyright (c) 2020 Qodehub LLC
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
// distribute, sublicense, create a derivative work, and/or sell copies of the
// Software in any work that is designed, intended, or marketed for pedagogical or
// instructional purposes related to programming, coding, application development,
// or information technology.  Permission for such use, copying, modification,
// merger, publication, distribution, sublicensing, creation of derivative works,
// or sale is expressly withheld.
//
// This project and source code may use libraries or frameworks that are
// released under various Open-Source licenses. Use of those libraries and
// frameworks are governed by their own individual licenses.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//////////////////////////////////////

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
