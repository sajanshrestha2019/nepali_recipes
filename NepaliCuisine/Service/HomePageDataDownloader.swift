//
//  HomePageDataDownloader.swift
//  Nepali Recipes
//
//  Created by Sajan Shrestha on 2/2/21.
//

import Foundation

struct HomePageDataDownloader {
    
    static func getHomePageData(completion: @escaping (HomePageData) -> Void) {
        let url = URL(string: NepaliRecipeApi.homePageDataUrl)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let homePageData = try JSONDecoder().decode(HomePageData.self, from: data)
                completion(homePageData)
            }
            catch {
                print("error")
            }
        }.resume()
    }
}


struct HomePageData: Codable {
    var recipes: [Recipe]
    var popularRecipes: [Recipe]
    var categories: [RecipeCategory]
    
    enum CodingKeys: String, CodingKey {
        case recipes
        case popularRecipes = "popular_recipes"
        case categories
    }
}
