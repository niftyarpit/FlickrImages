//
//  ImageCollectionCell.swift
//  FlickerImages
//
//  Created by Arpit Srivastava on 16/07/20.
//  Copyright © 2020 Arpit Srivastava. All rights reserved.
//

import UIKit

class ImageCollectionCell: UICollectionViewCell {
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        imageView = UIImageView(frame: frame)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
    }

    private func configureConstraints() {
        imageView.setTranslateMask()
        let leading = imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        let trailing = imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        let top = imageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        let bottom = imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }
}
