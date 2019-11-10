//
//  ErrorView.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

final class ErrorView: UIView {
    struct Actions {
        var tryAgain = PublishSubject<Void>()
    }
    var actions = Actions()
    
    private let disposeBag = DisposeBag()
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
    
    private lazy var tryAgainButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("error_try_again".localized, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.rx.tap.bind(to: self.actions.tryAgain).disposed(by: disposeBag)
        btn.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        return btn
    }()

    // MARK: - Constraints
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
    
    private var tryAgainConstraints: [NSLayoutConstraint] {
        return [
            tryAgainButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 10),
            tryAgainButton.centerXAnchor.constraint(equalTo: errorLabel.centerXAnchor)
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

    // MARK: - Helper
    private func setup() {
        addSubview(image)
        addSubview(errorLabel)
        addSubview(tryAgainButton)
        imageConstraint.activate()
        labelConstraint.activate()
        tryAgainConstraints.activate()
    }
}
