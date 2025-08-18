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
    @Environment(\.dismiss) private var dismiss
    
    private var user: User? {
        return UserService.shared.currentUser
    }
    
    var body: some View {
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
                }
                // ToolbarItem을 사용하여 네비게이션 바에 오른쪽에는 "Post" 버튼
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("등록") {
                        Task {
                            try await viewModel.uploadThread(caption: caption)
                            dismiss()
                        }
                    }
                    // opacity을 사용하여 caption이 비어있을 때 버튼을 반투명하게 표시합니다.
                    // Textfield의 내용이 비어있으면 버튼을 비활성화합니다.
                    // Textfield에 텍스트가 있으면 버튼을 누를수 있도록 활성화
                    .opacity(caption.isEmpty ? 0.5 : 1.0)
                    .disabled(caption.isEmpty)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.theme.accent)
                }
            }
        }
    }
}

#Preview {
    CreateThreadsView()
}