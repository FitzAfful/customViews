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
