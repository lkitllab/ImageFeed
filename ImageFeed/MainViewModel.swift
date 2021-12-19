//
//  MainViewModel.swift
//  ImageFeed
//
//  Created by Kit on 19.12.21.
//

import Foundation
import Combine
import UIKit

class MainViewModel {
    
    private let dataProvider = DataProvider()
    private let imageProvider = ImageProvider()
    
    @Published var cellModels = [ImageCellModel]()
    @Published var currentIndex = IndexPath(row: 0, section: 0)
    
    private var itemsPerPage = Configuration.shared.itemsPerPage
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        
        $currentIndex
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: currentIndexDidChange)
            .store(in: &cancellables)
        
        $cellModels
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: modelsShouldUpdate)
            .store(in: &cancellables)
    }
    
    private func currentIndexDidChange(_ index: IndexPath) {
        
        if cellModels.endIndex - index.row <= itemsPerPage / 2 {
            let page = cellModels.endIndex / itemsPerPage + 1
            load(page: page)
        }
        
        modelsShouldUpdate(models: cellModels)
    }
    
    func modelsShouldUpdate(models: [ImageCellModel]) {
        
        let new = models.elements(at: currentIndex.row, offset: 1)
        
        let toCancel = Set(new.map {$0.item.url})
        
        imageProvider.downloadsInProgress
            .filter {!toCancel.contains($0.key)}
            .forEach {$0.value.cancel()}
        
        new.filter{$0.item.image == nil}
        .forEach { [imageProvider] in
            imageProvider.startDownload(for: $0.item)
        }
    }
    
    private func load(page: Int) {
        dataProvider.requestImages(page: page, perPage: itemsPerPage)
            .map {$0.map {ImageCellModel(item: $0)}}
            .map { [cellModels] in cellModels + $0 }
            .assign(to: \.cellModels, on: self)
            .store(in: &cancellables)
    }
}
