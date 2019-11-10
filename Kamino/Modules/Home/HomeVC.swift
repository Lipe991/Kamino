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

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        input.load.onNext(())
    }

    // MARK: - CollectionViewController
    override func createDataSource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, CellType>> {
        let ds = RxCollectionViewSectionedReloadDataSource<SectionModel<String, CellType>>(configureCell: { _, collection, indexPath, item in

            switch item {
            case .interactive(let value, let type):
                if let cell = self.makeCell(from: collection, index: indexPath, type: InteractiveCell.self) {
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
                if let cell = self.makeCell(from: collection, index: indexPath, type: InfoCell.self) {
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
                Managers.Navigator.shared.navigate(to: .residents(with: planet), from: self)
            case .like:
                self.input.like.onNext(())
            }
        default:
            return
        }
    }
}
