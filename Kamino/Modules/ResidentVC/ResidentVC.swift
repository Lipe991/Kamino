//
//  ResidentVC.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import UIKit
import RxDataSources

final class ResidentVC: CollectionViewController<ResidentVM, CellType> {
        
    var resident: Resident!
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
        
        input.load.onNext(resident)
    }
    
    override func createDataSource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, CellType>> {
        return RxCollectionViewSectionedReloadDataSource<SectionModel<String, CellType>>(configureCell: { dataSource, collection, indexPath, item in
            
            switch item {
            case .interactive:
                break
            case .normal(let value, let title):
                if let cell = collection.dequeueReusableCell(withReuseIdentifier: "InfoCell", for: indexPath) as? InfoCell {
                    cell.populate(value: value, title: title)
                    return cell
                }
            }
            
            return UICollectionViewCell()
        })
    }
}
