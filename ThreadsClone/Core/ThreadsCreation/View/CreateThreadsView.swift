//
//  CreateThreadsView.swift
//  ThreadsClone
//
//  Created by YOON on 5/7/25.
//

import SwiftUI

struct CreateThreadsView: View {
    // 상태 변수를 사용하여 텍스트 필드의 내용을 저장합니다.
    @State private var caption: String = ""
    // @Environment는 SwiftUI에서 환경 값을 가져오는 데 사용됩니다.
    // dismiss는 모달로 표시된 현재 뷰를 닫는 기능을 제공하는 환경 값입니다.
    // 주로 .sheet, .fullScreenCover, .navigationLink 로 표시된 뷰를 닫는 데 사용됩니다.
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            // 프로필 Hstack과 스레드 입력 필드를 포함하는 VStack을 사용합니다.
            VStack {
                HStack(alignment: .top) {
                    CircularProfileImageView()

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Yoon Suhwan")
                            .fontWeight(.semibold)
                        // 스레드입력 필드
                        // axis: .vertical을 사용하여 여러 줄 입력이 가능하도록 설정합니다.
                        TextField(
                            "Start a new thread...",
                            text: $caption,
                            axis: .vertical
                        )
                    }
                    .font(.footnote)

                    Spacer()
                    // caption이 비어있지 않으면 xmark 버튼을 표시합니다.
                    if !caption.isEmpty {
                        Button {
                            // xmark버튼을 누르면 caption을 비워서 입력 필드를 초기화합니다.
                            caption = ""
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.gray)
                        }
                    }

                }
                // 스레드 입력 필드와 간격을 둡니다.
                Spacer()

            }
            // view 전체에 padding을 적용합니다.
            .padding()
            .navigationTitle("New Threads")
            .navigationBarTitleDisplayMode(.inline)
            // .toolbar를 사용하여 네비게이션 바에 버튼을 추가합니다.
            .toolbar {
                // ToolbarItem을 사용하여 네비게이션 바에 왼쪽에는 "Cancel" 버튼
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        // 취소 버튼을 누르면 현재 뷰를 닫습니다.
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundColor(.black)
                }
                // ToolbarItem을 사용하여 네비게이션 바에 오른쪽에는 "Post" 버튼
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post") {

                    }
                    // opacity을 사용하여 caption이 비어있을 때 버튼을 반투명하게 표시합니다.
                    // Textfield의 내용이 비어있으면 버튼을 비활성화합니다.
                    // Textfield에 텍스트가 있으면 버튼을 누를수 있도록 활성화
                    .opacity(caption.isEmpty ? 0.5 : 1.0)
                    .disabled(caption.isEmpty)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    CreateThreadsView()
}
