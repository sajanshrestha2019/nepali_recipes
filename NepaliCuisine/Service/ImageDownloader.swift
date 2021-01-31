//
//  ImageDataDownloader.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 12/5/20.
//

import Foundation
import Combine
import UIKit

enum NetworkError: Error {
    case invalidServerResponse
}

struct ImageDownloader {
    static func getImage(for imageUrl: URL) -> AnyPublisher<UIImage?, Never> {
        URLSession.shared.dataTaskPublisher(for: imageUrl)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkError.invalidServerResponse
                }
                return data
            }
            .replaceError(with: Data())
            .map { UIImage(data: $0) }
            .replaceNil(with: UIImage())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
