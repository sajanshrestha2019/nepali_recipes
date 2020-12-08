//
//  ImageDataDownloader.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 12/5/20.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidServerResponse
}

struct ImageDataDownloader {
    static func getImageData(for imageUrl: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: imageUrl)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkError.invalidServerResponse
                }
                return data
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
