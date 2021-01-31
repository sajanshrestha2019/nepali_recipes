//
//  RecipePlayer.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 1/1/21.
//

import Foundation


class RecipePlayer: ObservableObject {
    
    var recipe: Recipe
    
    var currentInstructionIndex = 0
    
    @Published var currentStepNumber = ""
    @Published var currentInstruction = ""
    @Published var currentMediaType = MediaType.none
    @Published var currentMediaUrl = ""
    
    var isOnLastInstruction = false
    var isOnFirstInstruction = true
    
    init(recipe: Recipe) {
        self.recipe = recipe
        guard !recipe.instructions.isEmpty else { return }
        let instruction = recipe.instructions[currentInstructionIndex]
        currentStepNumber = "Step 1"
        currentInstruction = instruction.text
        currentMediaType = instruction.mediaType
        currentMediaUrl = instruction.mediaType == MediaType.photo ? instruction.imageUrl! : instruction.videoUrl ?? ""
    }
    
    func nextInstruction() {
        
        isOnFirstInstruction = false
        
        if currentInstructionIndex < recipe.instructions.count - 1 {
            currentInstructionIndex += 1
        }
        if currentInstructionIndex == recipe.instructions.count - 1{
            isOnLastInstruction = true
        }
        
        updateModel()
    }
    
    func previousInstruction() {
        isOnLastInstruction = false

        if currentInstructionIndex > 0 {
            currentInstructionIndex -= 1
        }
        if currentInstructionIndex == 0 {
            isOnFirstInstruction = true
        }
        
        updateModel()
    }
    
    private func updateModel() {
        let instruction = recipe.instructions[currentInstructionIndex]
        currentStepNumber = "Step \(currentInstructionIndex + 1)"
        currentInstruction = instruction.text
        currentMediaType = instruction.mediaType
        currentMediaUrl = instruction.mediaType == MediaType.photo ? instruction.imageUrl! : instruction.videoUrl ?? ""
    }
}
