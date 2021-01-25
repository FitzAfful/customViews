//
//  ViewHelper+DrawerCell.swift
//  NSS
//
//  Created by Fitzgerald Afful on 25/01/2021.
//

import Foundation
import UIKit

class DrawerCellView: UIView {
    private let label = UILabel()
    private let backgroundView = UIView()
    private var imageView = UIImageView()

    var title: String = "" {
        didSet {
            label.text = title
        }
    }

    var image: UIImage = UIImage(named: "overview")! {
        didSet {
            imageView.image = image
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(title: String, isSelected: Bool = false) {
        self.init(frame: CGRect())
        self.createViews()
        self.title = title
        self.isSelected = isSelected
    }

    func createViews() {
        createBox()
        createBackgroundView()
        createImageView()
        createLabel()
    }

    func createBox() {
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 10

        self.snp.makeConstraints({ (make) in
            make.height.equalTo(72)
        })
    }

    func createBackgroundView() {
        backgroundView.contentMode = .scaleAspectFit
        backgroundView.backgroundColor = .clear
        backgroundView.layer.cornerRadius = 10
        self.addSubview(backgroundView)
        backgroundView.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.left.right.top.bottom.equalToSuperview().inset(12)
        })
    }

    func createImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = image
        backgroundView.addSubview(imageView)
        imageView.snp.makeConstraints({ (make) in
            make.height.width.equalTo(20)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        })
    }

    func createLabel() {
        label.backgroundColor = UIColor.clear
        label.textColor = .black
        label.font = .regular(size: 16)
        label.text = title

        backgroundView.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(imageView.snp.right).offset(10)
            make.right.top.bottom.equalToSuperview().inset(10)
        })
    }

    var isSelected: Bool = false {
        didSet {
            if isSelected {
                self.backgroundView.backgroundColor = UIColor.defaultGreen
                self.imageView.setImageColor(color: .white)
                self.label.textColor = .white
            } else {
                self.backgroundView.backgroundColor = UIColor.clear
                self.imageView.setImageColor(color: .black)
                self.label.textColor = .black
            }
        }
    }
}
