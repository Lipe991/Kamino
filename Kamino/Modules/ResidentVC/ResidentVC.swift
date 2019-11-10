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
    override func viewDidLoad() {
        super.viewDidLoad()
        loadResident()
    }
    override func createDataSource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, CellType>> {
        return RxCollectionViewSectionedReloadDataSource<SectionModel<String, CellType>>(configureCell: { _, collection, indexPath, item in
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
    
    private func loadResident() {
        guard let resident = viewModel.resident else { return }
        input.load.onNext(resident)
    }
}
