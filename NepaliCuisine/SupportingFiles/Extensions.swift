//
//  Extensions.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 12/4/20.
//

import UIKit
import SwiftUI

extension UIColor {

    // MARK: - Initialization

    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt32 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, alpha: a)
    }

    // MARK: - Computed Properties

    var toHex: String? {
        return toHex()
    }

    // MARK: - From UIColor to String

    func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }

        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)

        if components.count >= 4 {
            a = Float(components[3])
        }

        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }

}


struct Title: ViewModifier {
    var fontSize: CGFloat
    func body(content: Content) -> some View {
        content
            .font(Font.custom("YanoneKaffeesatz-Medium", size: fontSize))

    }
}

struct Heading: ViewModifier {
    var fontSize: CGFloat
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Montserrat-Bold", size: fontSize))
    }
}

struct Subheading: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Raleway-Regular", size: 18))
    }
}


extension Text {
    func titled(fontSize: CGFloat = 30) -> some View {
        self.modifier(Title(fontSize: fontSize))
    }
    
    func headline(fontSize: CGFloat = 20) -> some View {
        self.modifier(Heading(fontSize: fontSize))
    }
    
    func subheadline() -> some View {
        self.modifier(Subheading())
    }
}
