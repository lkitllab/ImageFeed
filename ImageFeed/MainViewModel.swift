//
//  MainViewModel.swift
//  ImageFeed
//
//  Created by Kit on 19.12.21.
//

import Foundation

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
    }
    
    private func currentIndexDidChange(_ index: IndexPath) {
        if cellModels.endIndex - index.row <= itemsPerPage / 2 {
            let page = cellModels.endIndex / itemsPerPage + 1
            load(page: page)
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
