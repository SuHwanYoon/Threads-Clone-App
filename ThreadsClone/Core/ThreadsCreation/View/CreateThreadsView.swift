//
//  CreateThreadsView.swift
//  ThreadsClone
//
//  Created by YOON on 5/7/25.
//

import SwiftUI

struct CreateThreadsView: View {
    @StateObject var viewModel = CreateThreadViewModel()
    @State private var caption: String = ""
    @State private var isLoading = false
    @State private var uploadError: Error?
    @State private var showErrorAlert = false
    @Environment(\.dismiss) private var dismiss
    
    private var user: User? {
        return UserService.shared.currentUser
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    HStack(alignment: .top) {
                        CircularProfileImageView(user: user)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user?.username ?? "")
                                .fontWeight(.semibold)
                            
                            TextField(
                                "새로운 일기 입력",
                                text: $caption,
                                axis: .vertical
                            )
                        }
                        .font(.footnote)
                        .foregroundColor(Color.theme.primaryText)
                        
                        Spacer()
                        
                        if !caption.isEmpty {
                            Button {
                                caption = ""
                            } label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                    .foregroundColor(Color.theme.secondaryText)
                            }
                        }
                    }
                    
                    Spacer()
                }
                // view 전체에 padding을 적용합니다.
                .padding()
                .background(Color.theme.background)
                .navigationTitle("새로운 일기")
                .navigationBarTitleDisplayMode(.inline)
                // .toolbar를 사용하여 네비게이션 바에 버튼을 추가합니다.
                .toolbar {
                    // ToolbarItem을 사용하여 네비게이션 바에 왼쪽에는 "Cancel" 버튼
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("취소") {
                            // 취소 버튼을 누르면 현재 뷰를 닫습니다.
                            dismiss()
                        }
                        .font(.subheadline)
                        .foregroundColor(Color.theme.primaryText)
                        .disabled(isLoading)
                    }
                    // ToolbarItem을 사용하여 네비게이션 바에 오른쪽에는 "Post" 버튼
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("등록") {
                            Task {
                                isLoading = true
                                do {
                                    try await viewModel.uploadThread(caption: caption)
                                    isLoading = false
                                    dismiss()
                                } catch {
                                    isLoading = false
                                    uploadError = error
                                    showErrorAlert = true
                                }
                            }
                        }
                        // opacity을 사용하여 caption이 비어있을 때 버튼을 반투명하게 표시합니다.
                        // Textfield의 내용이 비어있으면 버튼을 비활성화합니다.
                        // Textfield에 텍스트가 있으면 버튼을 누를수 있도록 활성화
                        .opacity(caption.isEmpty ? 0.5 : 1.0)
                        .disabled(caption.isEmpty || isLoading)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.theme.accent)
                    }
                }
                .alert("업로드 실패", isPresented: $showErrorAlert) {
                    Button("확인") { }
                } message: {
                    Text(uploadError?.localizedDescription ?? "일기 등록 중 오류가 발생했습니다. 다시 시도해주세요.")
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

#Preview {
    CreateThreadsView()
}