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
