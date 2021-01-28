//
//  ViewController.swift
//  NSS
//
//  Created by Fitzgerald Afful on 16/01/2021.
//

import UIKit
import SnapKit

class TestTwoController: UIViewController {

    var testTwoView: TestTwoView?

    override func viewDidLoad() {
        view.backgroundColor = .white
        createViews()
        super.viewDidLoad()
    }

    func createViews() {
        testTwoView = TestTwoView(delegate: self)
        if let testViewUnwrapped = testTwoView {
            self.view.addSubview(testViewUnwrapped)
            testViewUnwrapped.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
        }
    }
}

extension TestTwoController: TestTwoViewDelegate {

}
