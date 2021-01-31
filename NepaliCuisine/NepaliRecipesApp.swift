//
//  NepaliCuisineApp.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 11/30/20.
//

import SwiftUI

@main
struct NepaliRecipesApp: App {
    var body: some Scene {
        WindowGroup {
            HomePageView(recipeModel: RecipeModel())
        }
    }
}
