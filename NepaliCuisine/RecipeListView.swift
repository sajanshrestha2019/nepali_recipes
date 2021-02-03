//
//  RecipeListView.swift
//  Nepali Recipes
//
//  Created by Sajan Shrestha on 2/2/21.
//

import SwiftUI

struct RecipeListView: View {
    var recipeListModel: RecipeListModel
    private let columns = [ GridItem(.adaptive(minimum: 160)) ]
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true) {
            LazyVGrid(columns: columns) {
                ForEach(recipeListModel.recipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(for: recipe)) {
                        VStack {
                            RecipeCardView(recipe: recipe)
                                .frame(height: 200)
                            Text(recipe.name)
                                .headline(fontSize: 14)
                                .foregroundColor(.gray)
                                .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 0))
                        }
                    }
                }
            }.padding()
        }
        .navigationTitle(Text(recipeListModel.categoryName))
    }
}



struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView(recipeListModel: RecipeListModel(for: .all))
    }
}
