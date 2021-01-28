//
//  ViewHelper+Tag.swift
//  NSS
//
//  Created by Fitzgerald Afful on 28/01/2021.
//

import Foundation
import UIKit

class Tag: UILabel {

    enum TagState {
        case success
        case failed
        case processing
    }

    private func setState(state: TagState) {
        switch state {
        case .success:
            self.text = "Success"
            self.backgroundColor = .defaultGreen
        case .failed:
            self.text = "Failed"
            self.backgroundColor = .cinnabar
        case .processing:
            self.text = "Processing"
            self.backgroundColor = .radiantBlue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        setState(state: .success)
    }

    convenience init(state: TagState = .success) {
        self.init(frame: CGRect())
        self.createViews()
        setState(state: state)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createViews() {
        createTitleLabel()
        setState(state: .success)
    }

    private func createTitleLabel() {
        self.font = .medium(size: 14)
        self.textColor = .white
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        self.textAlignment = .center
    }

}
