//
//  IconButton.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 12/9/20.
//

import SwiftUI

struct IconButton: View {
    var title: String
    var icon: String
    var color: Color
    var leadingIcon = true
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            HStack {
                if leadingIcon {
                    Image(systemName: icon)
                    Text(title)
                }
                else {
                    Text(title)
                    Image(systemName: icon)
                }
            }
            .padding(EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10))
            .background(color)
            .cornerRadius(10)
            .foregroundColor(.white)
        })
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(title: "", icon: "",color: Color.red) {
            print("")
        }
    }
}
