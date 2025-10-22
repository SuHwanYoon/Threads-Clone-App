//
//  AuthService.swift
//  ThreadsClone
//
//  Created by YOON on 6/16/25.
//

import Firebase
import FirebaseAuth
// FirebaseFirestore는 Firestore 데이터베이스와 상호작용하기 위한 라이브러리입니다.
import FirebaseFirestore

// AuthService 클래스는 userSeession property를 통해 현재 로그인된 사용자의 세션 정보를 관리합니다.
class AuthService{
    // userSession 프로퍼티는 현재 로그인된 사용자의 세션 정보를 저장합니다.
    // FirebaseAuth.User? 타입으로 선언되어 있으며, 이는 Firebase Authentication에서 사용되는 사용자 객체를 나타냅니다.
    // @Published는 SwiftUI에서 상태 변화를 감지하고 UI를 업데이트하기 위해 사용되는 프로퍼티 래퍼입니다.
    // 이 userSession은 LoginViewModel와 RegistrationViewModel에서 사용되며, 사용자의 로그인 상태를 관리하고 인증 상태가 변경될 때 UI를 업데이트합니다.
    @Published var userSession: FirebaseAuth.User?
    
    
    // 싱글톤 패턴을 사용하여 AuthService의 인스턴스를 공유합니다.
    // let으로 선언된 shared 프로퍼티는 AuthService의 유일한 인스턴스를 나타내며 다른 클래스나 구조체에서 새로운 인스턴스를 생성하는 것을 방지합니다.
    // shared는 AuthService의 유일한 인스턴스를 나타내며, 앱 전체에서 이 인스턴스를 사용할 수 있습니다.
    // 다른 클래스나 구조체에서 AuthService.shared를 통해 이 인스턴스에 접근해서 사용할 수 있습니다.
    static let shared = AuthService()
    
