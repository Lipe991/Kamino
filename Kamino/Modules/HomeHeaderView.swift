//
//  HomeHeaderView.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

final class HomeHeaderView: UIView {
    
    var disposeBag = DisposeBag()
    var image = PublishSubject<String?>()
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .blue
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 2
        return image
    }()
    
    lazy var planetName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = .white
        return lbl
    }()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = R.color.headerColor()
        addSubview(imageView)
        addSubview(planetName)
        imageConstraints.activate()
        nameConstraints.activate()
    }
    
    private func bind() {
        image.subscribe(onNext: { [weak self] (url) in
            guard let self = self, let url = URL(string: url ?? "") else { return }
            self.imageView.kf.setImage(with: url, placeholder: nil)
        }).disposed(by: disposeBag)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        imageView.clipsToBounds = true
    }
}
