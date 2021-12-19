//
//  ImageCell.swift
//  ImageFeed
//
//  Created by Kit on 19.12.21.
//

import UIKit
import Combine

class ImageCell: UICollectionViewCell {
    
    var vm: ImageCellModel? {
        didSet {update()}
    }
    
    let imageView = UIImageView()
    
    private var heightConstraint: NSLayoutConstraint?
    private var cancellables = Set<AnyCancellable>()
    
    private let activity: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView()
        v.style = .large
        return v
    }()
    
    private let likes: UILabel = {
        let l = UILabel()
        l.textColor = .systemPink
        l.font = .boldSystemFont(ofSize: 18)
        return l
    }()
    
    private let downloads: UILabel = {
        let l = UILabel()
        l.textColor = .systemMint
        l.font = .boldSystemFont(ofSize: 18)
        return l
    }()
    
    private let views: UILabel = {
        let l = UILabel()
        l.textColor = .systemOrange
        l.font = .boldSystemFont(ofSize: 18)
        return l
    }()
    
    var height: CGFloat {
        guard let vm = vm else {return 0}
        return vm.size.height * (UIScreen.main.bounds.width / vm.size.width)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constructView()
    }
    
    private func update() {
        
        guard let vm = vm else {return}
        
        heightConstraint?.constant = height
        
        vm.$likes
            .assign(to: \.text, on: likes)
            .store(in: &cancellables)
        
        vm.$downloads
            .assign(to: \.text, on: downloads)
            .store(in: &cancellables)
        
        vm.$views
            .assign(to: \.text, on: views)
            .store(in: &cancellables)
        
        func setImage(_ image: UIImage?) {
            imageView.image = image
            setActivity()
        }
        
        if vm.item.image == nil {
            vm.item.$image
                .receive(on: RunLoop.main)
                .sink(receiveValue: setImage)
                .store(in: &cancellables)
        } else {
            setImage(vm.item.image)
        }
    }
    
    func setActivity() {
        if vm?.item.image == nil {
            activity.startAnimating()
        } else {
            activity.stopAnimating()
        }
        activity.isHidden = vm?.item.image != nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cancellables.forEach {$0.cancel()}
        imageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constructView() {
        
        let stack = UIStackView(arrangedSubviews: [likes, downloads, views])
        stack.axis = .vertical
        stack.alignment = .leading
        
        [imageView, activity, stack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        heightConstraint = imageView.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            activity.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }
}
