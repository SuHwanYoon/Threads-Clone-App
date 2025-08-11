//
//  ProfileView.swift
//  ThreadsClone
//
//  Created by YOON on 5/7/25.
//

import SwiftUI

// 이 ProfileView는 사용자의 프로필을 표시하는 뷰인데
// 사용자 정보를 외부에서 주입받아 표시하고
// 현재 ExploreView에서 UserCell을 클릭했을 때
// ProfileView로 이동하고 해당 사용자의 프로필을 표시하는 역할을 합니다
struct ProfileView: View {
    // @StateObject는 뷰 모델을 상태 객체로 선언합니다.
    //    @StateObject var viewModel = ProfileViewModel()
    
    // 외부에서 User를 주입받겠다는 선언
    // ProfileView를 만들때는 User객체를 외부에서 전달받아야함
    // ProfileView내부에서는 user를 직접 생성하거나 fetch하지않고
    // 외부에서 profileView를 사용할때는 반드시 user를 주입해야함
    let user: User
    
    
    // viewModel에서 가져오는 currentUser 프로퍼티
    //    private var currentUser: User? {
    //        // 현재 로그인된 사용자의 정보를 가져옵니다.
    //        return viewModel.currentUser
    //    }
    
    var body: some View {
        
        // showsIndicators: false는 스크롤바를 숨깁니다.
        // showsIndicators: true는 스크롤바를 표시합니다.
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                // Components로 분리된 프로필 헤더 뷰
                ProfileHeaderView(user: user)
                // follow 버튼
                Button {
                    // 버튼 클릭 시 동작
                } label: {
                    Text("Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 352, height: 32)
                        .background(.black)
                        .cornerRadius(8)
                }
                
                // UserContentListView는 해당 유저의 thread를 표시하는 뷰입니다.
                // Components로 분리된 UserContentListView를 사용합니다.
                UserContentListView(user: user)
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
        // ProfileView는 사용자의 프로필을 표시하는 뷰이므로
        // navigationBarTitleDisplayMode를 inline으로 설정하여
        // 프로필 이름을 네비게이션 바에 표시합니다.
        // showsIndicators속성의 기본값은 true입니다.
        // .padding(.horizontal)은 좌우 여백을 주는 것
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: dev.user)
    }
}

//
//#Preview {
//    ProfileView(user: User)
//}
