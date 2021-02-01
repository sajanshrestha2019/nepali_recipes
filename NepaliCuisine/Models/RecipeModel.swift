//
//  RecipeData.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 12/3/20.
//

import SwiftUI
import Combine

class RecipeModel: ObservableObject {
    
    private var allRecipes = [Recipe]() {
        didSet {
            if !fetchedRecipesSaved {
                saveFetchedRecipes()
            }
            fetchedRecipesSaved = true
            self.recipeLoading = false
            
            setRecipesForCurrentCategory()
        }
    }
    
    @Published var categoryRecipes = [Recipe]()
    
    private func setRecipesForCurrentCategory() {
        guard let category = categories.first else { return }
        
        updateRecipes(for: category)
    }
        
    @Published var categories = [RecipeCategory]() {
        didSet {
            fetchRecipes()
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
        RecipeFileManager.save(allRecipes)
    }
    
    private func fetchRecipes() {
        recipesSubscriber = RecipeDownloader.getRecipes()
            .replaceError(with: [])
            .assign(to: \.allRecipes, on: self)
    }
    
    func updateRecipes(for category: RecipeCategory) {
        selectedCategory = category
        categoryRecipes = RecipeFileManager.getRecipesFor(for: category)
    }
    
    
    private var fetchedRecipesSaved = false
}
