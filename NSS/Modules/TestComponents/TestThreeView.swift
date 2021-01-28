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

protocol TestThreeViewDelegate: AnyObject {
}

class TestThreeView: UIView {

    let buttonSection = UIView()
    var successTag = Tag(state: .success)
    var processingTag = Tag(state: .processing)
    var failedTag = Tag(state: .failed)

    var radioOne = GiantRadioButton()
    var radioTwo = GiantRadioButton()
    var momoView = PaymentMethodView()
    var tabLabelSelected = TabLabel(state: .selected, title: "Via USSD")
    var tabLabelNotSelected = TabLabel(state: .notSelected, title: "Via USSD")
    var stepperTwo = StepperTwo(items: [StepperLabel(state: .selected, title: "1. Confirm ID"), StepperLabel(state: .selected, title: "2. Personal Details")])
    var radioGroupView = CustomDashedView()

    weak var delegate: TestThreeViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    convenience init(delegate: TestThreeViewDelegate?) {
        self.init(frame: CGRect())
        self.delegate = delegate
        self.createViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createViews() {
        createButtonSection()
        createSuccessTag()
        createFailedTag()
        createProcessingTag()
        createRadioGroupView()
        createRadioOne()
        createRadioTwo()
        createPaymentMethodView()
        createSelectedTabLabel()
        createNotSelectedTabLabel()
        createStepperTwo()
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

    func createSuccessTag() {
        buttonSection.addSubview(successTag)
        successTag.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().inset(10)
            make.top.equalTo(buttonSection.snp.top).offset(20)
            make.width.equalTo(75)
            make.height.equalTo(32)
        })
    }

    func createFailedTag() {
        buttonSection.addSubview(failedTag)
        failedTag.snp.makeConstraints({ (make) in
            make.left.equalTo(successTag.snp.right).offset(10)
            make.top.equalTo(buttonSection.snp.top).offset(20)
            make.width.equalTo(60)
            make.height.equalTo(32)
        })
    }

    func createProcessingTag() {
        buttonSection.addSubview(processingTag)
        processingTag.snp.makeConstraints({ (make) in
            make.left.equalTo(failedTag.snp.right).offset(10)
            make.top.equalTo(buttonSection.snp.top).offset(20)
            make.width.equalTo(90)
            make.height.equalTo(32)
        })
    }

    func createRadioGroupView() {
        radioGroupView = CustomDashedView()
        radioGroupView.cornerRadius = 10
        radioGroupView.dashWidth = 1
        radioGroupView.dashColor = .gullGray
        radioGroupView.dashLength = 5
        radioGroupView.betweenDashesSpace = 5
        radioGroupView.backgroundColor = UIColor.snowDrift
        buttonSection.addSubview(radioGroupView)
        radioGroupView.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalTo(successTag.snp.bottom).offset(20)
            make.height.equalTo(230)
        })
    }

    func createRadioOne() {
        radioOne = GiantRadioButton(title: "Local", details: "Graduate from an institution here in Ghana")
        radioGroupView.addSubview(radioOne)
        radioOne.snp.makeConstraints({ (make) in
            make.left.right.top.equalToSuperview().inset(10)
            make.height.equalTo(98)
        })
    }

    func createRadioTwo() {
        radioTwo = GiantRadioButton(title: "International", details: "Graduate from an institution abroad")
        radioGroupView.addSubview(radioTwo)
        radioTwo.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalTo(radioOne.snp.bottom).offset(10)
            make.height.equalTo(98)
        })

        let radioGroup = GiantRadioGroup()
        radioOne.setRadioGroup(radioGroup: radioGroup)
        radioTwo.setRadioGroup(radioGroup: radioGroup)
        radioTwo.setSelected()
    }

    func createPaymentMethodView() {
        momoView = PaymentMethodView(title: "Mobile Money", image: UIImage(named: "Bank")!)
        buttonSection.addSubview(momoView)
        momoView.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(radioGroupView.snp.bottom).offset(20)
            make.height.equalTo(104)
        })
    }

    func createSelectedTabLabel() {
        buttonSection.addSubview(tabLabelSelected)
        tabLabelSelected.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().inset(20)
            make.width.equalTo(100)
            make.top.equalTo(momoView.snp.bottom).offset(20)
            make.height.equalTo(40)
        })
    }

    func createNotSelectedTabLabel() {
        buttonSection.addSubview(tabLabelNotSelected)
        tabLabelNotSelected.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().inset(20)
            make.width.equalTo(100)
            make.top.equalTo(tabLabelSelected.snp.bottom).offset(10)
            make.height.equalTo(40)
        })
    }

    func createStepperTwo() {
        buttonSection.addSubview(stepperTwo)
        stepperTwo.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().inset(20)
            make.width.equalTo(150)
            make.top.equalTo(tabLabelNotSelected.snp.bottom).offset(10)
            make.height.equalTo(80)
        })
    }
}
