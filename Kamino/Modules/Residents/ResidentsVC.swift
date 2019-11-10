//
//  ResidentsVC.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import Foundation
import RxDataSources

final class ResidentsVC: CollectionViewController<ResidentsVM, Resident> {
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPlanet()
    }
    
    override var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        // TODO: - Move this to Utils
        let width = (UIScreen.main.bounds.width - 50)
        layout.itemSize = CGSize(width: width, height: 80)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.headerReferenceSize = .zero
        return layout
    }
        
    override func createDataSource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, Resident>> {
        let ds = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Resident>>(configureCell: { dataSource, collection, indexPath, item in
            
            if let cell = collection.dequeueReusableCell(withReuseIdentifier: "ResidentCell", for: indexPath) as? ResidentCell {
                cell.populate(with: item)
                return cell
            }

            return UICollectionViewCell()
        })
        return ds
    }
    
    override func itemSelected(item: Resident) {
        Managers.Navigator.shared.navigate(to: .resident(with: item), from: self)
    }
    
    private func loadPlanet() {
        guard let planet = viewModel.planet else { return }
        input.load.onNext(planet)
    }
}
