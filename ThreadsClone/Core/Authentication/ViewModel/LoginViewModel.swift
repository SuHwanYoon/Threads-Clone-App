//
//  LoginViewModel.swift
//  ThreadsClone
//
//  Created by YOON on 7/1/25.
//

import Foundation

// 이 ViewModel은 로그인 화면에서 사용되는 데이터를 관리합니다.
// LoginViewModel과 ResignViewModel은 인증상태가 변화할때 AuthService의 userSession property를 업데이트한다
// 같은 userSession을 공유하여 인증 상태를 관리하기 때문에 LoginViewModel과 ResignViewModel은 AuthService의 userSession 프로퍼티를 사용하여 인증 상태를 업데이트합니다.
class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    // login 메서드는 이메일과 비밀번호를 사용하여 사용자를 로그인하는 기능을 제공합니다.
    // AuthService.shared는 AuthService에서 제공하는 인스턴스 입니다.
    // 작동 방식은 AuthService의 login 메서드를 호출하여 Firebase Authentication을 통해 사용자를 인증합니다.
    @MainActor
    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
    
}
