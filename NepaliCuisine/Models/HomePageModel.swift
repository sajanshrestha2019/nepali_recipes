//
//  HomePageModel.swift
//  Nepali Recipes
//
//  Created by Sajan Shrestha on 2/2/21.
//

import SwiftUI
import Combine

class HomePageModel: ObservableObject {
    
    @Published var allRecipes = [Recipe]()
    @Published var popularRecipes = [Recipe]()
    @Published var categories = [RecipeCategory]() {
        didSet {
            loadingData = false
        }
    }
    @Published var loadingData = true
    
    var subscriber: AnyCancellable!
    
    init() {
        HomePageDataDownloader.getHomePageData { homePageData in
            DispatchQueue.main.async {
                self.allRecipes = homePageData.recipes
                self.popularRecipes = homePageData.popularRecipes
                self.categories = homePageData.categories
            }
        }
    }

}

