//
//  RegistrationViewModel.swift
//  ThreadsClone
//
//  Created by YOON on 6/16/25.
//

import Foundation

// ObservableObject는 SwiftUI에서 상태를 관리하기 위해 사용되는 프로토콜입니다.
// 이 프로토콜을 채택한 클래스는 SwiftUI 뷰에서 상태가 변경될 때 자동으로 업데이트됩니다.
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
    
    
    // @MainActor는 SwiftUI에서 UI 업데이트를 안전하게 처리하기 위해 사용되는 속성입니다.
    // 이 속성을 사용하면 해당 메서드가 항상 메인 스레드에서 실행되도록 보장합니다.
    // 이 메서드는 비동기적으로 실행되며, 사용자 생성 작업이 완료될 때까지 기다립니다.
    // 이 메서드는 사용자 생성 작업을 시작하고, 성공적으로 완료되면 UI를 업데이트합니다.
    // 만약 작업 중 오류가 발생하면, 해당 오류를 처리할 수 있습니다.
    // async throws는 이 메서드가 비동기적으로 실행되며, 오류를 던질 수 있음을 나타냅니다.
    @MainActor
    func createUser() async throws {
        // try await는 비동기 작업을 실행하고, 해당 작업이 실패할 경우 오류를 던집니다.
        try await AuthService.shared.createUser(
            withEmail: email,
            password: password,
            fullName: fullname,
            username: username)
    }
    
}
