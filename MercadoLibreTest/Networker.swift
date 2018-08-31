//
//  Networker.swift
//  MercadoLibreTest
//
//  Created by Jon Olivet on 8/28/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import Foundation

class Networker {

    // Dependency Injection for testing
    let session: URLSession
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func downloadImage(urlString: String,
                       completion: @escaping (Data) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                completion(data)
            }
        }
        task.resume()
    }
}
