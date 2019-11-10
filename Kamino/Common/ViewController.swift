//
//  ViewController.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import UIKit
import RxSwift

protocol ViewControllerType {
    associatedtype VM: ViewModelProtocol
    var disposeBag: DisposeBag { get }
    var viewModel: VM { get }
    init(with vm: VM)
}

class ViewController<VM: ViewModelProtocol>: UIViewController, ViewControllerType {
    var disposeBag = DisposeBag()

    var viewModel: VM

    private lazy var loadingView: LoadingView = {
        let v = LoadingView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private lazy var errorView: ErrorView = {
        let error = ErrorView()
        error.translatesAutoresizingMaskIntoConstraints = false
        return error
    }()

    required init(with vm: VM = VM()) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.isLoaded.asDriver().drive(onNext: { [weak self] (isLoaded) in
            isLoaded ? self?.hideLoadingScreen() : self?.showLoadingScreen()
        }).disposed(by: disposeBag)

        viewModel.onError.observeOn(MainScheduler.instance).subscribe({ [weak self] (err) in
            guard let self = self, let error = err.event.element else { return }
            self.handleError(error)
        }).disposed(by: disposeBag)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loadingView.frame = view.bounds
    }

    func handleError(_ error: ErrorType) {
        switch error {
        case .error:
            self.hideLoadingScreen()
            view.addSubview(errorView)
            [
                errorView.leftAnchor.constraint(equalTo: view.leftAnchor),
                errorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 175),
                errorView.rightAnchor.constraint(equalTo: view.rightAnchor),
                errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ].activate()
            view.bringSubviewToFront(errorView)
        }
    }

    private func showLoadingScreen() {
        view.addSubview(loadingView)
        [
            loadingView.leftAnchor.constraint(equalTo: view.leftAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.rightAnchor.constraint(equalTo: view.rightAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].activate()
        view.bringSubviewToFront(loadingView)
        loadingView.start()
    }

    private func hideLoadingScreen() {
        loadingView.stop()
        loadingView.removeFromSuperview()
    }
}
