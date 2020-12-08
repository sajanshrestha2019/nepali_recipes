//
//  RecipeData.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 12/3/20.
//

import SwiftUI
import Combine

class RecipeModel: ObservableObject {
    
    @Published var recipes = [Recipe]() {
        didSet {
            if fetchedRecipesSaved == false {
                saveFetchedRecipes()
            }
            fetchedRecipesSaved = true
            recipeLoading = false
        }
    }
    
    @Published var categories = [RecipeCategory]() {
        didSet {
            fetchRecipes(for: categories.first)
            selectedCategory = categories.first
        }
    }
    
    @Published var recipeLoading = true
    
    var selectedCategory: RecipeCategory?
    
    var recipesSubscriber: AnyCancellable?
    var categoriesSubscriber: AnyCancellable?
    
    
    init() {
        categoriesSubscriber = RecipeDownloader.getCategories()
            .replaceError(with: [])
            .assign(to: \.categories, on: self)
    }
    
    private func saveFetchedRecipes() {
        RecipeFileManager.save(recipes)
    }
    
    private func fetchRecipes(for category: RecipeCategory?) {
        guard category != nil else { return }
        recipesSubscriber = RecipeDownloader.getRecipes(category: category!)
            .replaceError(with: [])
            .assign(to: \.recipes, on: self)
    }
    
    func updateRecipes(for category: RecipeCategory) {
        selectedCategory = category
        recipes = RecipeFileManager.getRecipesFor(for: category)
    }
    
    
    private var fetchedRecipesSaved = false
}
