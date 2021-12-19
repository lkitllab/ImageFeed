//
//  DataProvider.swift
//  ImageFeed
//
//  Created by Kit on 19.12.21.
//

import Foundation
import Combine


class DataProvider {
    
    let configuration = Configuration.shared
    
    func requestImages(page: Int, perPage: Int = 20) -> Future<[UnsplashItem], Never> {
        Future { promise in
            
            let urlStr = Configuration.shared.path + "/photos?page=\(page)&per_page=\(perPage)"
            guard let url = URL(string: urlStr) else {return}
            
            var request = URLRequest(url: url)
            request.setValue("Client-ID \(Configuration.shared.accessKey)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil,
                      let images = try? JSONDecoder().decode([UnsplashItem].self, from: data)
                else {return}
                promise(.success(images))
            }.resume()
        }
    }
}
