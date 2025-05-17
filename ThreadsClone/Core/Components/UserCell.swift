//
//  UserCell.swift
//  ThreadsClone
//
//  Created by YOON on 5/17/25.
//

import SwiftUI

// 이 뷰는 사용자 셀을 나타내는 뷰이며 프로필사진 뷰를 포함하고 있습니다.
struct UserCell: View {
    var body: some View {
        HStack {
            // 프로필 사진
            CircularProfileImageView()

            VStack(alignment: .leading) {
                Text("Yoon")
                    .fontWeight(.semibold)

                Text("Yoon Suhwan")

            }
            .font(.footnote)
            // HStack의 요소들 사이에서 빈공간을 줌
            // 위에있는 Vstack은 alignment이 leading이므로 왼쪽 정렬
            Spacer()

            // follow 버튼
            // overlay는 뷰를 겹쳐서 표시하는 것
            // RoundedRectangle은 둥근 사각형을 만드는 것
            // stroke는 테두리를 만드는 것
            // lineWidth는 테두리의 두께를 설정하는 것
            Text("Follow")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 100, height: 32)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }

        }
        .padding(.horizontal)
    }
}

#Preview {
    UserCell()
}
