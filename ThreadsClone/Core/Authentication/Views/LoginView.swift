//
//  LoginView.swift
//  ThreadsClone
//
//  Created by YOON on 5/5/25.
//

import SwiftUI

struct LoginView: View {
    // @State를 사용하여 상태 변수를 선언합니다.
    // @State는 SwiftUI에서 상태를 관리하는 데 사용되는 프로퍼티 래퍼입니다.
    // 이 변수가 변경되면 뷰가 자동으로 업데이트됩니다.
//    @State private var email: String = ""
//    @State private var password: String = ""
    // LoginViewModel은 로그인 뷰의 상태를 관리하는 뷰모델을 선언
    // 선언해두면 해당 뷰에서 사용할 수 있습니다.
    // 뷰모델의 프로퍼티도 viewModel.email, viewModel.password 등으로 접근할 수 있습니다.
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        // 네비게이션 스택은 SwiftUI에서 화면 전환을 관리하는 데 사용되는 구조입니다.
        // 네비게이션 스택은 화면을 쌓아서 관리합니다.
        NavigationStack {
            // VStack은 SwiftUI에서 뷰를 세로로 쌓는 데 사용되는 구조입니다.
            // VStack은 수직으로 뷰를 쌓습니다.
            VStack {
                Spacer()

                Image("login-title-image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding()

                VStack {
                    // email 필드
                    TextField("이메일", text: $viewModel.email)
                        .autocapitalization(.none)
                        .modifier(TextFiledModifier())
                    // password 필드
                    SecureField("패스워드", text: $viewModel.password)
                        .modifier(TextFiledModifier())
                }
                
                // NavigationLink는 SwiftUI에서 화면 전환을 관리하는 데 사용되는 구조입니다.
                // NavigationLink는 화면을 전환할 때 사용됩니다.
                // NavigationLink는 버튼처럼 작동합니다.
                // NavigationLink는 destination을 지정하여 화면 전환을 관리합니다.
//                NavigationLink {
//                    Text("Forgot Password")
//                } label: {
//                    Text("Forgot Password?")
//                        .font(.footnote)
//                        .fontWeight(.semibold)
//                        .padding(.vertical)
//                        .padding(.top)
//                        .padding(.trailing, 28)
//                        .foregroundColor(Color.theme.secondaryText)
//                        .frame(maxWidth: .infinity, alignment: .trailing)
//                }

                Button {
                    // Task는 Swift Concurrency에서 비동기 작업을 나타내는 구조체입니다.
                    // await로 비동기 작업이 완료될 때까지 기다림
                    Task { try await viewModel.login() }
                } label: {
                    Text("로그인")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 352, height: 44)
                        .background(Color.theme.accent)
                        .cornerRadius(8)
                }
                .padding(.vertical)

                Spacer()

                Divider()

                NavigationLink {
                    // RegistrationView로 이동합니다.
                    // navigationBarBackButtonHidden(true)로 뒤로가기 버튼을 숨깁니다.
                    // 기본값은 false이고  false로 설정되있을경우는 상단 바에 뒤로가기 버튼을 표시합니다.
                   RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("계정이 없습니까?")

                        Text("계정등록")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(Color.theme.primaryText)
                    .font(.footnote)
                }
                .padding(.vertical, 16)
            }
            .background(Color.theme.background)
        }
    }
}

#Preview {
    LoginView()
}
