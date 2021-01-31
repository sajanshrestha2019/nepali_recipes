//
//  NetworkImage.swift
//  Nepali Recipes
//
//  Created by Sajan Shrestha on 1/31/21.
//

import SwiftUI
import Combine

struct NetworkImage: View {
    
    @ObservedObject var model: NetworkImageModel
    
    init(url: String) {
        model = NetworkImageModel(url: url)
    }
    
    var body: some View {
        if model.image == nil {
            Spinner()
                .frame(width: 100, height: 100)
                .offset(y: 100)
        }
        else {
            Image(uiImage: model.image!)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}


class NetworkImageModel: ObservableObject {
    
    @Published var image: UIImage?
    var subscriber: AnyCancellable!
    
    init(url: String) {
        guard let url = URL(string: url) else { return }
        subscriber = ImageDownloader.getImage(for: url)
            .assign(to: \.image, on: self)
    }
    
}
