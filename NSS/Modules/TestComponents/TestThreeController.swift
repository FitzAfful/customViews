//
//  ViewController.swift
//  NSS
//
//  Created by Fitzgerald Afful on 16/01/2021.
//

import UIKit
import SnapKit

class TestThreeController: UIViewController {

    var testThreeView: TestThreeView?

    override func viewDidLoad() {
        view.backgroundColor = .white
        createViews()
        super.viewDidLoad()
    }

    func createViews() {
        testThreeView = TestThreeView(delegate: self)
        if let testViewUnwrapped = testThreeView {
            self.view.addSubview(testViewUnwrapped)
            testViewUnwrapped.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
        }
    }
}

extension TestThreeController: TestThreeViewDelegate {

}
