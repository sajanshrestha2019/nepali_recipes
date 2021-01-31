//
//  RecipePlayerView.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 12/9/20.
//

import SwiftUI

struct RecipePlayerView: View {
    
    @ObservedObject var recipePlayer: RecipePlayer
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    Text(recipePlayer.currentStepNumber)
                        .titled()
                        .padding()
                    Spacer()
                    CloseIcon { presentationMode.wrappedValue.dismiss() }
                }
                Spacer()
                ScrollView([.vertical], showsIndicators: false) {
                    Text(recipePlayer.currentInstruction)
                        .subheadline()
                        .padding()
                    if recipePlayer.currentMediaType == .photo {
                        NetworkImage(url: recipePlayer.currentMediaUrl)
                            .cornerRadius(8)
                    }
                    else if recipePlayer.currentMediaType == .video {
                        VideoPlayerView(url: recipePlayer.currentMediaUrl)
                            .frame(width: UIScreen.main.bounds.width, height: 300)
                            .offset(x: 0, y: 60)
                    }
                }
                .frame(height: UIScreen.main.bounds.height * 0.7)


                Spacer()
                HStack {
                    
                    IconButton(title: "Previous", icon: "arrowtriangle.backward.fill", color: recipePlayer.isOnFirstInstruction ? Color.gray : RecipeApp.primaryColor) {
                        recipePlayer.previousInstruction()
                    }
                    .disabled(recipePlayer.isOnFirstInstruction)
                    
                    IconButton(title: "Next", icon: "arrowtriangle.forward.fill", color: recipePlayer.isOnLastInstruction ? Color.gray : RecipeApp.primaryColor, leadingIcon: false) {
                        recipePlayer.nextInstruction()
                    }
                    .disabled(recipePlayer.isOnLastInstruction)
                }
                
                Spacer()
            }.padding(.horizontal)
            
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct RecipePlayerView_Previews: PreviewProvider {
    static var previews: some View {
        RecipePlayerView(recipePlayer: RecipePlayer(recipe: Recipe.testRecipe))
    }
}
