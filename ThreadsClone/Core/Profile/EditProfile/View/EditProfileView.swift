import SwiftUI
import PhotosUI
struct EditProfileView: View {
    let user: User
    @State private var link: String = ""
    @State private var isPrivateProfile: Bool = false
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: EditProfileViewModel
    @State private var showErrorAlert = false
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .edgesIgnoringSafeArea([.bottom, .horizontal])
                
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("이름")
                                .fontWeight(.semibold)
                            
                            Text(user.fullname)
                        }
                        
                        Spacer()
                        
                        PhotosPicker(selection: $viewModel.selectedItem)  {
                            if let image = viewModel.profileImage{
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            } else {
                                CircularProfileImageView(user: user)
                            }
                        }
                    }
                    
                    Divider()
                    VStack(alignment: .leading) {
                        Text("나를 표현하는 단어")
                            .fontWeight(.semibold)
                        
                        TextField(
                            "예: 취미, 특기, 기분 등등",
                            text: $viewModel.bio,
                            axis: .vertical
                        )
                    }
                }
                .font(.footnote)
                .padding()
                .background(.white)
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }
                .padding()
            }
            .navigationTitle("프로필 수정")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소") {
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundColor(.black)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("완료") {
                        Task {
                            do {
                                try await viewModel.updateUserData()
                                dismiss()
                            } catch {
                                print("❌ 프로필 업데이트 실패: \(error)")
                                viewModel.errorMessage = "프로필 업데이트에 실패했습니다: \(error.localizedDescription)"
                                showErrorAlert = true
                            }
                        }
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                }
            }
            // 에러 메시지 모니터링
            .onChange(of: viewModel.errorMessage) { _, newValue in
                if newValue != nil {
                    showErrorAlert = true
                }
            }
            // 에러 알림 표시
            .alert("오류", isPresented: $showErrorAlert) {
                Button("확인", role: .cancel) {
                    viewModel.errorMessage = nil
                }
            } message: {
                Text(viewModel.errorMessage ?? "알 수 없는 오류가 발생했습니다")
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: dev.user)
    }
}
