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
