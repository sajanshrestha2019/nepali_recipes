//
//  RecipeListView.swift
//  Nepali Recipes
//
//  Created by Sajan Shrestha on 2/2/21.
//

import SwiftUI

struct RecipeListView: View {
    var recipeListModel: RecipeListModel
    var body: some View {
        List(recipeListModel.recipes) { recipe in
            NavigationLink(destination: RecipeDetailView(for: recipe)) {
                Text(recipe.name)
            }
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView(recipeListModel: RecipeListModel(for: .all))
    }
}
