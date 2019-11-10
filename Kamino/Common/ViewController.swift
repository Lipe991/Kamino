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
    
    private lazy var loadingView = UIView() // TODO: - remove when a proper loading screen is implemented
    
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
        
        // viewModel.state.subscribe(onError: handleError).disposed(by: disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loadingView.frame = view.bounds
    }
    
    func handleError(_ error: Error) {
        guard let error = error as? ErrorType else { return }
        switch error {
        case .empty:
            print("Empty")
        case .error:
            print("Error")
        }
    }
    
    private func showLoadingScreen() {
        view.addSubview(loadingView)
        view.bringSubviewToFront(loadingView)
        view.layoutSubviews()
    }
    
    private func hideLoadingScreen() {
        loadingView.removeFromSuperview()
    }
}
