//
//  InstructionMediaView.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 12/9/20.
//

import SwiftUI
import AVKit

struct InstructionMediaView: View {
    
    @Binding var url: String
    @Binding var mediaType: MediaType
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                CloseIcon {
                    presentationMode.wrappedValue.dismiss()
                }
            }.padding()
            Spacer()
            if mediaType == .photo {
                NetworkImage(url: url)
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
            }
            else {
                VideoPlayerView(url: url)
            }
            Spacer()
        }
    }
}

struct InstructionMediaView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionMediaView(url: .constant("some string"), mediaType: .constant(.none))
    }
}
