//
//  ContentView.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 11/30/20.
//

import SwiftUI

struct HomePageView: View {
    
    @ObservedObject var recipeModel: RecipeModel
        
    var body: some View {
        if recipeModel.recipeLoading {
            Spinner()
                .frame(width: 100, height: 100)
        }
        else {
            NavigationView {
                VStack(alignment: .leading, spacing: verticalSpacing) {
                    Text(greetingText)
                        .titled()
                    Text(questionText)
                        .font(Font.custom("Raleway-Regular", size: questionTextSize))
                        .foregroundColor(RecipeApp.primaryColor)
                    CategoryScrollView(recipeModel: recipeModel)
                        .padding(.vertical)
                    
                    RecipeVerticalScrollView(recipes: recipeModel.recipes)
                }
                .padding()
                .navigationBarHidden(true)
                
                Text("Select a category")
                    .titled()
            }
        }
    }
    
    // MARK: - Constants 0
    private let greetingText = "Hello, Foodie!"
    private let questionText = "What are you cooking today?"
    private let verticalSpacing: CGFloat = 10
    private let questionTextSize: CGFloat = 22

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomePageView(recipeModel: RecipeModel())
        }
    }
}


struct CategoryScrollView: View {
    
    @ObservedObject var recipeModel: RecipeModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(recipeModel.categories) { category in
                    CategoryView(category: category, isSelected: recipeModel.selectedCategory == category) {
                        recipeModel.updateRecipes(for: category)
                    }
                }
            }
        }
    }
}

struct CategoryView: View {
    var category: RecipeCategory
    var isSelected: Bool
    var action: () -> ()
    var body: some View {
        Button(action: action, label: {
            Text(category.name)
                .padding(EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10))
                .background(isSelected ? RecipeApp.focusedColor : RecipeApp.secondaryColor)
                .foregroundColor(isSelected ? Color.white : Color.black)
                .cornerRadius(10)
        })
    }
}


struct RecipeVerticalScrollView: View {
        
    var recipes: [Recipe]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: verticalSpacing) {
                HorizontalScrollView(recipes: recipes)
                HorizontalScrollView(recipes: recipes)
                HorizontalScrollView(recipes: recipes)
            }
        }
    }
    
    // MARK: - Constants
    private let verticalSpacing: CGFloat = 25
}

struct HorizontalScrollView: View {
    var recipes: [Recipe]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(alignment: .leading) {
                Text("All")
                    .titled(fontSize: 20)
                HStack(spacing: spacing) {
                    ForEach(recipes) { recipe in
                        VStack(alignment: .leading) {
                            RecipeCardView(recipe: recipe)
                                .frame(width: 150, height: 100)
                            Text(recipe.name)
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
    }
    // MARK: - Constants
    private let spacing: CGFloat = 10
}

struct RecipeCardView: View {
    
    var recipe: Recipe
    
    var body: some View {
        
        GeometryReader { geometry in
            let minimum = min(geometry.size.width, geometry.size.height)
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(Color(UIColor(hex: recipe.color) ?? UIColor.systemPink))
                
                NetworkImage(url: recipe.imageUrl)
                    .frame(width: minimum * 0.7, height: minimum * 0.9)
            }
            .shadow(radius: shadowRadius)
        }
    }
    
    // MARK:- RecipeCardView Constants
    private let cornerRadius: CGFloat = 8
    private let shadowRadius: CGFloat = 4
}


struct RecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCardView(recipe: Recipe.testRecipe)
            .frame(width: 300, height: 300)
    }
}
