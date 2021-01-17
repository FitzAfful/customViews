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

extension String {

    public func isValidEmail() -> Bool {

        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)

    }

    func containsCapitalLetter() -> Bool {
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        return texttest.evaluate(with: self)
    }

    func containsNumber() -> Bool {
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        return texttest1.evaluate(with: self)
    }

    func containsSpecialCharacter() -> Bool {
        let specialCharacterRegEx  = ".*[!&^%$#@()/_*+-]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        return texttest2.evaluate(with: self)
    }

    func contains8Characters() -> Bool {
        return self.count >= 8
    }

    public func isValidPassword() -> Bool {
        return containsSpecialCharacter() || containsNumber() || containsCapitalLetter() || contains8Characters()
    }

    /// Function to create anattributed text with the aprams supplied
    ///
    /// - Parameters:
    ///   - fontSize: size of the attributed text
    ///   - color: color of the attributed tex
    /// - Returns: attribured text
    public func formatAsAttributed(fontSize: Int = 16, color: UIColor, isBold: Bool = false) -> NSAttributedString {
        let combination = NSMutableAttributedString()
        let attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: isBold ? UIFont.medium(size: fontSize) : UIFont.regular(size: fontSize)]
        let partOne = NSMutableAttributedString(string: self, attributes: attributes)
        combination.append(partOne)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        combination.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: combination.length))

        return combination
    }
}
