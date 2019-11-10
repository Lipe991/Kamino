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
    case empty
    case error
}

protocol ViewModelProtocol {
    var isLoaded: ActivityIndicator { get set }
    init()
}

class ViewModel: ViewModelProtocol {    
    var isLoaded = ActivityIndicator()
    var dispiseBag = DisposeBag()
    
    required init() {}
}
