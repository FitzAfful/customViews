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

protocol TestViewDelegate: AnyObject {
}

class TestView: UIView {

    let buttonSection = UIView()
    let loginHeaderLabel = UILabel()
    var defaultButton = UIButton()
    var chevronLeftButton = UIButton()
    var chevronRightButton = UIButton()
    var borderedButton = UIButton()
    var borderedChevronLeftButton = UIButton()
    var roundButton = UIButton()
    var borderedChevronRightButton = UIButton()

    var textFieldView = LabeledTextField()
    var searchBar = BaseSearchBar()
    var dropDownButton = DropDownButton()
    var drawerCellView = DrawerCellView()
    var selectedDrawerCellView = DrawerCellView()
    var stepper = Stepper()

    weak var delegate: TestViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    convenience init(delegate: TestViewDelegate?) {
        self.init(frame: CGRect())
        self.delegate = delegate
        self.createViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createViews() {
        createButtonSection()
        createDefaultButton()
        createChevronLeftButton()
        createChevronRightButton()
        createBorderedButton()
        createBorderedChevronLeftButton()
        createBorderedChevronRightButton()
        createBaseTextField()
        createRoundArrowButton()
        createBaseSearchBar()
        createDropDownButton()
        createDrawerCellView()
        createSelectedDrawerCellView()
        createStepper()
    }

    func createButtonSection() {
        buttonSection.backgroundColor = UIColor.init(hexString: "#E3BC9A")
        self.addSubview(buttonSection)
        buttonSection.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview()
            make.topMargin.equalTo(80)
            make.height.equalTo(750)
        })
    }

    func createDefaultButton() {
        defaultButton = ButtonViewHelper.baseDefaultButton(title: "Default")
        buttonSection.addSubview(defaultButton)
        defaultButton.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().inset(10)
            make.top.equalTo(buttonSection.snp.top).offset(20)
            make.width.equalTo(130)
            make.height.equalTo(48)
        })
    }

    func createChevronLeftButton() {
        chevronLeftButton = ButtonViewHelper.baseChevronButton(title: "Chevron L", chevronPosition: .left)
        buttonSection.addSubview(chevronLeftButton)
        chevronLeftButton.snp.makeConstraints({ (make) in
            make.left.equalTo(defaultButton.snp.right).offset(10)
            make.top.equalTo(buttonSection.snp.top).offset(20)
            make.width.equalTo(130)
            make.height.equalTo(48)
        })
    }

    func createChevronRightButton() {
        chevronRightButton = ButtonViewHelper.baseChevronButton(title: "Chevron R", chevronPosition: .right)
        buttonSection.addSubview(chevronRightButton)
        chevronRightButton.snp.makeConstraints({ (make) in
            make.left.equalTo(chevronLeftButton.snp.right).offset(10)
            make.top.equalTo(buttonSection.snp.top).offset(20)
            make.width.equalTo(130)
            make.height.equalTo(48)
        })
    }

    func createBorderedButton() {
        borderedButton = ButtonViewHelper.borderedButton(title: "Bordered")
        buttonSection.addSubview(borderedButton)
        borderedButton.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().inset(10)
            make.top.equalTo(defaultButton.snp.bottom).offset(20)
            make.width.equalTo(130)
            make.height.equalTo(48)
        })
    }

    func createBorderedChevronLeftButton() {
        borderedChevronLeftButton = ButtonViewHelper.borderedChevronButton(title: "Bordered L", chevronPosition: .left)
        buttonSection.addSubview(borderedChevronLeftButton)
        borderedChevronLeftButton.snp.makeConstraints({ (make) in
            make.left.equalTo(borderedButton.snp.right).offset(10)
            make.top.equalTo(chevronLeftButton.snp.bottom).offset(20)
            make.width.equalTo(130)
            make.height.equalTo(48)
        })
    }

    func createBorderedChevronRightButton() {
        borderedChevronRightButton = ButtonViewHelper.borderedChevronButton(title: "Bordered R", chevronPosition: .right)
        buttonSection.addSubview(borderedChevronRightButton)
        borderedChevronRightButton.snp.makeConstraints({ (make) in
            make.left.equalTo(borderedChevronLeftButton.snp.right).offset(10)
            make.top.equalTo(chevronRightButton.snp.bottom).offset(20)
            make.width.equalTo(130)
            make.height.equalTo(48)
        })
    }

    func createRoundArrowButton(height: Float = 50.0) {
        roundButton = ButtonViewHelper.baseRoundImageButton(image: UIImage(named: "arrow_right")!, height: height)
        roundButton.addTarget(self, action: #selector(roundButtonTapped), for: .touchUpInside)
        buttonSection.addSubview(roundButton)
        roundButton.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(15)
            make.width.height.equalTo(height)
            make.top.equalTo(textFieldView.snp.bottom).offset(20)
        })
    }

    func createBaseTextField() {
        textFieldView = LabeledTextField(title: "Label", placeholder: "Placeholder text")
        buttonSection.addSubview(textFieldView)
        textFieldView.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(97)
            make.top.equalTo(borderedButton.snp.bottom).offset(20)
        })
    }

    func createBaseSearchBar() {
        searchBar = BaseSearchBar(placeholder: "Search")
        buttonSection.addSubview(searchBar)
        searchBar.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(97)
            make.top.equalTo(roundButton.snp.bottom).offset(20)
        })
    }

    func createDropDownButton() {
        dropDownButton = DropDownButton(placeholder: "Choose Option", dataSource: ["General Enrolment 2020/2021", "Nursing Enrolment 2020/2021", "Sub Enrolment 2018/2019"], delegate: self)
        buttonSection.addSubview(dropDownButton)
        dropDownButton.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(48)
            make.top.equalTo(searchBar.snp.bottom).offset(20)
        })
    }

    func createDrawerCellView() {
        drawerCellView = DrawerCellView()
        drawerCellView.title = "Overview"
        buttonSection.addSubview(drawerCellView)
        drawerCellView.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(72)
            make.top.equalTo(dropDownButton.snp.bottom).offset(20)
        })
    }

    func createSelectedDrawerCellView() {
        selectedDrawerCellView = DrawerCellView()
        selectedDrawerCellView.title = "Overview"
        buttonSection.addSubview(selectedDrawerCellView)
        selectedDrawerCellView.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(72)
            make.top.equalTo(drawerCellView.snp.bottom).offset(5)
        })
        selectedDrawerCellView.isSelected = true
    }

    func createStepper() {
        stepper = Stepper()
        stepper.title = "Personnel Information"
        stepper.details = "Next: Upload Documents"
        buttonSection.addSubview(stepper)
        stepper.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(88)
            make.top.equalTo(selectedDrawerCellView.snp.bottom).offset(20)
        })
        stepper.totalProgress = 3
        stepper.currentProgress = 2
    }

    @objc func roundButtonTapped() {
        textFieldView.setErrorMessage(textFieldView.textField.text.isEmpty ? "This is a required field" : nil)
        textFieldView.textField.isUserInteractionEnabled = !textFieldView.textField.isUserInteractionEnabled
    }
}

extension TestView: DropDownButtonDelegate {
    func dropDownItemSelected(index: Int, item: String) {
        print("Index: \(index), Item: \(item)")
    }
}