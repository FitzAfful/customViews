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
