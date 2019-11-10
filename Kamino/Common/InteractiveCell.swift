//
//  InteractiveCell.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import Foundation
import UIKit

final class InteractiveCell: UICollectionViewCell {
    private lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .black
        return lbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func populate(value: String?) {
        label.text = value
    }

    func disable() {
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        self.label.alpha = 0.5
    }

    func enable() {
        backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        self.label.alpha = 1.0
    }

    private func setup() {
        addSubview(label)

        layer.cornerRadius = 15
        layer.masksToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.enable()
    }
}
