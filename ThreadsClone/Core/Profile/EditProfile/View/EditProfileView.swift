//
//  EditProfileView.swift
//  ThreadsClone
//
//  Created by YOON on 5/24/25.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    // User 객체 주입
    // bio, link 텍스트 필드의 상태를 관리하기 위한 @State 변수를 선언합니다.
    // Toggle의 상태를 관리하기 위한 @State 변수입니다.
    // @Environment(\.dismiss)은 현재 뷰를 닫는 기능을 제공합니다.
    // CurrentUserProfileViewModel로 현재사용정보를 업데이트하고
    // 프로필 사진을 선택하는 기능을 제공합니다.
    let user: User
    @State private var bio: String = ""
    @State private var link: String = ""
    @State private var isPrivateProfile: Bool = false
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel = EditProfileViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // .systemGroupedBackground는 시스템에서 제공하는 배경 색상으로, iOS의 그룹화된 배경을 나타냅니다.
                // 이 배경 색상은 일반적으로 설정 앱이나 그룹화된 리스트에서 사용됩니다.
                // .edgesIgnoringSafeArea([.bottom, .horizontal])는 배경 색상이 화면의 하단과 양쪽 가장자리까지 확장되도록 설정합니다.
                // 즉, Safe Area를 무시하고 배경 색상이 화면 전체에 적용됩니다.
                Color(.systemGroupedBackground)
                    .edgesIgnoringSafeArea([.bottom, .horizontal])
                // EditProfileView의 내용을 담고 있는 VStack입니다.
                VStack {
                    // name 과 프로필 사진을 나타내는 HStack입니다.
                    HStack {
                        VStack(alignment: .leading) {
                            Text("이름")
                                .fontWeight(.semibold)
                            
                            Text(user.fullname)
                        }
                        // Spacer()로 Vstack과 프로필 사진 사이에 빈 공간을 만듭니다.
                        Spacer()
                        
                        PhotosPicker(selection: $viewModel.selectedItem)  {
                            // PhotosPicker는 사용자가 사진을 선택할 수 있는 UI 요소입니다.
                            // selection은 사용자가 선택한 사진을 저장하는 바인딩 변수입니다.
                            // if let optional binding을 사용하여 선택된 이미지가 있을 때만 이미지를 표시합니다.
                            // viewModel.profileImage는 선택된 이미지가 있는 경우에만 표시됩니다.
                            // resizable()는 이미지를 크기에 맞게 조정합니다.
                            // scaledToFill()은 이미지를 비율에 맞게 채웁니다.
                            // frame은 이미지의 크기를 지정합니다.
                            // clipShape(Circle())는 이미지를 원형으로 자릅니다.
                            if let image = viewModel.profileImage{
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            }else{
                                // CircularProfileImageView는 원형 프로필 이미지를 표시하는 뷰입니다.
                                CircularProfileImageView(user: user)
                                
                            }
                            
                        }
                        
                    }
                    
                    // bio 인물 소개를 나타내는 vstack입니다.
                    Divider()
                    VStack(alignment: .leading) {
                        Text("자기소개")
                            .fontWeight(.semibold)
                        
                        // TextField는 사용자로부터 텍스트 입력을 받는 UI 요소입니다.
                        // axis: .vertical로 인해 여러 줄 입력이 가능하고 텍스트가 자동으로 줄바꿈됩니다.
                        // text는 @State로 선언된 bio 변수를 바인딩합니다.
                        // 즉, 사용자가 입력한 텍스트가 bio 변수에 저장됩니다.
                        TextField(
                            "자신을 소개해 보세요",
                            text: $bio,
                            axis: .vertical
                        )
                    }
                    
                    // Link를 입력할수있는 VStack 시작
                    Divider()
                    VStack(alignment: .leading) {
                        Text("링크")
                            .fontWeight(.semibold)
                        
                        // TextField는 사용자로부터 텍스트 입력을 받는 UI 요소입니다.
                        // axis: .vertical로 인해 여러 줄 입력이 가능하고 텍스트가 자동으로 줄바꿈됩니다.
                        // text는 @State로 선언된 bio 변수를 바인딩합니다.
                        // 즉, 사용자가 입력한 텍스트가 bio 변수에 저장됩니다.
                        TextField(
                            "링크 주소",
                            text: $link
                        )
                    }
                    
                    // Toggle이 위치하는 부분
                    Divider()
                    // Toggle은 스위치 형태의 UI 요소로, 사용자가 켜고 끌 수 있는 기능을 제공합니다.
                    // isOn은 Toggle의 상태를 나타내는 @State 변수입니다.
//                    Toggle("Private profile", isOn: $isPrivateProfile)
                    
                }
                // Vstack전체에 적용하는 modifier
                // 첫번째 paading은 Vstack의 내부 콘텐트와 흰색배경사이의 여백을 주어서 테두리와 여백을 주는 것
                // .overlay는 뷰를 겹쳐서 표시하는 것
                // RoundedRectangle은 둥근 사각형을 만드는 것
                // stroke는 테두리를 만드는 것
                // lineWidth는 테두리의 두께를 설정하는 것
                .font(.footnote)
                .padding()
                .background(.white)
                .cornerRadius(10)
                .overlay {
                    // RoundedRectangle은 둥근 사각형을 만드는 것
                    // stroke는 테두리를 만드는 것
                    // lineWidth는 테두리의 두께를 설정하는 것
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }
                // 두번째 padding은 전체 카드형 UI(테두리가 있는 흰색 배경)와 화면 가장자리 사이의 여백을 만듦
                .padding()
            }
            // .navigationTitle은 내비게이션 바의 제목을 설정합니다.
            // "Edit Profile"이라는 문자열이 내비게이션 바의 제목으로 표시됩니다.
            // .navigationBarTitleDisplayMode(.inline)은 내비게이션 바의 제목 표시 모드를 설정합니다.
            .navigationTitle("프로필 수정")
            .navigationBarTitleDisplayMode(.inline)
            // 상단 네비게이션바에 .toolbar로 Cancel과 Done 버튼을 추가합니다.
            .toolbar {
                // ToolbarItem은 내비게이션 바에 추가할 항목을 정의합니다.
                // placement는 항목이 내비게이션 바의 어느 위치에 배치될지를 정의합니다.
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소") {
                        // 취소 버튼을 눌렀을 때의 동작을 여기에 추가합니다.
                        // Property로 선언된 dismiss를 호출하여 현재 뷰를 닫습니다.
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundColor(.black)
                }
                // 2번째 ToolbarItem은 내비게이션 바의 오른쪽에 추가됩니다.
                // 이 버튼은 "Done"이라는 텍스트를 가지고 있으며, 눌렀을 때의 동작을 정의합니다.
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("완료") {
                        // 취소 버튼을 눌렀을 때의 동작을 여기에 추가합니다.
                        // 프로필 정보를 업데이트한 후 현재 뷰를 닫습니다.
                        Task{
                            try await viewModel.updateUserData()
                            dismiss()
                        }
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                }
            }
        }
    }
}

// PreviewProvider는 SwiftUI에서 미리보기를 제공하는 구조체입니다.
// EditProfileView의 미리보기를 제공합니다.
struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        // EditProfileView를 미리보기로 설정합니다.
        // User 객체를 dev.user로 초기화하여 미리보기에서 사용할 수 있도록 합니다.
        EditProfileView(user: dev.user)
    }
}


//#Preview {
//    EditProfileView()
//}
