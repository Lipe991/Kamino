//
//  HeaderView.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

final class HeaderView: UIView {
    var disposeBag = DisposeBag()
    var image = PublishSubject<String?>()
    var actions = Actions()
    var backButtonVisible: Bool = false {
        didSet {
            self.backButton.isHidden = !backButtonVisible
        }
    }

    private var currentUrl = ""

    private lazy var backButton: UIButton = {
        let btn = UIButton()
        btn.setImage(R.image.back(), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.rx.tap.asDriver().drive(onNext: { [weak self] (_) in
            self?.actions.back.onNext(())
        }).disposed(by: disposeBag)
        return btn
    }()

    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderColor = UIColor.white.cgColor
        image.image = R.image.userAvatar()
        image.layer.borderWidth = 2
        image.isUserInteractionEnabled = true
        return image
    }()

    lazy var planetName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = .white
        return lbl
    }()

    // MARK: - Constraints
    private var backConstraints: [NSLayoutConstraint] {
        let safe = self.safeAreaLayoutGuide
        return [
            backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            backButton.topAnchor.constraint(equalTo: safe.topAnchor, constant: 25),
            backButton.widthAnchor.constraint(equalToConstant: 35)
        ]
    }

    private var nameConstraints: [NSLayoutConstraint] {
        return [
            planetName.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            planetName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10)
        ]
    }

    private var imageConstraints: [NSLayoutConstraint] {
        return [
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        imageView.clipsToBounds = true
    }

    // MARK: - Helpers
    private func setup() {
        backgroundColor = R.color.headerColor()
        addSubview(imageView)
        addSubview(planetName)
        addSubview(backButton)
        imageConstraints.activate()
        nameConstraints.activate()
        backConstraints.activate()
    }

    private func bind() {
        image.subscribe(onNext: { [weak self] (url) in
            self?.currentUrl = url ?? ""
            guard let self = self, let url = URL(string: url ?? "") else { return }
            self.imageView.kf.setImage(with: url, placeholder: R.image.userAvatar())
        }).disposed(by: disposeBag)

        let tap = UITapGestureRecognizer()
        imageView.addGestureRecognizer(tap)
        tap.rx.event.map { _ in return self.currentUrl }.bind(to: actions.open).disposed(by: disposeBag)
    }
}

extension HeaderView {
    struct Actions {
        var open = PublishSubject<String?>()
        var back = PublishSubject<Void>()
    }
}
