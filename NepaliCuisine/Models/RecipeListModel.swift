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
    @Published var categoryName = ""

    var subscriber: AnyCancellable!
    
    init(for recipeType: RecipeType) {
        categoryName = recipeType.name
        subscriber = RecipeDownloader.getRecipes(for: recipeType.url)
            .replaceError(with: [])
            .assign(to: \.recipes, on: self)
    }
}
