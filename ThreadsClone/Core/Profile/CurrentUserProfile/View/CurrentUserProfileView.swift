//
//  CurrentUserProfileView.swift
//  ThreadsClone
//
//  Created by YOON on 8/2/25.
//

import SwiftUI

// 메인화면에서 하단 탭바에 있는 프로필 탭을 클릭했을 때 나타나는 화면입니다.
struct CurrentUserProfileView: View {
    // CurrentUserProfileViewModel은 현재 사용자의 프로필 정보를 관리하는 뷰모델입니다.
    // showEditProfile은 프로필 편집 화면을 표시할지 여부를 나타내는 상태 변수입니다.
    @StateObject var viewModel = CurrentUserProfileViewModel()
    @State private var showEditProfile = false
    
    // viewModel에서 가져오는 User타입의 currentUser 프로퍼티 선언
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
                        // 현재 프로필 편집 화면을 토글합니다.
                        // 토글한다는것은 현재 상태를 반전시킨다는 의미입니다.
                        // .toggle() 메서드는 Bool 타입내장 메서드 이며 Bool 값을 반전시킵니다.
                        // showEditProfile이 true면 false로,
                        // false면 true로 변경됩니다.
                        // showEditProfile이 true면 편집 화면이 나타나고,
                        // false면 편집 화면이 사라집니다.
                        showEditProfile.toggle()
                    } label: {
                        // CurrentUserProfileView의 Edit Profile 버튼
                        // overlay는 뷰를 겹쳐서 표시하는 것
                        // RoundedRectangle은 둥근 사각형을 만드는 것
                        // stroke는 테두리를 만드는 것
                        // lineWidth는 테두리의 두께를 설정하는 것
                        Text("프로필 수정")
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
                    if let user = currentUser {
                        UserContentListView(user: user)
                    }
                }
                
            }
            .sheet(isPresented: $showEditProfile, content: {
                // .sheet는 모달 시트를 표시하는 데 사용됩니다.
                // isPresented는 모달 시트를 표시할지 여부를 결정하는 바인딩 변수입니다.
                // $showEditProfile은 showEditProfile 상태 변수를 바인딩합니다
                // content는 모달 시트의 내용을 정의합니다.
                // 여기서는 EditProfileView를 표시합니다.
                // showEditProfile이 true일 때 EditProfileView를 표시합니다.
                // .environmentObject는 뷰 모델을 환경 객체로 주입합니다.
                // viewModel은 CurrentUserProfileViewModel의 인스턴스입니다.
                if let user = currentUser {
                    EditProfileView(user: user)
                        .environmentObject(viewModel)
                }
            })
            .toolbar{
                // .toolbar는 내비게이션 바에 툴바를 추가하는 데 사용됩니다.
                // ToolbarItem은 툴바에 아이템을 추가하는 것입니다.
                // placement는 아이템이 툴바의 어느 위치에 배치될지를 정의합니다.
                // topBarTrailing은 툴바의 오른쪽 상단에 배치됩니다.
                // 우측 상단에 톱니바퀴모양의 설정 버튼을 추가
                ToolbarItem(placement: .topBarTrailing) {
                    //                    Button {
                    //                        AuthService.shared.signOut()
                    //                    } label: {
                    //                        // sign out image button
                    //                        Image(systemName: "gearshape")
                    //                    }
                    NavigationLink(destination: SettingListView()) {
                        Image(systemName: "gearshape")
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
