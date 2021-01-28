//
//  UIViewController.swift
//  NSS
//
//  Created by Fitzgerald Afful on 28/01/2021.
//

import Foundation
import UIKit

extension UIViewController {
    func setNavigationItem(image: UIImage, backgroundColor: UIColor = .white) {
        navigationItem.titleView = UIImageView(image: image)
        self.navigationController?.navigationBar.barTintColor = backgroundColor
    }
}
