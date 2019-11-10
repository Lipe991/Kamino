//
//  ErrorView.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import Foundation
import UIKit

final class ErrorView: UIView {
    private lazy var image: UIImageView = {
        let view = UIImageView()
        view.image = R.image.error()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var errorLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "error_text".localized
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private var labelConstraint: [NSLayoutConstraint] {
        return [
            errorLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 15),
            errorLabel.centerXAnchor.constraint(equalTo: image.centerXAnchor)
        ]
    }
    
    private var imageConstraint: [NSLayoutConstraint] {
        return [
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 60),
            image.heightAnchor.constraint(equalToConstant: 60)
        ]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(image)
        addSubview(errorLabel)
        imageConstraint.activate()
        labelConstraint.activate()
    }
}
