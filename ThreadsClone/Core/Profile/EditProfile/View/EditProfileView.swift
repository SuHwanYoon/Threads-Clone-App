import SwiftUI
import PhotosUI

struct EditProfileView: View {
    let user: User
    @State private var link: String = ""
    @State private var isPrivateProfile: Bool = false
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: EditProfileViewModel
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.background
                    .edgesIgnoringSafeArea([.bottom, .horizontal])
                
                VStack(alignment: .leading, spacing: 12) {
                    // Name and Profile Picture
                    HStack {
                        VStack(alignment: .leading) {
                            Text("이름")
                                .fontWeight(.semibold)
                            
                            Text(user.fullname)
                                .foregroundColor(Color.theme.secondaryText)
                        }
                        // Spacer()로 Vstack과 프로필 사진 사이에 빈 공간을 만듭니다.
                        Spacer()
                        
                        PhotosPicker(selection: $viewModel.selectedItem)  {
                            if let image = viewModel.profileImage {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            } else {
                                CircularProfileImageView(user: user, size: .small)
                            }
                        }
                    }
                    
                    Divider()
                    
                    // Bio
                    VStack(alignment: .leading) {
                        Text("나를 표현하는 단어")
                            .fontWeight(.semibold)
                        
                        // TextField는 사용자로부터 텍스트 입력을 받는 UI 요소입니다.
                        // axis: .vertical로 인해 여러 줄 입력이 가능하고 텍스트가 자동으로 줄바꿈됩니다.
                        // text는 viewModel의 bio 프로퍼티와 바인딩됩니다.
                        TextField(
                            "예: 취미, 특기, 기분 등등",
                            text: $viewModel.bio,
                            axis: .vertical
                        )
                    }
                }
                .font(.footnote)
                .foregroundColor(Color.theme.primaryText)
                .padding()
                .background(Color.theme.background)
                .cornerRadius(10)
                .overlay {
                    // RoundedRectangle은 둥근 사각형을 만드는 것
                    // stroke는 테두리를 만드는 것
                    // lineWidth는 테두리의 두께를 설정하는 것
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.theme.secondaryText.opacity(0.5), lineWidth: 1)
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
                    .foregroundColor(Color.theme.primaryText)
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
                    .foregroundColor(Color.theme.accent)
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