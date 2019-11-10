//
//  LoadingView.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import UIKit
import MaterialActivityIndicator

final class LoadingView: UIView {
    private lazy var indicator: MaterialActivityIndicatorView = {
        let view = MaterialActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var indicatorConstraints: [NSLayoutConstraint] {
        return [
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor)
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

    // MARK: - Helpers
    private func setup() {
        backgroundColor = .white
        addSubview(indicator)
        indicatorConstraints.activate()
    }

    func start() {
        indicator.startAnimating()
    }

    func stop() {
        indicator.stopAnimating()
    }
}
