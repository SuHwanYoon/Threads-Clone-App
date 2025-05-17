//
//  CircularProfileImageView.swift
//  ThreadsClone
//
//  Created by YOON on 5/17/25.
//

import SwiftUI

// 이 이미지의 뷰는 프로필 이미지를 원형으로 표시하는 뷰입니다.
struct CircularProfileImageView: View {
    var body: some View {
        Image("yoon-profile")
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
}

#Preview {
    CircularProfileImageView()
}
