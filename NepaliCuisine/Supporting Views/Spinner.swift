//
//  Spinner.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 12/6/20.
//

import SwiftUI

struct Spinner: View {
    
    @State private var rotate = false
    
    var body: some View {
        Image(systemName: "sun.min")
            .resizable()
            .frame(width: 80, height: 80)
            .rotationEffect(rotate ? .degrees(180) : .zero)
            .foregroundColor(RecipeApp.primaryColor)
            .animation(Animation.easeIn(duration: 1).repeatForever(autoreverses: false))
            .onAppear {
                rotate = true
            }
    }
}

struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        Spinner()
    }
}
