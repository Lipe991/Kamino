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

final class HomeVC: CollectionViewController<HomeVM, CellType> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        input.load.onNext("10")
    }
        
    override func createDataSource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, CellType>> {
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
    
    override func itemSelected(item: CellType) {
        switch item {
        case .interactive(_, let type):
            guard let planet = self.viewModel.planet else { return }
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
    }
}
