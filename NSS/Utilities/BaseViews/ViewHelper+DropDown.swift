//
//  ViewHelper.swift
//  NSS
//
//  Created by Fitzgerald Afful on 17/01/2021.
//

import Foundation
import UIKit
import SnapKit
import DropDown

extension ViewHelper {

    struct DropDownView {
        func createBaseDropDownButton(placeholder: String, dataSource: [String]) -> DropDownButton {
            let dropDownButton = DropDownButton()

            return dropDownButton
        }
    }

}

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
