//
//  ViewModel.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

enum ErrorType: Error {
    case error
    case likeError
    case noError
}

protocol ViewModelProtocol {
    var isLoaded: BehaviorRelay<Bool> { get set }
    var onError: PublishSubject<ErrorType> { get set }
}

protocol ViewModelType {
    associatedtype Input: InputType
    associatedtype Output: OutputType
    func transform(from input: Input) -> Output
}

protocol InputType {
    var retry: PublishSubject<Void> { get set }
    init()
}

protocol OutputType {
    associatedtype Item
    var name: Driver<String> { get set }
    var image: Driver<String?> { get set }
    var items: Driver<[SectionModel<String, Item>]> { get set }
}

class ViewModel: ViewModelProtocol {
    var isLoaded = BehaviorRelay<Bool>(value: false)
    var dispiseBag = DisposeBag()
    var onError = PublishSubject<ErrorType>()
}
