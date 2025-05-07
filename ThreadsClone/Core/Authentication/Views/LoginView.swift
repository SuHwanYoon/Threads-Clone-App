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
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        // 네비게이션 스택은 SwiftUI에서 화면 전환을 관리하는 데 사용되는 구조입니다.
        // 네비게이션 스택은 화면을 쌓아서 관리합니다.
        NavigationStack {
            // VStack은 SwiftUI에서 뷰를 세로로 쌓는 데 사용되는 구조입니다.
            // VStack은 수직으로 뷰를 쌓습니다.
            VStack {
                Spacer()

                Image("clone-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding()

                VStack {
                    // email 필드
                    TextField("Enter Email", text: $email)
                        .autocapitalization(.none)
                        .modifier(TextFiledModifier())
                    // password 필드
                    SecureField("Enter Password", text: $password)
                        .modifier(TextFiledModifier())

                }
                // NavigationLink는 SwiftUI에서 화면 전환을 관리하는 데 사용되는 구조입니다.
                // NavigationLink는 화면을 전환할 때 사용됩니다.
                // NavigationLink는 버튼처럼 작동합니다.
                // NavigationLink는 destination을 지정하여 화면 전환을 관리합니다.
                NavigationLink {
                    Text("Forgot Password")
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.vertical)
                        .padding(.top)
                        .padding(.trailing, 20)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }

                Button {

                } label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 352, height: 44)
                        .background(.black)
                        .cornerRadius(8)
                }

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
                        Text("Don't have an account?")

                        Text("Sign Up")
                            .fontWeight(.semibold)

                    }
                    .foregroundColor(.black)
                    .font(.footnote)
                }
                .padding(.vertical, 16)

            }

        }
    }
}

#Preview(traits: .fixedLayout(width: 200, height: 400)) {
    LoginView()
}
