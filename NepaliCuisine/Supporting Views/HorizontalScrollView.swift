//
//  HorizontalScrollView.swift
//  Nepali Recipes
//
//  Created by Sajan Shrestha on 2/9/21.
//

import SwiftUI

struct HorizontalScrollView<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var view: (Item) -> ItemView
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(items) { item in
                    view(item)
                }
            }
        }
    }
}
