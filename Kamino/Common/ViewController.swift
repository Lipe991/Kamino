//
//  ViewController.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import UIKit
import RxSwift
import NotificationBannerSwift

protocol ViewControllerType {
    associatedtype VM: ViewModelProtocol
    var disposeBag: DisposeBag { get }
    var viewModel: VM { get }
    init(with vm: VM)
}

class ViewController<VM: ViewModelProtocol>: UIViewController, ViewControllerType {
    var disposeBag = DisposeBag()
    var viewModel: VM
    var actions = Actions()
    
    private lazy var loadingView: LoadingView = {
        let v = LoadingView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private lazy var errorView: ErrorView = {
        let error = ErrorView()
        error.translatesAutoresizingMaskIntoConstraints = false
        error.actions.tryAgain.bind(to: self.actions.retry).disposed(by: disposeBag)
        return error
    }()
    
    // MARK: - Constraints
    private var erroViewConstraints: [NSLayoutConstraint] {
        return [
            errorView.leftAnchor.constraint(equalTo: view.leftAnchor),
            errorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 175),
            errorView.rightAnchor.constraint(equalTo: view.rightAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
    }

    private var loadingViewConstraints: [NSLayoutConstraint] {
        return [
            loadingView.leftAnchor.constraint(equalTo: view.leftAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.rightAnchor.constraint(equalTo: view.rightAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
    }
    
    // MARK: - Init
    required init(with vm: VM = VM()) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
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

    // MARK: - Helpers
    func handleError(_ error: ErrorType) {
        switch error {
        case .error:
            self.hideLoadingScreen()
            view.addSubview(errorView)
            erroViewConstraints.activate()
            view.bringSubviewToFront(errorView)
        case .likeError:
            let banner = NotificationBanner(title: "home_like_error_title".localized, subtitle: "home_like_error_text".localized, style: .danger)
            banner.show()
        case .noError:
            self.errorView.removeFromSuperview()
        }
    }

    private func showLoadingScreen() {
        view.addSubview(loadingView)
        loadingViewConstraints.activate()
        view.bringSubviewToFront(loadingView)
        loadingView.start()
    }

    private func hideLoadingScreen() {
        loadingView.stop()
        loadingView.removeFromSuperview()
    }
}

extension ViewController {
    struct Actions {
        var retry = PublishSubject<Void>()
    }
}
