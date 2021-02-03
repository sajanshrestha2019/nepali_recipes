//
//  RecipeType.swift
//  Nepali Recipes
//
//  Created by Sajan Shrestha on 2/3/21.
//

import Foundation

enum RecipeType {
    case all
    case popular
    case recipesByCategory(id: String, name: String)
    
    var url: URL {
        switch self {
        case .all:
            return URL(string: NepaliRecipeApi.allRecipesUrl)!
        case .popular:
            return URL(string: NepaliRecipeApi.popularRecipesUrl)!
        case .recipesByCategory(let id, _):
            return URL(string: NepaliRecipeApi.url(for: id))!
        }
    }
    
    var name: String {
        switch self {
        case .all:
            return "All Recipes"
        case .popular:
            return "Popular Recipes"
        case .recipesByCategory(_, let name):
            return "\(name.capitalized)"
        }
    }
}
