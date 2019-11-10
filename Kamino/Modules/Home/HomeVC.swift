//
//  HomeVC.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import Foundation
import UIKit
import RxDataSources

final class HomeVC: ViewController<HomeVM> {
    
    private var dataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, CellType>>!
    private let input = HomeVM.Input()

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collection)
        view.addSubview(header)
        collectionConstraints.activate()
        headerConstraints.activate()
        
        dataSource = createDataSource()
        let output = self.viewModel.transform(input: input)
        output.items.drive(collection.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        output.name.drive(header.planetName.rx.text).disposed(by: disposeBag)
        output.image.drive(header.image).disposed(by: disposeBag)
        
        input.load.onNext("abc")
        
        collection.rx.modelSelected(CellType.self).subscribe(onNext: { [weak self] (type) in
            switch type {
            case .interactive(let value, let type):
                guard let self = self, let planet = self.viewModel.planet else { return }
                switch type {
                case .open:
                    let vc = ResidentsVC(planet: planet)
                    self.navigationController?.pushViewController(vc, animated: true)
                case .like:
                    self.input.like.onNext(())
                }
            default:
                return
            }
        }).disposed(by: disposeBag)
        
        header.open.asDriver(onErrorJustReturn: "").drive(onNext: { [weak self] (url) in
            guard let self = self, let url = url else { return }
            self.present(ImageViewVC(image: url), animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
}

extension HomeVC {
    private func createDataSource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, CellType>> {
        let ds = RxCollectionViewSectionedReloadDataSource<SectionModel<String, CellType>>(configureCell: { dataSource, collection, indexPath, item in
            
            switch item {
            case .interactive(let value, let type):
                if let cell = collection.dequeueReusableCell(withReuseIdentifier: "InteractiveCell", for: indexPath) as? InteractiveCell {
                    cell.populate(value: value)
                    switch type {
                    case .like:
                        self.viewModel.hasLiked ? cell.disable() : cell.enable()
                    default:
                        cell.enable()
                    }
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
