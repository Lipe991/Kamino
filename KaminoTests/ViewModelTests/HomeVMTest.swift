//
//  HomeVMTest.swift
//  KaminoTests
//
//  Created by Sandi Mihelic on 12/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
import RxTest
import RxDataSources

@testable import Kamino

class HomeVMTest: XCTestCase {
    
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!
    var repo: HomeRepositoryProtocol!
    var viewModel: HomeVM!
    
    override func setUp() {
        super.setUp()
        self.scheduler = TestScheduler(initialClock: 0)
        self.disposeBag = DisposeBag()
        self.repo = MockHomeRepo()
        self.viewModel = HomeVM(with: repo)
    }
    
    override func tearDown() {
        scheduler = nil
        disposeBag = nil
        viewModel = nil
        repo = nil
        super.tearDown()
    }
    
    func testImage() {
        let input = HomeVM.Input()
        let output = viewModel.transform(from: input)

        let imageObserver = scheduler.createObserver(String?.self)
        let expectedUrl = "http://vignette4.wikia.nocookie.net/starwars/images/a/a9/Eaw_Kamino.jpg/revision/latest?cb=20090527045541"
        output.image.drive(imageObserver).disposed(by: disposeBag)

        scheduler.createHotObservable([.next(10, ())])
            .bind(to: input.load)
            .disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(imageObserver.events, [.next(0, nil), .next(10, expectedUrl)])
    }
    
    func testName() {
        let input = HomeVM.Input()
        let output = viewModel.transform(from: input)

        let nameObserver = scheduler.createObserver(String?.self)

        output.name.drive(nameObserver).disposed(by: disposeBag)

        scheduler.createHotObservable([.next(10, ())])
            .bind(to: input.load)
            .disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(nameObserver.events, [.next(0, ""), .next(10, "Kamino")])
    }
    
    func testItems() {
        let input = HomeVM.Input()
        let output = viewModel.transform(from: input)

        let itemsObserver = scheduler.createObserver(Int.self)

        output.items.map { $0.first?.items.count ?? 0 }.drive(itemsObserver).disposed(by: disposeBag)

        scheduler.createHotObservable([.next(10, ())])
            .bind(to: input.load)
            .disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(itemsObserver.events, [.next(0, 0), .next(10, 10)])
    }

}
