//  NSLAyoutConstraint+extra.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//

import UIKit

extension Array where Element == NSLayoutConstraint {
    func activate() {
        for constraint in self {
            constraint.isActive = true
        }
    }
}
