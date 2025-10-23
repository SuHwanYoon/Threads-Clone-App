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

            Image("login-title-image")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()

            VStack(spacing: 12) {
                TextField("이메일을 입력해주세요", text: $viewModel.email)
                    .autocapitalization(.none) // 이메일 입력 시 자동 대문자 변환을 방지합니다.
                    .modifier(TextFiledModifier())
                    
                
                SecureField("패스워드를 입력해주세요", text: $viewModel.password)
                    .modifier(TextFiledModifier())
                    
                
                TextField("계정이름을 입력해주세요", text: $viewModel.fullname)
                    .autocapitalization(.none) // 이메일 입력 시 자동 대문자 변환을 방지합니다.
                    .modifier(TextFiledModifier())
                    
                
                TextField("닉네임을 입력해주세요", text: $viewModel.username)
                    .autocapitalization(.none)
                    .modifier(TextFiledModifier())
                    
            }

            Button {
                // Task는 Swift Concurrency에서 비동기 작업을 나타내는 구조체입니다.
                // try await를 사용하여 비동기 작업을 수행합니다.
                Task { await viewModel.createUser() }
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text("회원가입")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            }
            .frame(width: 352, height: 44)
            .background(Color.theme.accent)
            .cornerRadius(8)
            .padding(.vertical)
            .disabled(viewModel.isLoading)
            .opacity(viewModel.isLoading ? 0.7 : 1.0)

            Spacer()

            Divider()
            
            // 이곳에서 버튼을 사용하여 로그인 화면으로 이동합니다.
            Button {
                // dismiss()를 호출하여 현재 뷰를 닫습니다.
                // 이 경우, 로그인 화면으로 돌아갑니다.
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("이미 계정이 있습니까?")

                    Text("로그인하러 가기")
                        .fontWeight(.semibold)
                }
                .foregroundColor(Color.theme.primaryText)
                .font(.footnote)
            }
            .padding(.vertical, 16)
        }
        .background(Color.theme.background)
        .ignoresSafeArea()
        .alert("회원가입 실패", isPresented: $viewModel.showAlert) {
            Button("확인") { }
        } message: {
            Text(viewModel.errorMessage ?? "알 수 없는 오류가 발생했습니다. 다시 시도해주세요.")
        }
    }
}

#Preview {
    RegistrationView()
}
