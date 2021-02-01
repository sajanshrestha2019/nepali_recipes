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
                .frame(width: 60, height: 60)
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
