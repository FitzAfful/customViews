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

class Stepper: UIView {
    private let label = UILabel()
    private let detailsLabel = UILabel()
    private let circularView = UIView()
    private var circularProgressBar: CircularProgressBar!

    var title: String = "" {
        didSet {
            label.text = title
        }
    }

    var details: String = "" {
        didSet {
            detailsLabel.text = details
        }
    }

    public var totalProgress: Int = 1 {
        didSet {
            circularProgressBar.totalProgress = totalProgress
        }
    }
    public var currentProgress: Int = 0 {
        didSet {
            circularProgressBar.currentProgress = currentProgress
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(title: String, details: String, isSelected: Bool = false) {
        self.init(frame: CGRect())
        self.createViews()
        self.title = title
        self.details = details
    }

    func createViews() {
        createBox()
        createProgressRing()
        createLabel()
        createDetailsLabel()
    }

    func createProgressRing() {
        circularView.backgroundColor = .clear
        self.addSubview(circularView)
        circularView.snp.makeConstraints { (make) in
            make.width.height.equalTo(56)
            make.left.top.equalToSuperview().inset(16)
        }

        let position = CGPoint(x: 28, y: 28)
        circularProgressBar = CircularProgressBar(radius: 21, position: position, innerTrackColor: .stepperInnerColor, outerTrackColor: .stepperOuterColor, lineWidth: 4)
        circularView.layer.addSublayer(circularProgressBar)
    }

    func createBox() {
        self.layer.backgroundColor = UIColor.disabledWhite.cgColor
        self.layer.cornerRadius = 10

        self.snp.makeConstraints({ (make) in
            make.height.equalTo(88)
        })
    }

    func createLabel() {
        label.backgroundColor = UIColor.clear
        label.textColor = .stepperInnerColor
        label.font = .medium(size: 16)
        label.text = title

        self.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.height.equalTo(25)
            make.right.top.equalToSuperview().inset(20)
            make.left.equalTo(circularView.snp.right).offset(10)
        })
    }

    func createDetailsLabel() {
        detailsLabel.backgroundColor = UIColor.clear
        detailsLabel.textColor = .gullGray
        detailsLabel.font = .regular(size: 14)
        detailsLabel.text = title

        self.addSubview(detailsLabel)
        detailsLabel.snp.makeConstraints({ (make) in
            make.height.equalTo(25)
            make.right.equalToSuperview().inset(10)
            make.left.equalTo(circularView.snp.right).offset(10)
            make.top.equalTo(label.snp.bottom)
        })
    }
}

public class CircularProgressBar: CALayer {

    private var circularPath: UIBezierPath!
    private var innerTrackShapeLayer: CAShapeLayer!
    private var outerTrackShapeLayer: CAShapeLayer!
    private let rotateTransformation = CATransform3DMakeRotation(-.pi / 2, 0, 0, 1)
    private var completedLabel: UILabel!
    public var progressLabel: UILabel!
    public var isUsingAnimation: Bool!
    public var totalProgress: Int = 1
    public var currentProgress: Int = 0 {
        didSet {
            progressLabel.text = "\(currentProgress)/\(totalProgress)"
            self.progress = CGFloat((currentProgress * 100) / totalProgress)
        }
    }

    private var progress: CGFloat = 0 {
        didSet {
            innerTrackShapeLayer.strokeEnd = progress / 100
        }
    }

    public init(radius: CGFloat, position: CGPoint, innerTrackColor: UIColor, outerTrackColor: UIColor, lineWidth: CGFloat) {
        super.init()

        circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        outerTrackShapeLayer = CAShapeLayer()
        outerTrackShapeLayer.path = circularPath.cgPath
        outerTrackShapeLayer.position = position
        outerTrackShapeLayer.strokeColor = outerTrackColor.cgColor
        outerTrackShapeLayer.fillColor = UIColor.clear.cgColor
        outerTrackShapeLayer.lineWidth = lineWidth
        outerTrackShapeLayer.strokeEnd = 1
        outerTrackShapeLayer.lineCap = CAShapeLayerLineCap.round
        outerTrackShapeLayer.transform = rotateTransformation
        addSublayer(outerTrackShapeLayer)

        innerTrackShapeLayer = CAShapeLayer()
        innerTrackShapeLayer.strokeColor = innerTrackColor.cgColor
        innerTrackShapeLayer.position = position
        innerTrackShapeLayer.strokeEnd = progress
        innerTrackShapeLayer.lineWidth = lineWidth
        innerTrackShapeLayer.lineCap = CAShapeLayerLineCap.round
        innerTrackShapeLayer.fillColor = UIColor.clear.cgColor
        innerTrackShapeLayer.path = circularPath.cgPath
        innerTrackShapeLayer.transform = rotateTransformation
        addSublayer(innerTrackShapeLayer)

        progressLabel = UILabel()
        let size = CGSize(width: radius, height: radius)
        let origin = CGPoint(x: position.x, y: position.y)
        progressLabel.frame = CGRect(origin: origin, size: size)
        progressLabel.center = position
        progressLabel.center.y = position.y - 2
        progressLabel.font = UIFont.regular(size: Int(radius * 0.65))
        progressLabel.text = "0%"
        progressLabel.textColor = .stepperInnerColor
        progressLabel.textAlignment = .center
        insertSublayer(progressLabel.layer, at: 0)
    }

    public override init(layer: Any) {
        super.init(layer: layer)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
