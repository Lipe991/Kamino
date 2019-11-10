//
//  ResidentCell.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import Foundation
import UIKit

final class ResidentCell: UICollectionViewCell {
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var imageConstraints: [NSLayoutConstraint] {
        return [
            image.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: 50),
            image.heightAnchor.constraint(equalToConstant: 50)
        ]
    }
    
    private var labelConstraints: [NSLayoutConstraint] {
        return [
            label.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 10),
            label.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        ]
    }


    private var lineConstraints: [NSLayoutConstraint] {
        return [
            line.leftAnchor.constraint(equalTo: leftAnchor),
            line.rightAnchor.constraint(equalTo: rightAnchor),
            line.bottomAnchor.constraint(equalTo: bottomAnchor),
            line.heightAnchor.constraint(equalToConstant: 1)
        ]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(with resident: Resident) {
        label.text = resident.name
        if let url = URL(string: resident.imageUrl ?? "") {
            image.kf.setImage(with: url, placeholder: R.image.userAvatar())
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        label.text = nil
    }
    
    private func setup() {
        addSubview(image)
        addSubview(label)
        addSubview(line)
        
        lineConstraints.activate()
        imageConstraints.activate()
        labelConstraints.activate()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        image.layer.cornerRadius = image.bounds.height / 2
        image.clipsToBounds = true
    }

}

extension UINavigationController: UIGestureRecognizerDelegate {

    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
