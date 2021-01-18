//
//  ViewController.swift
//  NSS
//
//  Created by Fitzgerald Afful on 16/01/2021.
//

import UIKit
import SnapKit

class TestController: UIViewController {

    var testView: TestView?

    override func viewDidLoad() {
        view.backgroundColor = .white
        createViews()
        super.viewDidLoad()
    }

    func createViews() {
        testView = TestView(delegate: self)
        if let testViewUnwrapped = testView {
            self.view.addSubview(testViewUnwrapped)
            testViewUnwrapped.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
            testViewUnwrapped.borderedChevronLeftButton.isEnabled = false
        }
    }
}

extension TestController: TestViewDelegate {

}
