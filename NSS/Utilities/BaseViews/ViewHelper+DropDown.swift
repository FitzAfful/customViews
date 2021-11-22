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
import DropDown

protocol DropDownButtonDelegate: AnyObject {
    func dropDownItemSelected(index: Int, item: String)
}

class DropDownButton: UIView {
    private let label = UILabel()
    private var chevronImageView = UIImageView()
    private let dropDown = DropDown()
    weak var delegate: DropDownButtonDelegate?

    var title: String = "" {
        didSet {
            if title == "" {
                label.text = placeholder
                label.textColor = .gullGray
            } else {
                label.text = title
                label.textColor = .black
            }
        }
    }

    var placeholder: String = "" {
        didSet {
            print("Placeholder: \(placeholder), title: \(title)")
            if title == "" {
                label.text = placeholder
                label.textColor = .gullGray
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(placeholder: String, dataSource: [String], delegate: DropDownButtonDelegate) {
        self.init(frame: CGRect())
        self.placeholder = placeholder
        label.text = placeholder
        label.textColor = .gullGray
        self.createViews()
        dropDown.anchorView = self
        dropDown.direction = .bottom
        dropDown.bottomOffset = CGPoint(x: 0, y: 48)
        dropDown.dataSource = dataSource
        dropDown.cellNib = UINib(nibName: "MyCell", bundle: nil)
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
           /*guard let cell = cell as? MyCell else { return }

           // Setup your custom UI components
           cell.logoImageView.image = UIImage(named: "logo_\(index)")*/
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.title = item
            delegate.dropDownItemSelected(index: index, item: item)
        }
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleDropDown)))
        label.isUserInteractionEnabled = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createViews() {
        createBox()
        createChevron()
        createLabel()
    }

    @objc func toggleDropDown() {
        self.superview?.endEditing(true)
        dropDown.becomeFirstResponder()
        dropDown.show()
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

    func createChevron() {
        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.backgroundColor = .clear
        chevronImageView.image = UIImage(named: "chevron-down")!
        self.addSubview(chevronImageView)
        chevronImageView.snp.makeConstraints({ (make) in
            make.height.width.equalTo(20)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(12)
        })
    }

    func createLabel() {
        label.backgroundColor = UIColor.white
        label.textColor = .gullGray
        label.font = .regular(size: 16)

        self.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.height.equalToSuperview()
            make.centerY.equalToSuperview()
            make.right.equalTo(chevronImageView.snp.left).offset(-10)
            make.left.equalToSuperview().inset(15)
        })
    }

    /*var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = UIColor.defaultGreen.cgColor
                self.layer.borderWidth = 2.0
            } else {
                self.layer.borderColor = UIColor.borderGrey.cgColor
                self.layer.borderWidth = 1.0
            }
        }
    }

    var isEnabled: Bool = true {
        didSet {
            if isUserInteractionEnabled {
                self.layer.backgroundColor = UIColor.white.cgColor
                label.backgroundColor = UIColor.white
            } else {
                self.layer.backgroundColor = UIColor.disabledWhite.cgColor
                label.backgroundColor = UIColor.disabledWhite
            }
        }
    }*/
}
