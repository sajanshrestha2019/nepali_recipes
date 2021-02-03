//
//  RecipeDownloader.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 12/4/20.
//

import Foundation
import Combine

struct RecipeDownloader {
   
    static func getRecipes(for url: URL) -> AnyPublisher<[Recipe], Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkError.invalidServerResponse
                }
                return data
            }
            .decode(type: [Recipe].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
