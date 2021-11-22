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

class StepperTwo: UIStackView {
    private var items: [StepperLabel] = []

    func setSelected(index: Int) {
        for item in items {
            item.setState(state: .notSelected)
        }
        items[index].setState(state: .selected)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
    }

    convenience init(items: [StepperLabel]) {
        self.init(frame: CGRect())
        self.createViews()
        self.items.append(contentsOf: items)
        for item in items {
            self.addArrangedSubview(item)
        }
        setSelected(index: 0)
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createViews() {
        self.axis  = NSLayoutConstraint.Axis.vertical
        self.distribution  = UIStackView.Distribution.fillEqually
        self.alignment = UIStackView.Alignment.leading
        self.spacing   = 16.0
    }

}

class StepperLabel: UIView {
    private var titleLabel = UILabel()
    private var underlineView = UIView()
    var title: String = ""
    var state: StepperState = .notSelected

    enum StepperState {
        case selected
        case notSelected
    }

    func setState(state: StepperState) {
        switch state {
        case .selected:
            self.titleLabel.textColor = .blackPearl
            self.underlineView.backgroundColor = .blackPearl
        case .notSelected:
            self.titleLabel.textColor = .gullGray
            self.underlineView.backgroundColor = .gullGray
        }
        self.titleLabel.text = title
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        setState(state: .selected)
    }

    convenience init(state: StepperState = .selected, title: String) {
        self.init(frame: CGRect())
        self.title = title
        self.createViews()
        setState(state: state)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createViews() {
        createTitleLabel()
        createUnderLineView()
        setState(state: .notSelected)
    }

    private func createTitleLabel() {
        self.titleLabel.font = .medium(size: 16)
        self.titleLabel.textColor = .blackPearl
        self.titleLabel.textAlignment = .left
        self.titleLabel.text = title
        self.addSubview(self.titleLabel)
        titleLabel.snp.makeConstraints({ (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(25)
        })
    }

    private func createUnderLineView() {
        self.underlineView.backgroundColor = .defaultGreen
        self.addSubview(self.underlineView)
        underlineView.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.titleLabel.snp.bottom).offset(6)
            make.height.equalTo(3)
            make.width.equalTo(150)
        })
    }
}
