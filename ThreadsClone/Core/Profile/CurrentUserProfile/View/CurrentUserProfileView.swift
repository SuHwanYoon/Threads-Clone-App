//
//  CurrentUserProfileView.swift
//  ThreadsClone
//
//  Created by YOON on 8/2/25.
//

import SwiftUI

// 메인화면에서 하단 탭바에 있는 프로필 탭을 클릭했을 때 나타나는 화면입니다.
struct CurrentUserProfileView: View {
    @StateObject var viewModel = CurrentUserProfileViewModel()
    
    // viewModel에서 가져오는 currentUser 프로퍼티
    private var currentUser: User? {
        // 현재 로그인된 사용자의 정보를 가져옵니다.
        return viewModel.currentUser
    }
    var body: some View {
        NavigationStack{
            // showsIndicators: false는 스크롤바를 숨깁니다.
            // showsIndicators: true는 스크롤바를 표시합니다.
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    // Components로 분리된 프로필 헤더 뷰
                    ProfileHeaderView(user: currentUser)
                    // follow 버튼
                    Button {
                        // 버튼 클릭 시 동작
                    } label: {
                        // CurrentUserProfileView의 Edit Profile 버튼
                        // overlay는 뷰를 겹쳐서 표시하는 것
                        // RoundedRectangle은 둥근 사각형을 만드는 것
                        // stroke는 테두리를 만드는 것
                        // lineWidth는 테두리의 두께를 설정하는 것
                        Text("Edit Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .frame(width: 352, height: 32)
                            .background(.white)
                            .cornerRadius(8)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            }
                    }
                    // UserContentListView는 사용자 콘텐츠 목록을 표시하는 뷰입니다.
                    // Components로 분리된 UserContentListView를 사용합니다.
                    UserContentListView()
                }
                
            }
            .toolbar{
                // ToolbarItem은 툴바에 아이템을 추가하는 것입니다.
                // placement는 아이템이 툴바의 어느 위치에 배치될지를 정의합니다.
                // topBarTrailing은 툴바의 오른쪽 상단에 배치됩니다.
                // 우측 상단에 로그아웃되는 메뉴 버튼을 추가합니다.
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        // sign out image button
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                    }
                }
            }
            // showsIndicators속성의 기본값은 true입니다.
            // .padding(.horizontal)은 좌우 여백을 주는 것
            .padding(.horizontal)
            
        }
    }
}

#Preview {
    CurrentUserProfileView()
}
