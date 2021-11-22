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
