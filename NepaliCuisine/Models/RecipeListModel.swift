//
//  RecipeListModel.swift
//  Nepali Recipes
//
//  Created by Sajan Shrestha on 2/2/21.
//

import Foundation
import Combine

class RecipeListModel: ObservableObject {
    @Published var recipes = [Recipe]()
    
    var subscriber: AnyCancellable!
    
    init(for recipeType: RecipeType) {
        subscriber = RecipeDownloader.getRecipes(for: recipeType.url)
            .replaceError(with: [])
            .assign(to: \.recipes, on: self)
    }
    
    
    enum RecipeType {
        case all
        case popular
        case recipesByCategory(id: String)
        
        var url: URL {
            switch self {
            case .all:
                return URL(string: "")!
            case .popular:
                return URL(string: "")!
            case .recipesByCategory(let id):
                return URL(string: "http://localhost:3000/api/\(id)/recipes")!
            }
        }
    }
}
