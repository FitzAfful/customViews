/// Copyright (c) 2020 Qodehub LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import UIKit

extension UIFont {

    static func regular(size: Int = 16) -> UIFont {
        return self.baseFontAction(name: "IBMPlexSans-Regular", size: size)
    }

    static func medium(size: Int = 16) -> UIFont {
        return self.baseFontAction(name: "IBMPlexSans-Medium", size: size)
    }

    static func bold(size: Int = 16) -> UIFont {
        return self.baseFontAction(name: "IBMPlexSans-Bold", size: size)
    }

    static func italic(size: Int = 16) -> UIFont {
        return self.baseFontAction(name: "IBMPlexSans-Italic", size: size)
    }

    static func light(size: Int = 16) -> UIFont {
        return self.baseFontAction(name: "IBMPlexSans-Light", size: size)
    }

    static func thin(size: Int = 16) -> UIFont {
        return self.baseFontAction(name: "IBMPlexSans-Thin", size: size)
    }

    static func semiBold(size: Int = 16) -> UIFont {
        return self.baseFontAction(name: "IBMPlexSans-SemiBold", size: size)
    }

    static func baseFontAction(name: String,size: Int) -> UIFont {
        guard let customFont = UIFont(name: name, size: CGFloat(size)) else {
            return UIFont.systemFont(ofSize: CGFloat(size))
        }
        return UIFontMetrics.default.scaledFont(for: customFont)
    }

    static func getBlackAttributes(size: Int = 13) -> [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.medium(size: size)]
    }
}
