//
//  RecipeDetailView.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 12/4/20.
//

import SwiftUI


struct RecipeDetailView: View {
    
    var recipe: Recipe
    
    @State private var copyStatus: RecipeCopyStatus = .none
    @State private var mediaUrl = ""
    @State private var mediaType = MediaType.none
    @State private var presentedSheet: PresentedSheet? = nil
    
    init(for recipe: Recipe) {
        self.recipe = recipe
    }
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack(spacing: verticalSpacing) {
                
                ZStack {
                    Color(#colorLiteral(red: 0.297303915, green: 0.2494146526, blue: 0.2370918989, alpha: 1))
                    Image(uiImage: UIImage(data: recipe.imageData ?? Data())!)
                        .resizable()
                        .frame(width: 240, height: 320)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .shadow(radius: imageShadow)
                }
                
                VStack(alignment: .leading, spacing: verticalSpacing) {
                    HStack {
                        Text(recipe.name)
                            .titled()
                        Spacer()
                        IconButton(title: "Start", icon: "livephoto.play", color: RecipeApp.primaryColor) {
                            presentedSheet = .recipePlayerView
                        }
                    }
                    
                    HStack {
                        InfoCard(iconName: "stopwatch", title: "\(recipe.duration) mins", color: Color(#colorLiteral(red: 0.9624301791, green: 0.7577118278, blue: 0.6909566522, alpha: 1)))
                        InfoCard(iconName: "figure.wave", title: "\(recipe.serveSize) servings", color: Color(#colorLiteral(red: 0.8231000304, green: 0.8292592168, blue: 0.9767168164, alpha: 1)))
                        InfoCard(iconName: "face.smiling", title: recipe.level, color: Color(#colorLiteral(red: 0.9609945416, green: 0.8835995197, blue: 0.8848980069, alpha: 1)))
                        
                    }
                    .frame(height: UIScreen.main.bounds.width * 0.3)
                    
                    HStack {
                        Text("Ingredients")
                            .headline()
                        Spacer()
                        
                        CopyButton(action: copyIngredientsToClipBoard, copied: copyStatus == .ingredientsCopied)
                        
                    }.padding(.top)
                    
                    IngredientsList(for: recipe.ingredients)
                    
                    HStack {
                        Text("Steps")
                            .headline()
                            .padding(.top)
                        
                        Spacer()
                        
                        CopyButton(action: copyStepsToClipBoard, copied: copyStatus == .stepsCopied)
                    }
                    
                    InstructionsList(for: recipe.instructions) { mediaType, url in
                        self.mediaType = mediaType
                        self.mediaUrl = url
                        presentedSheet = .instructionMediaView
                    }
                    
                }.padding()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .sheet(item: $presentedSheet) { item in
            sheet(for: item)
        }
        
    }
    
    private func sheet(for item: PresentedSheet) -> some View {
        Group {
            switch item {
            case .recipePlayerView:
                RecipePlayerView(recipePlayer: RecipePlayer(recipe: recipe))
            case .instructionMediaView:
                InstructionMediaView(url: $mediaUrl, mediaType: $mediaType)
            }
        }
    }
    
    // MARK: - Constants
    private let verticalSpacing: CGFloat = 20
    private let imageSize: (width: CGFloat, height: CGFloat) = (230, 230)
    private let imageShadow: CGFloat = 8
}


extension RecipeDetailView {
    
    private func copyIngredientsToClipBoard() {
        copyToPasteBoard(recipe.ingredients.joined(separator: "\n"))
        copyStatus = .ingredientsCopied
    }
    
    private func copyStepsToClipBoard() {
        copyToPasteBoard(recipe.instructions.map { $0.text }.joined(separator: "\n"))
        copyStatus = .stepsCopied
    }
    
    private func copyToPasteBoard(_ string: String) {
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = string
    }
    
    enum RecipeCopyStatus {
        case none
        case ingredientsCopied
        case stepsCopied
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(for: Recipe.testRecipe)
    }
}

struct IngredientsList: View {
    
    var ingredients: [String]
    
    init(for ingredients: [String]) {
        self.ingredients = ingredients
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<ingredients.count, id: \.self) { index in
                HStack(alignment: .top) {
                    Image(systemName: "chevron.right")
                        .imageScale(.small)
                        .foregroundColor(RecipeApp.primaryColor)
                    Text(ingredients[index])
                        .subheadline()
                        
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))
            }
        }
    }
}

struct InstructionsList: View {
    
    var instructions: [Instruction]
    var instructionMediaButtonTapped: ((MediaType, String) -> Void)
    
    init(for instructions: [Instruction], instructionMediaButtonTapped: @escaping (MediaType, String) -> Void) {
        self.instructions = instructions
        self.instructionMediaButtonTapped = instructionMediaButtonTapped
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<instructions.count, id: \.self) { index in
               viewForInstruction(atIndex: index)
            }
        }
    }
    
    private func viewForInstruction(atIndex index: Int) -> some View {
        let instruction = instructions[index]
        return VStack(alignment: .leading) {
            HStack {
                Image(systemName: "0\(index + 1).circle.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(RecipeApp.primaryColor)
                if instruction.mediaType != .none {
                    Divider()
                        .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                        
                }
                Button(action: {
                    instructionMediaButtonTapped(instruction.mediaType, instruction.mediaType == .video ? instruction.videoUrl! : instruction.imageUrl!)
                }, label: {
                    let media = instruction.mediaType
                    if media == .photo || media == .video {
                        Image(systemName: media.rawValue)
                            .foregroundColor(RecipeApp.primaryColor)
                    }
                })
            }
            
            Text(instruction.text)
                .subheadline()
                .fixedSize(horizontal: false, vertical: true)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
        }
        .padding(.bottom)
    }
}




struct InfoCard: View {
    var iconName: String
    var title: String
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(color)
                VStack {
                    Image(systemName: iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width/2, height: geometry.size.width/2)
                    Text(title)
                        .font(Font.custom("Raleway-Regular", size: geometry.size.width * 0.15))
                }
            }
        }
    }
}

struct InfoCard_Previews: PreviewProvider {
    static var previews: some View {
        InfoCard(iconName: "flame", title: "540 Calories", color: Color.yellow)
    }
}


struct CopyButton: View {
    
    var action: () -> Void
    var copied: Bool
    
    var body: some View {
        
        Button(action: action, label: {
            if copied {
                Text("Copied").font(.subheadline)
            }
            else {
                Image(systemName: "square.and.arrow.up").imageScale(.medium)
            }
        })
        .disabled(copied)
    }
}

enum PresentedSheet: Int, Identifiable {
    
    var id: Int {
        self.rawValue
    }
    
    case recipePlayerView
    case instructionMediaView
}
