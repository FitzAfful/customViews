//
//  ViewHelper+Tag.swift
//  NSS
//
//  Created by Fitzgerald Afful on 28/01/2021.
//

import Foundation
import UIKit
import SnapKit

class TabLabel: UIView {
    private var titleLabel = UILabel()
    private var underlineView = UIView()
    var title: String = ""
    var state: TabState = .notSelected

    enum TabState {
        case selected
        case notSelected
    }

    func setState(state: TabState) {
        switch state {
        case .selected:
            self.titleLabel.textColor = .blackPearl
            self.underlineView.backgroundColor = .defaultGreen
        case .notSelected:
            self.titleLabel.textColor = .gullGray
            self.underlineView.backgroundColor = .clear
        }
        self.titleLabel.text = title
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        setState(state: .selected)
    }

    convenience init(state: TabState = .selected, title: String) {
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
        self.titleLabel.textAlignment = .center
        self.titleLabel.text = title
        self.addSubview(self.titleLabel)
        titleLabel.snp.makeConstraints({ (make) in
            make.left.top.right.equalToSuperview().inset(0)
            make.height.equalTo(25)
        })
    }

    private func createUnderLineView() {
        self.underlineView.backgroundColor = .defaultGreen
        self.addSubview(self.underlineView)
        underlineView.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(6)
            make.height.equalTo(3)
        })
    }
}
