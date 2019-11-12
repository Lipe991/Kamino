//
//  Navigator.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import Foundation
import UIKit

enum NavigationType {
    case planet
    case residents(with: Planet)
    case resident(with: Resident)
    case imageView(with: String)
    case back
}

extension Managers {
    class Navigator {
        static let shared = Navigator()

        private init() {}

        func navigate(to type: NavigationType, from sender: UIViewController?) {
            switch type {
            case .planet:
                sender?.navigationController?.popToRootViewController(animated: true)
            case .residents(let planet):
                let vc = ResidentsVC(with: ResidentsVM(with: ResidentsRepository(), planet: planet))
                vc.input.load.onNext(planet)
                sender?.navigationController?.pushViewController(vc, animated: true)
            case .resident(let resident):
                let vc = ResidentVC(with: ResidentVM(with: resident))
                vc.input.load.onNext(resident)
                sender?.navigationController?.pushViewController(vc, animated: true)
            case .imageView(let url):
                let vc = ImageViewVC(image: url)
                sender?.present(vc, animated: true, completion: nil)
            case .back:
                sender?.navigationController?.popViewController(animated: true)
            }
        }
    }
}
