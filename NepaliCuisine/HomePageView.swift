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
                ZStack {
                    BackgroundColorView(color: #colorLiteral(red: 0.9639671445, green: 0.9685655236, blue: 0.9858184457, alpha: 1))
                    VStack(alignment: .leading, spacing: verticalSpacing) {
                        HeaderSection()
                        MainSection(homePageModel: homePageModel)
                    }
                    .padding(.leading)
                    .navigationBarHidden(true)
                }
                
                Text("Select a category")
                    .titled()
            
            }
        }
    }
    
    // MARK: - Constants
    private let verticalSpacing: CGFloat = 24
}


struct BackgroundColorView: View {
    var color: UIColor
    var body: some View {
        Color(color).edgesIgnoringSafeArea(.all)
    }
}


struct HeaderSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: verticalSpacing) {
            Text(greetingText)
                .titled()
            Text(questionText)
                .font(Font.custom("Raleway-Regular", size: questionTextSize))
                .foregroundColor(RecipeApp.primaryColor)
        }
    }
    
    // MARK:- Constants
    private let greetingText = "Hello, Foodie!"
    private let questionText = "What are you cooking today?"
    private let questionTextSize: CGFloat = 22
    private let verticalSpacing: CGFloat = 10
}


struct MainSection: View {
    var homePageModel: HomePageModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: verticalSpacing) {
                CategoryScrollView(categories: homePageModel.categories)
                RecipesScrollView(title: "Recipes", recipes: homePageModel.allRecipes, recipeType: .all)
                RecipesScrollView(title: "Popular", recipes: homePageModel.popularRecipes, recipeType: .popular)
            }
        }
    }
    
    // MARK: - Constants
    private let verticalSpacing: CGFloat = 30
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
            HorizontalScrollView(items: recipes) { recipe in
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
        HorizontalScrollView(items: categories) { category in
            VStack {
                NetworkImage(url: category.icon)
                    .frame(width: 50, height: 50)
                Text(category.name)
                    .foregroundColor(.black)
                    .headline(fontSize: 12)
                    .layoutPriority(-1)
                
            }.frame(width: 70)
        }
    }
}