    // 초기화 메서드입니다.
    // 이 메서드는 AuthService의 인스턴스를 생성할 때 호출되며, 현재 로그인된 사용자의 세션을 가져옵니다.
    // FirebaseAuth의 currentUser 프로퍼티를 사용하여 현재 로그인된 사용자의 정보를 가져옵니다.
    // 이 정보를 userSession 프로퍼티에 할당합니다.
    // 이렇게 함으로써, 앱이 시작될 때 현재 로그인된 사용자의 세션 정보를 자동으로 가져올 수 있습니다.
    // 이 초기화 메서드는 AuthService의 인스턴스가 생성될 때 한 번만 호출됩니다.
    init (){
        self.userSession = Auth.auth().currentUser
    }
    
    
    // withEmail 속성은 이메일과 비밀번호를 사용하여 사용자를 로그인하는 기능을 제공합니다.
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do{
            let loginResult = try await Auth.auth().signIn(withEmail: email, password: password)
            // 로그인 성공 시 userSession 프로퍼티에 로그인된 사용자의 세션 정보를 저장합니다.
            self.userSession = loginResult.user
            // .uid는 Firebase에서 생성된 사용자의 고유한 ID를 나타냅니다.
            print("Debug: User Logged in with UID: \(loginResult.user.uid)")
            // UserService.shared.fetchCurrentUser()를 호출하여 현재 사용자의 정보를 가져옵니다.
            try await UserService.shared.fetchCurrentUser()
        } catch{
            // error.localizedDescription은 로그인 중 발생한 오류의 설명을 출력합니다.
            print("Debug: Failed to Login user with error: \(error.localizedDescription)")
            throw error
        }
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
            let createUserResult = try await Auth.auth().createUser(withEmail: email, password: password)
            // 사용자 생성이 성공하면 userSession 프로퍼티에 생성된 사용자의 세션 정보를 저장합니다.
            self.userSession = createUserResult.user
            print("Debug: User created with UID: \(createUserResult.user.uid)")
            // uploadUserData 메서드를 호출하여 Firestore에 사용자 데이터를 업로드합니다.
            try await uploadUserData(withEmail: email, fullname: fullName, username: username, id: createUserResult.user.uid)
        } catch{
            print("Debug: Failed to create user with error: \(error.localizedDescription)")
            throw error
        }
    }
    
    // signOut 메서드는 사용자를 로그아웃하는 기능을 제공합니다.
    // 이 메서드는 Firebase Authentication의 signOut 메서드를 호출하여 현재 로그인된 사용자의 세션을 종료합니다.
    // try?를 사용하여 로그아웃 작업이 실패하더라도 오류를 무시하고 계속 진행합니다.
    // 로그아웃 후에는 userSession 프로퍼티를 nil로 설정하여 현재 로그인된 사용자가 없음을 나타냅니다.
    func signOut(){
        try? Auth.auth().signOut()
        // 로그아웃 후 userSession을 nil로 설정하여 현재 로그인된 사용자가 없음을 나타냅니다.
        // 이렇게 함으로써, 앱의 인증 상태가 업데이트되고, 로그인 화면으로 돌아갈 수 있습니다.
        // FirebaseAuth의 인증 세션만 초기화하며 currentUser의 정보를 초기화하지 않습니다.
        self.userSession = nil
        // signout시 UserService.shared.reset()을 호출하여 currentUser를 초기화합니다.
        UserService.shared.reset()
    }
    
    // 회원탈퇴 메서드
    @MainActor
    func deleteAccount() async throws {
        // 현재 로그인된 사용자를 가져옵니다.
        guard let user = Auth.auth().currentUser else {
            print("Debug: 삭제할 사용자를 찾을 수 없습니다.")
            return
        }
        
        let userUID = user.uid
        
        do {
            // Firebase Authentication에서 사용자정보를 제일 먼저 삭제합니다.
            try await user.delete()
            print("Debug: Firebase Auth에서 사용자 계정이 삭제되었습니다.")
            
            
            // 해당 사용자가 작성한 모든 스레드를 삭제합니다.
            // 스레드는 User정보에 의존하기 때문에 의존하는 쪽을 먼저 삭제
            try await ThreadService.deleteUserThreads(uid: userUID)
            print("Debug: 사용자의 모든 스레드가 삭제되었습니다.")
            

            // Firestore에서 사용자 문서를 삭제합니다.
            // 마지막으로 User document를 삭제
            try await Firestore.firestore().collection("users").document(userUID).delete()
            print("Debug: Firestore에서 사용자 데이터가 삭제되었습니다.")
            
            // 계정정보, 해당유저의 스레드, 사용자 문서 삭제후 로그아웃을 호출하여 로컬 세션을 정리합니다.
            self.signOut()
            
        } catch {
            print("Debug: 계정 삭제 실패: \(error.localizedDescription)")
            // 오류를 다시 던져 호출 측(ViewModel/View)에서 처리하도록 합니다.
            throw error
        }
    }
    
    
    // uploadUserData 메서드는 사용자의 프로필 데이터를 Firestore에 업로드하는 기능을 제공합니다.
    // async throws는 이 메서드가 비동기적으로 실행되며, 오류를 던질 수 있음을 나타냅니다.
    // async 함수로 선언하면 비동기적으로 실행되며, await 키워드를 사용하여 비동기 작업을 기다릴 수 있습니다.
    @MainActor
    func uploadUserData
    (withEmail email: String,
     fullname: String,
     username: String,
     id: String)
    async throws {
        // User의 정보가 담길 User 객체를 생성해 선언
        let user = User(id: id, fullname: fullname, email: email, username: username )
        
        // guard 구문은 조건이 충족되지 않을 경우 메서드를 종료하는 데 사용됩니다.
        // guard let 구문은 user 객체를 Firestore에 인코딩할 때 사용됩니다.
        // Firestore.Encoder().encode(user)는 User 객체를 Firestore에 저장할 수 있는 형식으로 변환합니다.
        // 만약 인코딩이 실패하면 메서드를 종료합니다.
        // userData는 인코딩된 User 객체를 나타냅니다.
        guard let userData = try? Firestore.Encoder().encode(user) else {return}
        
        // try await는 비동기 작업을 호출하고, 해당 작업이 실패할 경우 오류를 던집니다.
        // awiat는 비동기 함수의 결과를 기다릴때 사용하고 비동기 함수를 호출하는 부분에서 사용
        // Firestore 데이터베이스에 사용자 데이터를 업로드합니다.
        // Firestore.firestore()는 Firestore 데이터베이스에 접근하기 위한 메서드입니다.
        // collection("users")는 "users"라는 임의로 지정한 이름의 컬렉션에 접근합니다.
        // document(id)는 해당 컬렉션 내에서 특정 사용자의 문서를 지정합니다.
        // setData(userData)는 지정된 문서에 userData를 저장합니다.
        try await Firestore.firestore().collection("users")
            .document(id).setData(userData)
    }
}
