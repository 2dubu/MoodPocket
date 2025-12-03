//
//  ShadowStyle.swift
//  MoodPocket
//
//  Created by 이건우
//

import SwiftUI

struct MyShadowStyle: ViewModifier {
    var color: Color
    var radius: CGFloat
    var x: CGFloat
    var y: CGFloat
    
    func body(content: Content) -> some View {
        content
            .shadow(color: color, radius: radius, x: x, y: y)
    }
}

extension View {
    func myShadow(color: Color = .black, radius: CGFloat, x: CGFloat, y: CGFloat) -> some View {
        self.modifier(MyShadowStyle(color: color, radius: radius, x: x, y: y))
    }
    
    /// 있는 듯 없는 듯
    func myShadow1(radius: CGFloat = 20) -> some View {
        self.myShadow(color: Color.black.opacity(0.05), radius: radius, x: 0, y: 0)
    }
    
    func myShadow2() -> some View {
        self.myShadow(color: Color.black.opacity(0.15), radius: 11, x: 0, y: 0)
    }
}
