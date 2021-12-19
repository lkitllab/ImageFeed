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
    
    @Published var cellModels = [ImageCellModel]()
    @Published var currentIndex = IndexPath(row: 0, section: 0)
    
    private var itemsPerPage = 20
    
    var cancellables = Set<AnyCancellable>()
    
    init() {

    }
}
