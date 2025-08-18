//
//  TextFiledModifier.swift
//  ThreadsClone
//
//  Created by YOON on 5/5/25.
//

import SwiftUI

struct TextFiledModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.theme.secondaryText, lineWidth: 1)
            )
            .padding(.horizontal, 24)
    }

}