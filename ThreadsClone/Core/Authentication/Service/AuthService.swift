//
//  AuthService.swift
//  ThreadsClone
//
//  Created by YOON on 6/16/25.
//

import Firebase
import FirebaseAuth

class AuthService{
    
    // 싱글톤 패턴을 사용하여 AuthService의 인스턴스를 공유합니다.
    // let은 상수선언
    // shared는 AuthService의 유일한 인스턴스를 나타내며, 앱 전체에서 이 인스턴스를 사용할 수 있습니다.
    static let shared = AuthService()
    
    // withEmail 메서드는 이메일과 비밀번호를 사용하여 사용자를 로그인하는 기능을 제공합니다.
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        
    }
    
    // createUser 메서드는 이메일, 비밀번호, 전체 이름, 사용자 이름을 사용하여 새로운 사용자를 생성하는 기능을 제공합니다.
    // 이 메서드는 Firebase Authentication을 사용하여 사용자 계정을 생성합니다.
    // result 변수는 Firebase에서 반환된 사용자 생성 결과를 저장합니다.
    // 이 메서드는 비동기적으로 실행되며, 성공적으로 사용자가 생성되면 해당 사용자 정보를 출력합니다.
    // result.user.uid는 생성된 사용자의 고유한 ID를 나타냅니다.
    // error.localizedDescription은 사용자 생성 중 발생한 오류의 설명을 출력합니다.
    @MainActor
    func createUser(withEmail email: String, password: String, fullName: String, username: String) async throws {
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("Debug: User created with UID: \(result.user.uid)")
        } catch{
            print("Debug: Failed to create user with error: \(error.localizedDescription)")
        }
    }
    
}
