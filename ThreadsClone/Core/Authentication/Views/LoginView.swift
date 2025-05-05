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
        // 네이게이션 스택을 사용하여 화면 전환을 관리합니다.
        NavigationStack {
            // VStack을 사용하여 뷰를 세로로 쌓습니다.
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
                    Text("RegeistrationView")
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

#Preview {
    LoginView()
}
