//
//  CloseIcon.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 12/29/20.
//

import SwiftUI

struct CloseIcon: View {
    var iconTapped: () -> ()
    var body: some View {
        Image(systemName: "xmark.circle.fill")
            .foregroundColor(RecipeApp.primaryColor)
            .onTapGesture {
                iconTapped()
            }
    }
}

struct CloseIcon_Previews: PreviewProvider {
    static var previews: some View {
        CloseIcon {
            print("close button tapped")
        }
    }
}
