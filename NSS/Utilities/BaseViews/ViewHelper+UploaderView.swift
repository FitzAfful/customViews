//
//  ViewHelper+InfoView.swift
//  NSS
//
//  Created by Fitzgerald Afful on 25/01/2021.
//

import Foundation
import UIKit
import SnapKit

protocol UploadViewDelegate: AnyObject {
    func didStartUpload()
    func didCancelUpload()
    func didFinishUpload()
    func browseFileToUploadSelected()
}

class UploadView: UIView {
    private var uploadLabel = UILabel()
    private var titleLabel = UILabel()
    private var uploadIcon = UIImageView()
    private var uploadView = CustomDashedView()
    private var state: UploadState = .upload

    private var uploadedLabel = UILabel()
    private var uploadedIcon = UIImageView()
    private var cancelButton = UIButton()
    private var uploadedView = UIView()
    private var progressView = UIProgressView()

    weak var delegate: UploadViewDelegate?

    var title: String = ""
    var fileName: String = "CTU Derrick Ablorh Transcript.pdf"

    enum UploadState {
        case upload
        case uploading
        case uploaded
    }

    public func startUpload() {
        self.setState(state: .uploading)
        delegate?.didStartUpload()
    }

    public func setProgress(progress: Float) {
        if self.state == .uploading {
            progressView.setProgress(progress, animated: true)
            if progressView.progress == 1 {
                self.setState(state: .uploaded)
                delegate?.didFinishUpload()
            }
        }
    }

    public func getProgress() -> Float {
        return progressView.progress
    }

    public func cancelDownload() {
        self.setState(state: .upload)
        delegate?.didCancelUpload()
    }

    private func setState(state: UploadState) {
        self.state = state
        switch self.state {
        case .upload:
            self.showUploadView()
        case .uploading:
            self.showUploadingView()
        case .uploaded:
            self.showUploadedView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
    }

    convenience init(title: String, delegate: UploadViewDelegate) {
        self.init(frame: CGRect())
        self.title = title
        self.delegate = delegate
        self.createViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createViews() {
        createTitleLabel(title: title)
        createUploadView()
        createUploadLabel()
        createUploadedView()
        setState(state: .upload)
    }

    private func createTitleLabel(title: String) {
        titleLabel.font = .regular(size: 14)
        titleLabel.text = title
        titleLabel.textColor = .subtleGrey
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints({(make) in
            make.left.top.equalToSuperview().inset(12)
            make.height.equalTo(22)
        })
    }

    private func createUploadView() {
        uploadView.cornerRadius = 8
        uploadView.dashWidth = 1
        uploadView.dashColor = .gullGray
        uploadView.dashLength = 5
        uploadView.betweenDashesSpace = 5
        uploadView.layer.backgroundColor = UIColor.snowDrift.cgColor
        self.addSubview(uploadView)
        uploadView.snp.makeConstraints({ (make) in
            make.height.equalTo(72)
            make.left.right.equalToSuperview().inset(12)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        })
        createProgressBar()
        createUploadedIcon()
        createUploadedLabel()
        createCancelButton()
    }

    private func createUploadLabel() {
        uploadLabel = UILabel()

        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "upload file")!.maskWithColor(color: .defaultGreen)
        attachment.bounds = CGRect(x: 0, y: -4, width: 20, height: 20)
        let attachmentString = NSAttributedString(attachment: attachment)

        let text = NSMutableAttributedString()
        text.append(attachmentString)
        text.append("   Browse file to upload".formatAsAttributed(fontSize: 14, color: .defaultGreen, isBold: false))

        uploadLabel.attributedText = text

        uploadView.addSubview(uploadLabel)
        uploadLabel.snp.makeConstraints({ (make) in
            make.centerY.centerX.equalToSuperview()
            make.height.width.equalTo(180)
        })
        uploadView.isUserInteractionEnabled = true
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(browseFileTapped))
        gesture.numberOfTapsRequired = 1
        uploadView.addGestureRecognizer(gesture)
    }

    @objc func browseFileTapped() {
        delegate?.browseFileToUploadSelected()
    }

    private func showUploadView() {
        self.uploadedView.isHidden = true
        self.uploadView.isHidden = false
        self.cancelButton.isHidden = true
    }

    private func showUploadedView() {
        self.uploadedView.isHidden = false
        self.uploadView.isHidden = true
        self.cancelButton.isHidden = false
        self.uploadedIcon.image = UIImage(named: "file")!.maskWithColor(color: .defaultGreen)
        self.uploadedLabel.textColor = .blackPearl
    }

    private func showUploadingView() {
        self.uploadedView.isHidden = false
        self.uploadView.isHidden = true
        self.cancelButton.isHidden = false
        self.uploadedIcon.image = UIImage(named: "file")!.maskWithColor(color: .gullGray)
        self.uploadedLabel.textColor = .gullGray
    }

    private func createUploadedView() {
        uploadedView.layer.cornerRadius = 8
        uploadedView.layer.backgroundColor = UIColor.disabledWhite.cgColor
        self.addSubview(uploadedView)
        uploadedView.snp.makeConstraints({ (make) in
            make.height.equalTo(64)
            make.right.equalToSuperview().inset(52)
            make.left.equalToSuperview().inset(12)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        })
    }

    private func createCancelButton() {
        cancelButton = UIButton()
        cancelButton.setImage(UIImage(named: "close"), for: .normal)
        self.addSubview(cancelButton)
        cancelButton.snp.makeConstraints({ (make) in
            make.right.equalToSuperview().inset(16)
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview().offset(24)
        })
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }

    @objc func cancelButtonTapped() {
        print("Cancel Tapped")
        cancelDownload()
    }

    private func createProgressBar() {
        progressView.progress = 0/100
        progressView.progressViewStyle = .default
        progressView.progressTintColor = .progressTintColor
        progressView.layer.cornerRadius = 8
        progressView.trackTintColor = .white
        uploadedView.addSubview(progressView)
        progressView.snp.makeConstraints({ (make) in
            make.left.bottom.top.right.equalToSuperview().inset(10)
        })
    }

    private func createUploadedLabel() {
        uploadedLabel = UILabel()
        uploadedLabel.font = .regular(size: 16)
        uploadedLabel.textColor = .blackPearl
        uploadedLabel.text = fileName

        uploadedView.addSubview(uploadedLabel)
        uploadedLabel.snp.makeConstraints({ (make) in
            make.left.equalTo(uploadedIcon.snp.right).offset(8)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(22)
            make.centerY.equalToSuperview()
        })
    }

    private func createUploadedIcon() {
        uploadedIcon.image = UIImage(named: "file")!.maskWithColor(color: .defaultGreen)
        uploadedIcon.contentMode = .scaleAspectFit
        uploadedView.addSubview(uploadedIcon)
        uploadedIcon.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.left.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
}

class CustomDashedView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var dashWidth: CGFloat = 0
    @IBInspectable var dashColor: UIColor = .clear
    @IBInspectable var dashLength: CGFloat = 0
    @IBInspectable var betweenDashesSpace: CGFloat = 0

    var dashBorder: CAShapeLayer?

    override func layoutSubviews() {
        super.layoutSubviews()
        dashBorder?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = dashWidth
        dashBorder.strokeColor = dashColor.cgColor
        dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        if cornerRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }
}
