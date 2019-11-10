//
//  InfoCell.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import Foundation
import UIKit

final class InfoCell: UICollectionViewCell {
    private lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.numberOfLines = 0
        return lbl
    }()

    private lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Constraints
    private var lineConstraints: [NSLayoutConstraint] {
        return [
            line.leftAnchor.constraint(equalTo: leftAnchor),
            line.rightAnchor.constraint(equalTo: rightAnchor),
            line.bottomAnchor.constraint(equalTo: bottomAnchor),
            line.heightAnchor.constraint(equalToConstant: 1)
        ]
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    // MARK: - Helpers
    func populate(value: String?, title: String) {
        label.attributedText = buildAttributedText(value: value, title: title)
    }

    private func setup() {
        addSubview(label)
        addSubview(line)
        lineConstraints.activate()
    }

    private func buildAttributedText(value: String?, title: String) -> NSAttributedString {
        let returnString = NSMutableAttributedString()
        let valueAttr = NSAttributedString(string: value ?? "-",
                                       attributes: [
                                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)])
        let titleAttr = NSAttributedString(string: title,
                                       attributes: [
                                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold),
                                        NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.3)
                                       ])
        returnString.append(valueAttr)
        returnString.append(NSAttributedString(string: "\n"))
        returnString.append(titleAttr)
        return returnString
    }
}
