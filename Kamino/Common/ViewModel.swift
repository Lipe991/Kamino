//
//  ViewModel.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import RxSwift
import RxCocoa

enum ErrorType: Error {
    case error
}

enum ViewModelError {
    case error
}

protocol ViewModelProtocol {
    var isLoaded: BehaviorRelay<Bool> { get set }
    var onError: PublishSubject<ViewModelError> { get set }
    init()
}

class ViewModel: ViewModelProtocol {    
    var isLoaded = BehaviorRelay<Bool>(value: false)
    var dispiseBag = DisposeBag()
    var onError = PublishSubject<ViewModelError>()
    required init() {}
}
