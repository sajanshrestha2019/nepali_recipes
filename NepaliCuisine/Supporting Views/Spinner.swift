//
//  Spinner.swift
//  SwiftUIAnimations
//
//  Created by Sajan Shrestha on 1/18/21.
//

import SwiftUI

struct Spinner: View {
    @State private var rotating = false
    var body: some View {
        Circle()
            .trim(from: 0.1, to: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            .stroke(lineWidth: 2.0)
            .padding()
            .foregroundColor(Color(#colorLiteral(red: 0.3848459721, green: 0.6795548797, blue: 0.5393475294, alpha: 1)))
            .rotationEffect(rotating ? .degrees(360) : .zero)
            .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: false))
            .onAppear {
                rotating = true
            }
    }
}

struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        Spinner().frame(width: 100, height: 100)
    }
}
