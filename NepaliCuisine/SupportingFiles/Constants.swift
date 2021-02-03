//
//  Constants.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 12/5/20.
//

import SwiftUI

struct RecipeApp {
    
    static let primaryColor: Color = Color(#colorLiteral(red: 0.3848459721, green: 0.6795548797, blue: 0.5393475294, alpha: 1))
    static let secondaryColor: Color = Color(#colorLiteral(red: 0.7399064898, green: 0.8146769404, blue: 0.7738978267, alpha: 1))
    static let focusedColor: Color = Color(#colorLiteral(red: 0.2237304151, green: 0.4777753353, blue: 0.3543518186, alpha: 1))

}

struct NepaliRecipeApi {
    static let homePageDataUrl = "http://localhost:3000/api/home"
    static let allRecipesUrl = "http://localhost:3000/api/recipes"
    static let popularRecipesUrl = "http://localhost:3000/api/popular_recipes"
    static func url(for categoryId: String) -> String {
        "http://localhost:3000/api/\(categoryId)/recipes"
    }
}
