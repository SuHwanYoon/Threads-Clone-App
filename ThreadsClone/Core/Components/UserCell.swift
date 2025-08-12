//
//  UserCell.swift
//  ThreadsClone
//
//  Created by YOON on 5/17/25.
//

import SwiftUI

// 이 뷰는 사용자 셀을 나타내는 뷰이며 프로필사진 뷰를 포함하고 있습니다.
struct UserCell: View {
    // UserCell은 User 객체를 사용하여 사용자 정보를 표시합니다.
    // user property는 User 타입으로 선언되어 있으며,
    // init을 명시하지않아도 SwiftUI가 자동으로 생성합니다.
    // 따라서 UserCell을 생성할 때 User 객체를 반드시 전달해야 합니다.
    let user: User
    
    var body: some View {
        HStack {
            // 프로필 사진
            CircularProfileImageView(user: user)
                

            VStack(alignment: .leading, spacing: 2) {
                Text(user.username)
                    .fontWeight(.semibold)

                Text(user.fullname)

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
                .hidden()

        }
        .padding(.horizontal)
    }
}


struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell(user: dev.user)
    }
}



//
//#Preview {
//    UserCell(user: dev.user)
//}
