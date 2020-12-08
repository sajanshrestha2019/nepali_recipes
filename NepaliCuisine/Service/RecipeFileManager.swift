//
//  LocalFileManager.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 12/6/20.
//

import Foundation

struct RecipeFileManager {
    
    private static let fileName = "Recipes File"
    
    static let fileManger = FileManager.default
    
    static var recipeFileUrl: URL? {
        do {
            let fileUrl = try fileManger.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            return fileUrl.appendingPathComponent(fileName)
        }
        catch {
            print("error getting file url")
            return nil
        }
    }
    
    static func save(_ recipes: [Recipe]) {
        
        guard let recipeFileUrl = recipeFileUrl else { return }
        
        do {
            let data = try JSONEncoder().encode(recipes)
            try data.write(to: recipeFileUrl)
        }
        catch {
            print("saving error")
        }
    }
    
    static func getAllRecipes() -> [Recipe] {
        guard let recipeFileUrl = recipeFileUrl else { return [] }

        do {
            let data = try Data(contentsOf: recipeFileUrl)
            let recipes = try JSONDecoder().decode([Recipe].self, from: data)
            return recipes
        }
        catch {
            return []
        }
    }
    
    static func getRecipesFor(for category: RecipeCategory) -> [Recipe] {
        getAllRecipes().filter { $0.type.contains(category.id) }
    }
}
