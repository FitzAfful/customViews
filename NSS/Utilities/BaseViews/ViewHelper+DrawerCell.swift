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

class DrawerCellView: UIView {
    private let label = UILabel()
    private let backgroundView = UIView()
    private var imageView = UIImageView()

    var title: String = "" {
        didSet {
            label.text = title
        }
    }

    var image: UIImage = UIImage(named: "overview")! {
        didSet {
            imageView.image = image
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(title: String, isSelected: Bool = false) {
        self.init(frame: CGRect())
        self.createViews()
        self.title = title
        self.isSelected = isSelected
    }

    func createViews() {
        createBox()
        createBackgroundView()
        createImageView()
        createLabel()
    }

    func createBox() {
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 10

        self.snp.makeConstraints({ (make) in
            make.height.equalTo(72)
        })
    }

    func createBackgroundView() {
        backgroundView.contentMode = .scaleAspectFit
        backgroundView.backgroundColor = .clear
        backgroundView.layer.cornerRadius = 10
        self.addSubview(backgroundView)
        backgroundView.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.left.right.top.bottom.equalToSuperview().inset(12)
        })
    }

    func createImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = image
        backgroundView.addSubview(imageView)
        imageView.snp.makeConstraints({ (make) in
            make.height.width.equalTo(20)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        })
    }

    func createLabel() {
        label.backgroundColor = UIColor.clear
        label.textColor = .black
        label.font = .regular(size: 16)
        label.text = title

        backgroundView.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(imageView.snp.right).offset(10)
            make.right.top.bottom.equalToSuperview().inset(10)
        })
    }

    var isSelected: Bool = false {
        didSet {
            if isSelected {
                self.backgroundView.backgroundColor = UIColor.defaultGreen
                self.imageView.setImageColor(color: .white)
                self.label.textColor = .white
            } else {
                self.backgroundView.backgroundColor = UIColor.clear
                self.imageView.setImageColor(color: .black)
                self.label.textColor = .black
            }
        }
    }
}
