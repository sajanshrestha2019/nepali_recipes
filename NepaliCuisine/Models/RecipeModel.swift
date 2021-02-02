//
//  RecipeData.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 12/3/20.
//

/*
 WHAT'S HAPPENING HERE?
    When instance of RecipeModel is initialized, it will populate the categories (if network call is successful). Once the categories are set, all recipes are fetched and assigned to 'allRecipes' property. When it is set, it will first save those recipes in the file system and then set the categoryRecipes for current category selected.
 */

import SwiftUI
import Combine

class RecipeModel: ObservableObject {
    
    init() {
        categoriesSubscriber = RecipeDownloader.getCategories()
            .replaceError(with: [])
            .assign(to: \.categories, on: self)
    }
    
    var categoriesSubscriber: AnyCancellable?
    
    @Published var categories = [RecipeCategory]() {
        didSet {
            fetchRecipes()
        }
    }
    
    private func fetchRecipes() {
        recipesSubscriber = RecipeDownloader.getRecipes()
            .replaceError(with: [])
            .assign(to: \.allRecipes, on: self)
    }
    
    var recipesSubscriber: AnyCancellable?
    
    private var allRecipes = [Recipe]() {
        didSet {
            saveFetchedRecipes()
            self.recipeLoading = false
            updateRecipes(for: categories.first) // to display recipes for first category
        }
    }
    
    private func saveFetchedRecipes() {
        RecipeFileManager.save(allRecipes)
    }
    
    @Published var recipeLoading = true
        
    func updateRecipes(for category: RecipeCategory?) {
        selectedCategory = category
        guard let newCategory = category else { return }
        categoryRecipes = RecipeFileManager.getRecipesFor(for: newCategory)
    }
    
    var selectedCategory: RecipeCategory?
    
    @Published var categoryRecipes = [Recipe]()
}
