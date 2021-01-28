//
//  TestView.swift
//  NSS
//
//  Created by Fitzgerald Afful on 17/01/2021.
//
import Foundation
import UIKit
import SnapKit

private typealias ButtonViewHelper = ViewHelper.Button
private typealias TextFieldViewHelper = ViewHelper.TextField

protocol TestTwoViewDelegate: AnyObject {
}

class TestTwoView: UIView {

    let buttonSection = UIView()
    var infoBanner = InfoView()
    var badScoreBanner = InfoView()
    var goodScoreBanner = InfoView()
    var fairScoreBanner = InfoView()
    var appointmentCardView = AppointmentCardView()
    var actionCard = ActionCard()
    var uploadView = UploadView()
    var uploadTimer: Timer!

    weak var delegate: TestTwoViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    convenience init(delegate: TestTwoViewDelegate?) {
        self.init(frame: CGRect())
        self.delegate = delegate
        self.createViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createViews() {
        createButtonSection()
        createInfoBanner()
        createFairIdentityScoreBanner()
        createBadIdentityScoreBanner()
        createGoodIdentityScoreBanner()
        createAppointmentCardView()
        createActionCard()
        createUploadView()
    }

    func createButtonSection() {
        buttonSection.backgroundColor = UIColor.init(hexString: "#e5e5e5")
        self.addSubview(buttonSection)
        buttonSection.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(90)
            make.height.equalTo(750)
        })
    }

    func createInfoBanner() {
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: "Registration for posting closes on ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.subtleGrey, NSAttributedString.Key.font: UIFont.regular(size: 13)]))
        text.append(NSAttributedString(string: "September 30, 2020.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.subtleGrey, NSAttributedString.Key.font: UIFont.bold(size: 13)]))
        infoBanner = InfoView(message: text, type: .infoBanner)
        buttonSection.addSubview(infoBanner)
        infoBanner.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(buttonSection.snp.top).offset(18)
            make.height.equalTo(60)
        })
    }

    func createFairIdentityScoreBanner() {
        fairScoreBanner = InfoView(message: NSAttributedString(string: "Your identity match score is fair. Information provided might need further investigation.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.subtleGrey, NSAttributedString.Key.font: UIFont.regular(size: 13)]), type: .fairIdentityScore)
        buttonSection.addSubview(fairScoreBanner)
        fairScoreBanner.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(infoBanner.snp.bottom).offset(18)
            make.height.equalTo(60)
        })
    }

    func createBadIdentityScoreBanner() {
        badScoreBanner = InfoView(message: NSAttributedString(string: "Your identity match score is bad. Information provided might need further investigation.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.subtleGrey, NSAttributedString.Key.font: UIFont.regular(size: 13)]), type: .badIdentityScore)
        buttonSection.addSubview(badScoreBanner)
        badScoreBanner.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(fairScoreBanner.snp.bottom).offset(18)
            make.height.equalTo(60)
        })
    }

    func createGoodIdentityScoreBanner() {
        goodScoreBanner = InfoView(message: NSAttributedString(string: "Your identity match score is good.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.subtleGrey, NSAttributedString.Key.font: UIFont.regular(size: 13)]), type: .goodIdentityScore)
        buttonSection.addSubview(goodScoreBanner)
        goodScoreBanner.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(badScoreBanner.snp.bottom).offset(18)
            make.height.equalTo(60)
        })
    }

    func createAppointmentCardView() {
        buttonSection.addSubview(appointmentCardView)
        appointmentCardView.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(goodScoreBanner.snp.bottom).offset(18)
            make.height.equalTo(100)
        })
    }

    func createActionCard() {
        buttonSection.addSubview(actionCard)
        actionCard.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(appointmentCardView.snp.bottom).offset(20)
            make.height.equalTo(220)
        })
    }

    func createUploadView() {
        uploadView = UploadView(title: "Transcript", delegate: self)
        buttonSection.addSubview(uploadView)
        uploadView.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(actionCard.snp.bottom).offset(5)
            make.height.equalTo(102)
        })
    }

}

extension TestTwoView: UploadViewDelegate {
    func didStartUpload() {
        print("Upload Started")
        self.uploadTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
    }

    @objc func updateProgressView() {
        uploadView.setProgress(progress: uploadView.getProgress() + 0.05)
    }

    func didCancelUpload() {
        uploadTimer.invalidate()
        print("Upload Canceled")
    }

    func didFinishUpload() {
        print("Upload Finished")
        uploadTimer.invalidate()
    }

    func browseFileToUploadSelected() {
        uploadView.fileName = "James Ahorlu's transcript.pdf"
        uploadView.startUpload()
    }
}
