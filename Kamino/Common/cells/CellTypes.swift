//
//  CellTypes.swift
//  Kamino
//
//  Created by Sandi Mihelic on 12/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import Foundation

enum CellAction {
    case open
    case like
}

enum CellType {
    case normal(value: String?, title: String)
    case interactive(value: String?, type: CellAction)
}
