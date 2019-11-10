//
//  ImageViewVC.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

final class ImageViewVC: UIViewController {
    private var url: String?
    private let dispiseBag = DisposeBag()
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var button: UIButton = {
        let btn = UIButton()
        btn.setImage(R.image.closeIco(), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var errorLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.text = "image_error".localized
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // MARK: - Constraints
    private var errorConstraints: [NSLayoutConstraint] {
        return [
            errorLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            errorLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
    }

    private var imageConstraints: [NSLayoutConstraint] {
        return [
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
    }
    
    private var buttonConstraints: [NSLayoutConstraint] {
        return [
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            button.widthAnchor.constraint(equalToConstant: 40),
            button.heightAnchor.constraint(equalToConstant: 40)
        ]
    }
    
    // MARK: - Init
    init(image url: String) {
        super.init(nibName: nil, bundle: nil)
        self.url = url
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(imageView)
        view.addSubview(button)

        imageConstraints.activate()
        buttonConstraints.activate()
        
        button.rx.tap.subscribe(onNext: { [weak self] (_) in
            self?.dismiss(animated: true, completion: nil)
        }).disposed(by: dispiseBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let url = URL(string: url ?? "") {
            imageView.kf.setImage(with: url, completionHandler: { [weak self] result in
                switch result {
                case .failure:
                    self?.showErrorLabel()
                case .success:
                    self?.hideErrorLabel()
                }
            })
        }
    }
    
    private func showErrorLabel() {
        view.addSubview(errorLabel)
        errorConstraints.activate()
    }
    
    private func hideErrorLabel() {
        errorLabel.removeFromSuperview()
    }
}
