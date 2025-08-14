//
//  SettingListView.swift
//  ThreadsClone
//
//  Created by YOON on 8/12/25.
//

import SwiftUI

struct SettingListView: View {
    @State private var showDeleteConfirmation = false
    @State private var deletionError: Error?
    @State private var showErrorAlert = false
    
    var body: some View {
        // 로그아웃, 탈퇴하기, 개인정보처리방침 메뉴를 표시하는 설정 화면입니다.
        NavigationStack {
            ScrollView(showsIndicators: true){
                VStack(spacing: 20) {
                    // 로그아웃 버튼
                    Button(action: {
                        // 로그아웃 액션
                        AuthService.shared.signOut()
                        print("로그아웃")
                    }) {
                        Text("로그아웃")
                            .font(.headline)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    
                    // 탈퇴하기 버튼
                    Button(action: {
                        // 탈퇴하기 액션
                        showDeleteConfirmation = true
                        print("탈퇴하기")
                    }) {
                        Text("탈퇴하기")
                            .font(.headline)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }

                    // 문의하기
                    Link(destination: URL(string: "https://forms.gle/YaQo2h89nZFMiB9m7")!) {
                        Text("문의하기")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    
                    // 개인정보처리방침 링크
                    Link(destination: URL(string: "https://doc-hosting.flycricket.io/oneulyiilgi-gaeinjeongboceorijeongcaeg/b05dec6e-5211-4c49-a5e6-22f76564673b/privacy")!) {
                        Text("개인정보처리방침")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .padding()
                .navigationTitle("설정")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(false)
                
            }
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
