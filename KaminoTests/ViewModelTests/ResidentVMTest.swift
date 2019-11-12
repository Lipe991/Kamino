//
//  ResidentVMTest.swift
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

class ResidentVMTest: XCTestCase {

    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!
    var viewModel: ResidentVM!
    var resident: Resident!
    
    override func setUp() {
        super.setUp()
        self.resident = MockLoader.createResident()
        self.scheduler = TestScheduler(initialClock: 0)
        self.disposeBag = DisposeBag()
        self.viewModel = ResidentVM(with: resident)
    }
    
    override func tearDown() {
        viewModel = nil
        resident = nil
        scheduler = nil
        disposeBag = nil
        super.tearDown()
    }

    func testImage() {
        let input = ResidentVM.Input()
        let output = viewModel.transform(from: input)

        let imageObserver = scheduler.createObserver(String?.self)
        let expectedUrl = "http://www.cinemablend.com/images/news_img/42742/star_wars_42742.jpg"
        output.image.drive(imageObserver).disposed(by: disposeBag)

        scheduler.createHotObservable([.next(10, resident)])
            .bind(to: input.load)
            .disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(imageObserver.events, [.next(10, expectedUrl)])
    }
    
    func testName() {
        let input = ResidentVM.Input()
        let output = viewModel.transform(from: input)

        let nameObserver = scheduler.createObserver(String?.self)

        output.name.drive(nameObserver).disposed(by: disposeBag)

        scheduler.createHotObservable([.next(10, resident)])
            .bind(to: input.load)
            .disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(nameObserver.events, [.next(10, "Boba Fett")])
    }
    
    func testItems() {
        let input = ResidentVM.Input()
        let output = viewModel.transform(from: input)

        let itemsObserver = scheduler.createObserver(Int.self)

        output.items.map { $0.first?.items.count ?? 0 }.drive(itemsObserver).disposed(by: disposeBag)

        scheduler.createHotObservable([.next(10, resident)])
            .bind(to: input.load)
            .disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(itemsObserver.events, [.next(10, 8)])
    }
}
