//
//  RecipeDownloader.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 12/4/20.
//

import Foundation
import Combine

struct RecipeDownloader {
    
    static func getRecipes(category: RecipeCategory) -> AnyPublisher<[Recipe], Error> {
        let url = EndPoint.recipes(categoryId: category.id).url!
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkError.invalidServerResponse
                }
                return data
            }
            .decode(type: [Recipe].self, decoder: JSONDecoder())
            .map { recipes in
                return recipes.map { recipe in
                    var anotherRecipe = recipe
                    do {
                        let imageData = try Data(contentsOf: URL(string: recipe.imageUrl)!)
                        anotherRecipe.imageData = imageData
                    }
                    catch {
                        
                    }
                    return anotherRecipe
                }
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    static func getCategories() -> AnyPublisher<[RecipeCategory], Error> {
        let url = EndPoint.categories.url!
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkError.invalidServerResponse
                }
                return data
            }
            .decode(type: [RecipeCategory].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

enum EndPoint {
    case recipes(categoryId: String)
    case categories
    
    var url: URL? {
        switch self {
        case .recipes(let id):
            //return URL(string: "https://nameless-reaches-31983.herokuapp.com/api/\(id)/recipes")
            return URL(string: "http://localhost:3000/api/\(id)/recipes")
        case .categories:
            //return URL(string: "https://nameless-reaches-31983.herokuapp.com/api/categories")
            return URL(string: "http://localhost:3000/api/categories")
        }
    }
}
