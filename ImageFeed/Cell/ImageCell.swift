//
//  ImageCell.swift
//  ImageFeed
//
//  Created by Kit on 19.12.21.
//

import UIKit
import Combine

class ImageCell: UICollectionViewCell {
    
    var vm: ImageCellModel?
    
    let imageView = UIImageView()
    
    private var heightConstraint: NSLayoutConstraint?
    private var cancellables = Set<AnyCancellable>()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constructView()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constructView() {
        
    }
}
