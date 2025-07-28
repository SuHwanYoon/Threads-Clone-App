//
//  RegistrationView.swift
//  ThreadsClone
//
//  Created by YOON on 5/5/25.
//

import SwiftUI

struct RegistrationView: View {
    // @StateObject는 SwiftUI에서 상태 객체를 생성하는 데 사용되는 프로퍼티 래퍼입니다.
    // 이 경우, RegistrationViewModel을 상태 객체로 사용하여 뷰의 상태를 관리합니다.
    // RegistrationViewModel은 사용자 등록 관련 로직을 처리하는 뷰 모델입니다.
    @StateObject var viewModel = RegistrationViewModel()

    // @Environment는 SwiftUI에서 환경 값을 읽는 데 사용되는 프로퍼티 래퍼입니다.
    // 이 경우, dismiss는 현재 뷰를 닫는 데 사용됩니다.
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        // VStack을 사용하여 뷰를 세로로 쌓습니다.
        VStack {
            Spacer()

            Image("clone-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()

            VStack {
                TextField("Enter Email", text: $viewModel.email)
                    .autocapitalization(.none) // 이메일 입력 시 자동 대문자 변환을 방지합니다.
                    .modifier(TextFiledModifier())
                
                SecureField("Enter Password", text: $viewModel.password)
                    .modifier(TextFiledModifier())
                
                TextField("Enter full name", text: $viewModel.fullname)
                    .modifier(TextFiledModifier())
                
                TextField("Enter username", text: $viewModel.username)
                    .autocapitalization(.none)
                    .modifier(TextFiledModifier())
            }

            Button {
                // Task는 Swift Concurrency에서 비동기 작업을 나타내는 구조체입니다.
                // try await를 사용하여 비동기 작업을 수행합니다.
                // viewModel.createUser() 메서드를 호출하여 사용자를 생성합니다.
                Task { try await viewModel.createUser()}
            } label: {
                Text("Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 352, height: 44)
                    .background(.black)
                    .cornerRadius(8)
            }
            .padding(.vertical)

            Spacer()

            Divider()
            // 이곳에서 버튼을 사용하여 로그인 화면으로 이동합니다.
            Button {
                // dismiss()를 호출하여 현재 뷰를 닫습니다.
                // 이 경우, 로그인 화면으로 돌아갑니다.
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")

                    Text("Sign In")
                        .fontWeight(.semibold)

                }
                .foregroundColor(.black)
                .font(.footnote)
            }
            .padding(.vertical, 16)

        }
    }
}

#Preview {
    RegistrationView()
}
