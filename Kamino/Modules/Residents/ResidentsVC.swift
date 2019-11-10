//
//  ResidentsVC.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import Foundation
import RxDataSources

final class ResidentsVC: ViewController<ResidentsVM> {
    
    private var planet: Planet?
    private var dataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, Resident>>!
    
    private lazy var header: HomeHeaderView = {
        let header = HomeHeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        // TODO: - Move this to Utils
        let width = (UIScreen.main.bounds.width - 50)
        layout.itemSize = CGSize(width: width, height: 80)
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
        collectionView.register(ResidentCell.self, forCellWithReuseIdentifier: "ResidentCell")
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
    
    convenience init(planet: Planet, vm: VM = VM()) {
        self.init(with: vm)
        self.planet = planet
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
        
        let input = ResidentsVM.Input()
        dataSource = createDataSource()
        let output = self.viewModel.transform(input: input)
        output.items.drive(collection.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        output.name.drive(header.planetName.rx.text).disposed(by: disposeBag)
        output.image.drive(header.image).disposed(by: disposeBag)
        
        if let planet = planet {
            input.load.onNext(planet)
        }
        
        collection.rx.modelSelected(Resident.self).subscribe(onNext: { (resident) in
            print("Open \(resident.name)")
        }).disposed(by: disposeBag)
    }
}

extension ResidentsVC {
    private func createDataSource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, Resident>> {
        let ds = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Resident>>(configureCell: { dataSource, collection, indexPath, item in
            
            if let cell = collection.dequeueReusableCell(withReuseIdentifier: "ResidentCell", for: indexPath) as? ResidentCell {
                cell.populate(with: item)
                return cell
            }

            return UICollectionViewCell()
        })
        return ds
    }
}
