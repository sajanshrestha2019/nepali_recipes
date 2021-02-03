//
//  NepaliCuisineApp.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 11/30/20.
//

import SwiftUI

@main
struct NepaliRecipesApp: App {
    let homePageModel = HomePageModel()
    var body: some Scene {
        WindowGroup {
            HomePageView(homePageModel: homePageModel)
        }
    }
}
