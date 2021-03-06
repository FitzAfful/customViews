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

class AppointmentCardView: UIView {
    private let dateLabel = UILabel()
    private let venueLabel = UILabel()
    private let timeLabel = UILabel()
    private let venueImageView = UIImageView()
    private let timeImageView = UIImageView()
    private let dateBox = UIView()
    private let venueBox = UIView()

    private var day: String = "20"
    private var monthYear: String = "Sep 2020"
    private var time: String = "11:00 AM"
    private var status: String = "Pending"
    private var venue: String = "NSS/NASPA Transit Quarters - Adjacent Youth Home, Northern Region"

    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        dateBox.roundCorners(corners: [.topLeft, .bottomLeft], radius: 10)
    }

    convenience init(day: String, monthYear: String, time: String, status: String, venue: String) {
        self.init(frame: CGRect())
        self.day = day
        self.monthYear = monthYear
        self.time = time
        self.status = status
        self.venue = venue
        self.createViews()
    }

    func setDate() {
        let fullText = NSMutableAttributedString()
        fullText.append((day + "\n").formatAsAttributed(fontSize: 24, color: .blackPearl, isBold: true))
        fullText.append(monthYear.formatAsAttributed(fontSize: 14, color: .blackPearl, isBold: true))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        paragraphStyle.alignment = .center
        fullText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: fullText.length))
        dateLabel.attributedText = fullText
    }

    func setTime() {
        let fullText = NSMutableAttributedString()
        fullText.append(time.formatAsAttributed(fontSize: 14, color: .blackPearl, isBold: false))
        fullText.append(" ??? ".formatAsAttributed(fontSize: 14, color: .gullGray, isBold: false))
        fullText.append(status.formatAsAttributed(fontSize: 14, color: .fireBush, isBold: false))
        timeLabel.attributedText = fullText
    }

    func setVenue() {
        let fullText = NSMutableAttributedString()
        fullText.append(venue.formatAsAttributed(fontSize: 14, color: .blackPearl, isBold: false))
        venueLabel.attributedText = fullText
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createViews() {
        createBox()
        createDateBox()
        createDateLabel()
        createVenueBox()
        createVenueImageView()
        createVenueLabel()
        createTimeImageView()
        createTimeLabel()

        setDate()
        setVenue()
        setTime()
    }

    func createBox() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0
        self.layer.backgroundColor = UIColor.white.cgColor

        self.snp.makeConstraints({ (make) in
            make.height.equalTo(100)
        })
    }

    func createVenueImageView() {
        venueImageView.contentMode = .scaleAspectFit
        venueImageView.image = UIImage(named: "location")!
        venueBox.addSubview(venueImageView)
        venueImageView.snp.makeConstraints({ (make) in
            make.height.width.equalTo(30)
            make.left.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(16)
        })
    }

    func createTimeImageView() {
        timeImageView.contentMode = .scaleAspectFit
        timeImageView.image = UIImage(named: "timer")!
        venueBox.addSubview(timeImageView)
        timeImageView.snp.makeConstraints({ (make) in
            make.height.width.equalTo(30)
            make.left.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(16)
        })
    }

    func createDateBox() {
        dateBox.backgroundColor = UIColor.disabledWhite
        self.addSubview(dateBox)
        dateBox.snp.makeConstraints({ (make) in
            make.width.equalTo(100)
            make.left.height.top.equalToSuperview()
        })
    }

    func createDateLabel() {
        dateLabel.textColor = UIColor.black
        dateLabel.numberOfLines = 0
        dateLabel.textAlignment = .center
        dateBox.addSubview(dateLabel)
        dateBox.bringSubviewToFront(dateLabel)
        dateLabel.snp.makeConstraints({ (make) in
            make.centerY.centerX.equalToSuperview()
            make.width.height.equalToSuperview().inset(10)
        })
        setDate()
    }

    func createVenueBox() {
        venueBox.backgroundColor = UIColor.clear
        self.addSubview(venueBox)
        venueBox.snp.makeConstraints({ (make) in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(dateBox.snp.right)
        })
    }

    func createTimeLabel() {
        timeLabel.textColor = UIColor.black
        timeLabel.numberOfLines = 0
        venueBox.addSubview(timeLabel)
        timeLabel.snp.makeConstraints({ (make) in
            make.height.equalTo(44)
            make.left.equalTo(timeImageView.snp.right).offset(10)
            make.top.equalTo(timeImageView.snp.top)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        })
    }

    private func createVenueLabel() {
        venueLabel.textColor = UIColor.blackPearl
        venueLabel.numberOfLines = 2
        venueLabel.font = .regular(size: 12)
        venueLabel.textAlignment = .left
        venueBox.addSubview(venueLabel)
        venueLabel.snp.makeConstraints({ (make) in
            make.height.equalTo(44)
            make.left.equalTo(venueImageView.snp.right).offset(10)
            make.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(9)
        })
    }
}
