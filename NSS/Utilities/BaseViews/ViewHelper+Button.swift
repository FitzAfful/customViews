//
//  ViewHelper.swift
//  NSS
//
//  Created by Fitzgerald Afful on 17/01/2021.
//

import Foundation
import UIKit
import SnapKit

extension ViewHelper {

    enum ChevronPosition {
        case left
        case right
    }

    struct Button {

        static func baseDefaultButton(title: String) -> UIButton {
            let button = UIButton()
            button.setBackgroundColor(color: .defaultGreen, forState: .normal)
            button.setBackgroundColor(color: .focusedGreen, forState: .highlighted)
            button.setBackgroundColor(color: .focusedGreen, forState: .selected)
            button.setBackgroundColor(color: .disabledGreen, forState: .disabled)
            button.layer.cornerRadius = 10
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.medium()
            button.setTitleColor(.white, for: .normal)
            return button
        }

        static func baseChevronButton(title: String, chevronPosition: ChevronPosition) -> UIButton {
            let button = baseDefaultButton(title: title)

            let icon = chevronPosition == .left ? UIImage(named: "chevron-left")!.maskWithColor(color: .white)! : UIImage(named: "chevron-right")!.maskWithColor(color: .white)
            button.setImage(icon, for: .normal)
            button.imageView?.contentMode = .scaleAspectFit

            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            if chevronPosition == .right {
                button.alignImageRight()
            }
            return button
        }

        static func baseRoundImageButton(image: UIImage, height: Float) -> UIButton {
            let button = UIButton()
            button.setBackgroundColor(color: .defaultGreen, forState: .normal)
            button.setBackgroundColor(color: .focusedGreen, forState: .highlighted)
            button.setBackgroundColor(color: .focusedGreen, forState: .selected)
            button.setBackgroundColor(color: .disabledGreen, forState: .disabled)
            button.layer.cornerRadius = CGFloat(height / 2)
            button.setTitle("", for: .normal)
            button.setImage(image.maskWithColor(color: .white), for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            return button
        }

        static func borderedButton(title: String) -> UIButton {
            let button = baseDefaultButton(title: title)
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.borderGrey.cgColor
            button.setBackgroundColor(color: .white, forState: .normal)
            button.setBackgroundColor(color: .gin, forState: .highlighted)
            button.setBackgroundColor(color: .gin, forState: .selected)
            button.setBackgroundColor(color: .disabledWhite, forState: .disabled)
            button.setTitleColor(.defaultGreen, for: .normal)
            button.setTitleColor(.disabledGreen, for: .disabled)
            return button
        }

        static func borderedChevronButton(title: String, chevronPosition: ChevronPosition) -> UIButton {
            let button = borderedButton(title: title)

            let icon = chevronPosition == .left ? UIImage(named: "chevron-left")!.maskWithColor(color: .defaultGreen)! : UIImage(named: "chevron-right")!.maskWithColor(color: .defaultGreen)
            button.setImage(icon, for: .normal)
            button.imageView?.contentMode = .scaleAspectFit

            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            if chevronPosition == .right {
                button.alignImageRight()
            }
            return button
        }

    }

}
