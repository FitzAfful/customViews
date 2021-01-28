//
//  ViewHelper+Tag.swift
//  NSS
//
//  Created by Fitzgerald Afful on 28/01/2021.
//

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
