//
//  Recipe.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 12/3/20.
//

import Foundation
import Combine


struct Recipe: Codable, Identifiable {
    let id: Int
    let name: String
    let duration: Int
    let ingredients: [String]
    let instructions: [Instruction]
    let imageUrl: String
    let color: String
    let serveSize: Int
    let level: String
    let type: [String]
    var isPopular: Bool
    
    var indgredientsDescription: String {
        ingredients.joined(separator: ", ")
    }
    
}

struct Instruction: Codable {
    let id: Int
    let text: String
    let videoUrl: String?
    let imageUrl: String?
    var mediaType: MediaType {
        if let videoUrl = videoUrl, !videoUrl.isEmpty {
            return .video
        }
        else if let imageUrl = imageUrl, !imageUrl.isEmpty {
            return .photo
        }
        else {
            return .none
        }
    }
}

enum MediaType: String, Codable {
    case photo, video, none
}

extension Recipe {
    static var testRecipe: Recipe {
        Recipe(id: 1, name: "Momo", duration: 35, ingredients: ["1 Onion", "2 Tomatoes", "1 Wrapper"], instructions: [
            Instruction(id: 1, text: "Instruction 1", videoUrl: "", imageUrl: "")
        ], imageUrl: "", color: "#db9bae", serveSize: 2, level: "Easy", type: [], isPopular: true)
    }
}


