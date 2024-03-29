//
//  CollectionViewController.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import Foundation
import UIKit
import RxDataSources

class CollectionViewController<VM: ViewModelProtocol & ViewModelType, Item>:ViewController<VM> where Item == VM.Output.Item {
    var input = VM.Input()
    var output: VM.Output!
    private var dataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, Item>>!
    
    var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 55) / 2
        layout.itemSize = CGSize(width: width, height: 50)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.headerReferenceSize = .zero
        return layout
    }

    private lazy var header: HeaderView = {
        let header = HeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()

    private lazy var collection: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 170, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 170, left: 0, bottom: 0, right: 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(InfoCell.self, forCellWithReuseIdentifier: InfoCell.reuseIdentifier)
        collectionView.register(InteractiveCell.self, forCellWithReuseIdentifier: InteractiveCell.reuseIdentifier)
        collectionView.register(ResidentCell.self, forCellWithReuseIdentifier: ResidentCell.reuseIdentifier)
        return collectionView
    }()
    
    // MARK: - Constraints
    private var headerConstraints: [NSLayoutConstraint] {
        return [
            header.leftAnchor.constraint(equalTo: view.leftAnchor),
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.rightAnchor.constraint(equalTo: view.rightAnchor),
            header.heightAnchor.constraint(equalToConstant: 175)
        ]
    }

    private var collectionConstraints: [NSLayoutConstraint] {
        return [
            collection.leftAnchor.constraint(equalTo: view.leftAnchor),
            collection.topAnchor.constraint(equalTo: view.topAnchor),
            collection.rightAnchor.constraint(equalTo: view.rightAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = createDataSource()
        setup()
        bind()
    }

    // MARK: - Rx
    func createDataSource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, Item>> {
        return RxCollectionViewSectionedReloadDataSource<SectionModel<String, Item>>(configureCell: { _, _, _, _ in
            return UICollectionViewCell()
        })
    }

    func itemSelected(item: Item) {}
    
    // MARK: - Helpers
    private func setup() {
        view.backgroundColor = .white
        view.addSubview(collection)
        view.addSubview(header)
        collectionConstraints.activate()
        headerConstraints.activate()
        header.backButtonVisible = (self.navigationController?.viewControllers.count ?? 0) > 1
    }

    private func bind() {
        output = self.viewModel.transform(from: input)
        output.items.drive(collection.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        output.name.drive(header.planetName.rx.text).disposed(by: disposeBag)
        output.image.drive(header.image).disposed(by: disposeBag)

        collection.rx.modelSelected(Item.self).subscribe(onNext: { [weak self] (type) in
            self?.itemSelected(item: type)
        }).disposed(by: disposeBag)

        header.actions.open.asDriver(onErrorJustReturn: "").drive(onNext: { [weak self] (url) in
            guard let self = self, let url = url else { return }
            Managers.Navigator.shared.navigate(to: .imageView(with: url), from: self)
        }).disposed(by: disposeBag)

        header.actions.back.asDriver(onErrorJustReturn: ()).drive(onNext: { (_) in
            Managers.Navigator.shared.navigate(to: .back, from: self)
        }).disposed(by: disposeBag)
        
        actions.retry.bind(to: input.retry).disposed(by: disposeBag)
    }
}

extension CollectionViewController {
    func makeCell<T: UICollectionViewCell>(from col: UICollectionView, index: IndexPath, type: T.Type) -> T? {
        return col.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: index) as? T
    }
}
