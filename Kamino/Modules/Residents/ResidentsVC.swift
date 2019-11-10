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
    
    private var planet: Planet?
    
    override var layout: UICollectionViewFlowLayout {
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
        if let planet = planet {
            input.load.onNext(planet)
        }
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
        let vc = ResidentVC(resident: item)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
