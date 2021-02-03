//
//  ContentView.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 11/30/20.
//

import SwiftUI

struct HomePageView: View {
    
    @ObservedObject var homePageModel: HomePageModel
        
    var body: some View {
        
        if homePageModel.loadingData {
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
                    MainSection(homePageModel: homePageModel)
                        .padding(.top)
                }
                .padding(.leading)
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


struct MainSection: View {
    var homePageModel: HomePageModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: verticalSpacing) {
                RecipesScrollView(title: "Recipes", recipes: homePageModel.allRecipes, recipeType: .all)
                RecipesScrollView(title: "Popular", recipes: homePageModel.popularRecipes, recipeType: .popular)
                CategoryScrollView(categories: homePageModel.categories)
                
            }
        }
    }
    
    // MARK: - Constants
    private let verticalSpacing: CGFloat = 25
}

struct RecipesScrollView: View {
    var title: String
    var recipes: [Recipe]
    var recipeType: RecipeType
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .titled(fontSize: 24)
                Spacer()
                
                NavigationLink(destination: RecipeListView(recipeListModel: RecipeListModel(for: recipeType))) {
                    Text("View All")
                        .foregroundColor(RecipeApp.primaryColor)
                        .headline(fontSize: 14)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 6))
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: spacing) {
                    ForEach(recipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(for: recipe)) {
                            VStack(alignment: .leading) {
                                RecipeCardView(recipe: recipe)
                                    .frame(width: 150, height: 100)
                                Text(recipe.name)
                                    .headline(fontSize: 14)
                                    .foregroundColor(.gray)
                                    .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 0))
                            }
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
            .shadow(color: Color.gray, radius: shadowRadius, x: 3, y: 3)
        }
    }
    
    // MARK:- RecipeCardView Constants
    private let cornerRadius: CGFloat = 8
    private let shadowRadius: CGFloat = 4
}

struct CategoryScrollView: View {
    var categories: [RecipeCategory]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recipes by Category")
                .titled(fontSize: 24)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(categories) { category in
                        let recipeListModel = RecipeListModel(for: .recipesByCategory(id: category.id, name: category.name))
                        NavigationLink(
                            destination: RecipeListView(recipeListModel: recipeListModel),
                            label: {
                                ZStack {
                                    Circle()
                                        .frame(width: 80, height: 80)
                                        .foregroundColor(RecipeApp.primaryColor)

                                    Text(category.name)
                                        .headline(fontSize: 12)
                                        .foregroundColor(.white)
                                        .layoutPriority(-1)
                                }
                            })
                    }
                }
            }
        }
    }
}
