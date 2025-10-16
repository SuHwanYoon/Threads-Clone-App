import SwiftUI
import PhotosUI

struct EditProfileView: View {
    let user: User
    @State private var link: String = ""
    @State private var uploadError: Error?
    @State private var showErrorAlert = false
    @State private var isLoading = false
    @State private var isPrivateProfile: Bool = false
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: EditProfileViewModel
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        ZStack {
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
                            
                            PhotosPicker(selection: $viewModel.selectedItem, matching: .images) {
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
                            dismiss()
                        }
                        .font(.subheadline)
                        .foregroundColor(Color.theme.primaryText)
                    .disabled(isLoading) // 로딩 중 비활성화
                    }
                    // 2번째 ToolbarItem은 내비게이션 바의 오른쪽에 추가됩니다.
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("완료") {
                            Task {
                                isLoading = true
                                do {
                                    try await viewModel.updateUserData()
                                    isLoading = false
                                    dismiss()
                                } catch {
                                    isLoading = false
                                    uploadError = error
                                    showErrorAlert = true
                                }
                            }
                        }
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.theme.accent)
                        .disabled(isLoading) // 로딩 중 비활성화
                    }
                }
                .alert("업로드 실패", isPresented: $showErrorAlert) {
                    Button("확인") { }
                } message: {
                    Text(uploadError?.localizedDescription ?? "프로필 업데이트 중 오류가 발생했습니다. 다시 시도해주세요.")
                }
            }
            
            if isLoading {
                Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
            }
        }
    }
}


// PreviewProvider는 SwiftUI에서 미리보기를 제공하는 구조체입니다.
// EditProfileView의 미리보기를 제공합니다.
// PreviewProvider removed to avoid preview-only dependencies (e.g. `dev.user`) causing compile errors
// If you need previews, re-add a PreviewProvider that constructs a valid `User` instance available in your project.
