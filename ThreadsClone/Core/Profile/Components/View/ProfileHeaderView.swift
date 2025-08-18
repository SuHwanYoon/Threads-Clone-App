//
//  ProfileHeaderView.swift
//  ThreadsClone
//
//  Created by YOON on 8/3/25.
//

import SwiftUI

// ProfileHeaderView는 프로필 헤더를 표시하는 뷰입니다.
// 이 뷰는 사용자의 프로필 이미지, 이름, 사용자 이름, 바이오 및 팔로워 수를 표시합니다.
// ProfileHeaderView는 HStack을 사용하여 프로필 이미지와 사용자 정보를 나란히 표시합니다.
// 프로필 이미지는 CircularProfileImageView를 사용하여 원형으로 표시됩니다.
// 이 뷰는 User 객체를 주입받아 사용자 정보를 표시합니다.
// ProfileView, CurrentUserProfileView 에서 사용됩니다.
struct ProfileHeaderView: View {
    // User 객체 injection
    // injection을 optional로 선언하여
    // User 객체가 nil일 수도 있음을 나타냅니다.
    let user: User?
    
    // User 객체를 주입받는 초기화 메서드
    // 이 메서드는 user 프로퍼티를 초기화하는 역할을 합니다.
    // 이 메서드는 User 객체를 받아서 user 프로퍼티에 할당합니다
    init(user: User?) {
        self.user = user
    }
    
    var body: some View {
        // Vstack + Text + Text를 포함하는 HStack
        // 왼쪽 요소들은.top 이 있어도 없어도 위치변화 없음
        // CircularProfileImageView는 높이가 1줄로 구성되어 있어 .top으로 인해 위로 올라감
        HStack(alignment: .top) {
            // .leading은 왼쪽 정렬을 의미합니다.
            // [프로필, 아이디] , 직업, 팔로워 수를 포함하는 VStack
            // Profile name과 나머지 요소 사이의 간격을 12로 설정합니다.
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(user?.fullname ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.theme.primaryText)
                    
                    Text(user?.username ?? "")
                        .font(.subheadline)
                        .foregroundColor(Color.theme.secondaryText)
                }
                
                if let bio = user?.bio, !bio.isEmpty {
                    Text(bio)
                        .font(.footnote)
                        .foregroundColor(Color.theme.primaryText)
                }
                
//                Text("2 followers")
//                    .font(.caption)
//                    .foregroundColor(Color.theme.secondaryText)
            }
            
            // Spacer()는 빈 공간을 채우는 것
            // Spacer()로 인해 HStack의 요소들 사이에 빈 공간이 생김
            Spacer()
            
            CircularProfileImageView(user: user, size: .medium)
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(user: dev.user)
    }
}
