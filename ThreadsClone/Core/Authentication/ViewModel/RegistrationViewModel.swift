//
//  RegistrationViewModel.swift
//  ThreadsClone
//
//  Created by YOON on 6/16/25.
//

import Foundation

// ObservableObject는 SwiftUI에서 상태를 관리하기 위해 사용되는 프로토콜입니다.
// 이 프로토콜을 채택한 클래스는 SwiftUI 뷰에서 상태가 변경될 때 자동으로 업데이트됩니다.
// LoginViewModel과 ResignViewModel은 인증상태가 변화할때 AuthService의 userSession property를 업데이트한다
// 같은 userSession을 공유하여 인증 상태를 관리하기 때문에 LoginViewModel과 ResignViewModel은 AuthService의 userSession 프로퍼티를 사용하여 인증 상태를 업데이트합니다.
class RegistrationViewModel: ObservableObject {
    // @State를 사용하여 상태 변수를 선언합니다.
    // @State는 SwiftUI에서 상태를 관리하는 데 사용되는 프로퍼티 래퍼입니다.
    // 이 변수가 변경되면 뷰가 자동으로 업데이트됩니다.
    // @Published는 ObservableObject 프로토콜을 채택한 클래스에서 사용되는 프로퍼티 래퍼입니다.
    // 이 프로퍼티가 변경되면 SwiftUI 뷰가 자동으로 업데이트됩니다.
    // 이 변수들은 사용자 등록에 필요한 정보를 저장합니다.
    // 이 변수들은 이메일, 비밀번호, 전체 이름, 사용자 이름을 저장합니다.
    @Published  var email: String = ""
    @Published  var password: String = ""
    @Published  var fullname: String = ""
    @Published  var username: String = ""
    @Published  var isLoading = false
    @Published  var showAlert = false
    @Published  var errorMessage: String?
    @Published  var isEmailInvalid = false
    @Published  var isPasswordInvalid = false
    @Published  var isFullnameInvalid = false
    @Published  var isUsernameInvalid = false
    
    
    // @MainActor는 SwiftUI에서 UI 업데이트를 안전하게 처리하기 위해 사용되는 속성입니다.
    // 이 속성을 사용하면 해당 메서드가 항상 메인 스레드에서 실행되도록 보장합니다.
    // 이 메서드는 비동기적으로 실행되며, 사용자 생성 작업이 완료될 때까지 기다립니다.
    // 이 메서드는 사용자 생성 작업을 시작하고, 성공적으로 완료되면 UI를 업데이트합니다.
    // 만약 작업 중 오류가 발생하면, 해당 오류를 처리할 수 있습니다.
    // async throws는 이 메서드가 비동기적으로 실행되며, 오류를 던질 수 있음을 나타냅니다.
    // shared는 AuthService의 싱글톤 인스턴스를 사용하여 사용자 생성 작업을 수행합니다.
    // crateUser 메서드는 이메일, 비밀번호, 전체 이름, 사용자 이름을 사용하여 새로운 사용자를 생성하고 Firestore에 저장합니다.
    @MainActor
    func createUser() async {
        guard validateFields() else {
            self.showAlert = true
            self.errorMessage = "모든 필드를 채워주세요."
            return
        }
        
        // try await는 비동기 작업을 실행하고, 해당 작업이 실패할 경우 오류를 던집니다.
        isLoading = true
        do {
            try await AuthService.shared.createUser(
                withEmail: email,
                password: password,
                fullName: fullname,
                username: username)
        } catch {
            self.showAlert = true
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    private func validateFields() -> Bool {
        isEmailInvalid = email.isEmpty
        isPasswordInvalid = password.isEmpty
        isFullnameInvalid = fullname.isEmpty
        isUsernameInvalid = username.isEmpty
        
        return !isEmailInvalid && !isPasswordInvalid && !isFullnameInvalid && !isUsernameInvalid
    }
    
}
