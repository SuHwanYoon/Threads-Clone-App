//
//  RegistrationView.swift
//  ThreadsClone
//
//  Created by YOON on 5/5/25.
//

import SwiftUI

struct RegistrationView: View {
    // @State를 사용하여 상태 변수를 선언합니다.
    // @State는 SwiftUI에서 상태를 관리하는 데 사용되는 프로퍼티 래퍼입니다.
    // 이 변수가 변경되면 뷰가 자동으로 업데이트됩니다.
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var fullname: String = ""
    @State private var username: String = ""
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
                TextField("Enter Email", text: $email)
                    .modifier(TextFiledModifier())
                
                SecureField("Enter Password", text: $password)
                    .modifier(TextFiledModifier())
                
                TextField("Enter full name", text: $fullname)
                    .modifier(TextFiledModifier())
                
                TextField("Enter username", text: $username)
                    .modifier(TextFiledModifier())
            }

            Button {

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
