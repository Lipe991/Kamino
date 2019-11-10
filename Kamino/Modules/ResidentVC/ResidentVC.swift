//
//  ResidentVC.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import UIKit
import RxDataSources

final class ResidentVC: ViewController<ResidentVM> {
    
    private var dataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, CellType>>!
    private var resident: Resident?
    
    private lazy var header: HomeHeaderView = {
        let header = HomeHeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        // TODO: - Move this to Utils
        let width = (UIScreen.main.bounds.width - 55) / 2
        layout.itemSize = CGSize(width: width, height: 50)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 25)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        return layout
    }
    
    private lazy var collection: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 180, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 180, left: 0, bottom: 0, right: 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(InfoCell.self, forCellWithReuseIdentifier: "InfoCell")
        collectionView.register(InteractiveCell.self, forCellWithReuseIdentifier: "InteractiveCell")
        return collectionView
    }()
    
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
    
    convenience init(resident: Resident, vm: VM = VM()) {
        self.init(with: vm)
        self.resident = resident
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(with vm: VM = VM()) {
        super.init(with: vm)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collection)
        view.addSubview(header)
        collectionConstraints.activate()
        headerConstraints.activate()
        
        let input = ResidentVM.Input()
        dataSource = createDataSource()
        let output = self.viewModel.transform(input: input)
        output.items.drive(collection.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        output.name.drive(header.planetName.rx.text).disposed(by: disposeBag)
        output.image.drive(header.image).disposed(by: disposeBag)
        
        header.open.subscribe(onNext: { [weak self] (url) in
            guard let self = self, let url = url else { return }
            self.present(ImageViewVC(image: url), animated: true, completion: nil)
        }).disposed(by: disposeBag)

        if let resident = self.resident {
            input.load.onNext(resident)
        }
    }
}

extension ResidentVC {
    private func createDataSource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, CellType>> {
        let ds = RxCollectionViewSectionedReloadDataSource<SectionModel<String, CellType>>(configureCell: { dataSource, collection, indexPath, item in
            
            switch item {
            case .interactive(let value):
                if let cell = collection.dequeueReusableCell(withReuseIdentifier: "InteractiveCell", for: indexPath) as? InteractiveCell {
                    cell.populate(value: value)
                    return cell
                }
            case .normal(let value, let title):
                if let cell = collection.dequeueReusableCell(withReuseIdentifier: "InfoCell", for: indexPath) as? InfoCell {
                    cell.populate(value: value, title: title)
                    return cell
                }
            }
            
            return UICollectionViewCell()
        })
        return ds
    }
}
