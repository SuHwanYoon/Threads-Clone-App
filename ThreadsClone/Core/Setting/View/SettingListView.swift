import SwiftUI

struct SettingListView: View {
    @State private var showDeleteConfirmation = false
    @State private var deletionError: Error?
    @State private var showErrorAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.background.ignoresSafeArea()
                
                Form {
                    Section(header: Text("계정")) {
                        Button(action: {
                            AuthService.shared.signOut()
                        }) {
                            Text("로그아웃")
                                .foregroundColor(.red)
                        }
                        
                        Button(action: {
                            showDeleteConfirmation = true
                        }) {
                            Text("탈퇴하기")
                                .foregroundColor(.red)
                        }
                    }
                    
                    Section(header: Text("지원")) {
                        Link("문의하기", destination: URL(string: "https://forms.gle/YaQo2h89nZFMiB9m7")!)
                            .foregroundColor(Color.theme.accent)
                        
                        Link("개인정보처리방침", destination: URL(string: "https://doc-hosting.flycricket.io/oneulyiilgi-gaeinjeongboceorijeongcaeg/b05dec6e-5211-4c49-a5e6-22f76564673b/privacy")!)
                            .foregroundColor(Color.theme.accent)
                    }
                    
                    Section {
                        Text("개발자 Email: suhwan6@gmail.com")
                            .font(.footnote)
                            .foregroundColor(Color.theme.secondaryText)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
            .alert("계정을 삭제하시겠습니까?", isPresented: $showDeleteConfirmation) {
                Button("취소", role: .cancel) { }
                Button("삭제", role: .destructive) {
                    Task {
                        do {
                            try await AuthService.shared.deleteAccount()
                        } catch {
                            self.deletionError = error
                            self.showErrorAlert = true
                        }
                    }
                }
            } message: {
                Text("이 작업은 되돌릴 수 없으며, 모든 데이터가 영구적으로 삭제됩니다.")
            }
            .alert("오류", isPresented: $showErrorAlert) {
                Button("확인") { }
            } message: {
                Text(deletionError?.localizedDescription ?? "알 수 없는 오류가 발생했습니다.")
            }
        }
    }
}

#Preview {
    SettingListView()
}