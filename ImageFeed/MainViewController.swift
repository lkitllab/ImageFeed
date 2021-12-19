//
//  ViewController.swift
//  ImageFeed
//
//  Created by Kit on 19.12.21.
//

import UIKit
import Combine

class MainViewController: UIViewController {

    private let vm = MainViewModel()
    private let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        layout.minimumLineSpacing = 0
        
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.register(ImageCell.self, forCellWithReuseIdentifier: "cell")
        
        return v
    }()
    
    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        
        constructView()
        bind()
    }
    
    func bind() {
        
        vm.$cellModels
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [collectionView] _ in
                collectionView.reloadData()
            }).store(in: &cancellables)
        
    }
    
    private func constructView() {
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.cellModels.endIndex
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        vm.currentIndex = indexPath
        return cell
    }
}


