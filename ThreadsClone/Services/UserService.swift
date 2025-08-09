//
//  UserService.swift
//  ThreadsClone
//
//  Created by YOON on 7/26/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

// 이 서비스는 싱글톤 패턴을 사용하여 애플리케이션 전역에서 단일 인스턴스를 공유합니다.
// Service는 화면과 분리된 데이터 처리 모듈
class UserService {
    // @Published 프로퍼티를 사용하여 현재 사용자 정보를 저장하고, SwiftUI에서 이 정보를 구독할 수 있도록 합니다.
    // currentUser 프로퍼티는 Firebase에서 사용자 데이터를 가져올때마다 업데이트하고
    // 사용자가 정보를 변경하면 새로운 값을 저장해야 하기때문에 var로 선언합니다.
    @Published var currentUser: User?
    // 싱글톤 인스턴스를 생성하여 애플리케이션 전역에서 UserService를 사용할 수 있도록 합니다.
    static let shared = UserService()
    
    // 초기화 메서드입니다. UserService의 인스턴스를 생성할 때 호출됩니다.
    // 이 메서드는 fetchCurrentUser()를 호출하여 현재 사용자의 정보를 가져옵
    // Task를 사용하여 비동기적으로 데이터를 가져옵니다.
    // fetchCurrentUser메서드를 비동기적으로 호출하는 이유는 Firebase에서 데이터를 가져오는 작업이 네트워크 요청을 포함하기 때문입니다.
    init() {
        Task {try await fetchCurrentUser()}
            
    }
    
    // 이 메서드는 앱이 시작될 때 한 번만 호출되는 이유는 싱글톤 패턴을 사용하기 때문입니다.
    // fetchCurrentUser 메서드는 Firebase에서 현재 사용자의 정보를 가져오는 기능을 제공합니다.
    @MainActor
    func fetchCurrentUser() async throws {
        // 현재 로그인된 사용자의 UID를 가져옵니다.
        // FirebaseAuth의 currentUser 프로퍼티를 사용하여 현재 로그인된 사용자의 정보를 가져옵니다.
        // 만약 현재 사용자가 로그인되어 있지 않다면, 이 메서드는 아무 작업도 수행하지 않습니다.
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        // Firestore에서 현재 사용자의 문서를 가져옵니다.
        // Firestore.firestore()를 사용하여 Firestore Database에 접근하고, collection("users")를 통해 "users" 컬렉션을 선택합니다.
        // document(uid)를 사용하여 현재 사용자의 UID에 해당하는 문서를 선택합니다.
        // await를 사용하여 데이터 조회가 완료될 때까지 기다립니다.
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        
        // snapshot.data(as: User.self)를 사용하여 Firestore에서 가져온 문서를 User 모델로 변환합니다.
        // 이 메서드는 Firestore에서 가져온 데이터를 User 모델로 디코딩합니다
        // 만약 문서가 존재하지 않거나 데이터가 User 모델로 변환되지 않는 경우, currentUser는 nil이 됩니다.
        let user = try snapshot.data(as: User.self)
        // Firebase에서 가져온 사용자 정보를 UserService의 currentUser 프로퍼티에 저장합니다.
        self.currentUser = user
        
        // 현재 사용자 정보를 출력합니다.
        print("Debug: User is \(user)")
    }
    
    // static func는 UserService 클래스의 인스턴스 없이 호출할 수 있는 메서드입니다.
    // 따라서 shared 인스턴스를 통해 호출할 필요가 없습니다.
    // -> [User]는 User 모델의 배열을 반환합니다.
    // fetchUser 메서드는 Firestore에서 모든 사용자의 정보를 가져오는 기능을 제공합니다.
    // 이 메서드는 비동기적으로 실행되며, 현재 로그인된 사용자의 UID를 제외한 모든 사용자의 정보를 반환합니다.
    // Firestore에서 "users" 컬렉션의 모든 문서를 가져와서 User 모델로 변환합니다.
    // 현재 사용자의 UID를 제외한 사용자 목록을 반환합니다.
    static func fetchUsers() async throws -> [User] {
        // guard는 조건이 참이 아닐 경우 return을 사용하여 메서드를 종료합니다.
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
        // snapshot 변수를 사용하여 Firestore에서 "users" 컬렉션의 모든 문서를 가져옵니다.
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        // snapshot.documents는 Firestore에서 가져온 모든 문서를 포함하는 배열입니다.
        // data as 로 Json디코딩을 실행하여 User 모델로 변환합니다.
        // try?를 사용하여 변환이 실패할 경우 에러를 발생시키지 않고 nil을 반환합니다
        // compactMap 메서드는 nil 값을 제외하고, 유효한 User 모델만을 포함하는 배열을 생성합니다.
        // 따라서 documents를 가져온 후, 각 문서중 변환 실패한 nil은 제외하고 User 모델로 변환
        // 이 메서드는 Firestore에서 가져온 모든 사용자 문서를 User 모델로 변환하고,
        // 현재 사용자의 UID를 제외한 사용자 목록을 반환합니다.
        let users = snapshot.documents.compactMap { try? $0.data(as: User.self) }
        // 현재 사용자의 UID와 같은 사용자는 필터링하고 사용자 목록을 반환합니다.
        return users.filter { $0.id != currentUid }
    }
    
    // User객체 하나를 반환하는 fetchUser 메서드는 Firestore에서 특정 사용자의 정보를 가져오는 기능을 제공합니다.
    static func fetchUser(withUid uid: String) async throws -> User? {
        
        // Firestore에서 현재 사용자의 문서를 가져옵니다.
        // Firestore.firestore()를 사용하여 Firestore Database에 접근하고, collection("users")를 통해 "users" 컬렉션을 선택합니다.
        // document(uid)를 사용하여 현재 사용자의 UID에 해당하는 문서를 선택합니다.
        // await를 사용하여 데이터 조회가 완료될 때까지 기다립니다.
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        
        // snapshot.data(as: User.self)를 사용하여 Firestore에서 가져온 문서를 User 모델로 변환합니다.
        // 이 메서드는 Firestore에서 가져온 데이터를 User 모델로 디코딩합니다
        // 만약 문서가 존재하지 않거나 데이터가 User 모델로 변환되지 않는 경우, currentUser는 nil이 됩니다.
        return try snapshot.data(as: User.self)

    }
    
    
    // func reset
    // 이 메서드는 현재 사용자의 정보를 초기화하는 기능을 제공합니다.
    // 현재 사용자의 정보를 nil로 설정하여 사용자 세션을 초기화합니다.
    func reset() {
        self.currentUser = nil
    }
    
    // withImageUrl은 외부 파라미터, imageUrl은 내부 파라미터입니다.
    @MainActor
    func updateUserProfileImage(withImageUrl imageUrl: String) async throws {
        // 현재 로그인된 사용자의 UID를 가져옵니다.
        // Auth.auth().currentUser?.uid를 사용하여 현재 로그인된 사용자의 UID를
        // 가져옵니다. 만약 현재 사용자가 로그인되어 있지 않다면, 이 메서드는 아무 작업도 수행하지 않습니다.
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        // Firestore Database에 접근하여 현재 사용자의 프로필 이미지 URL을 업데이트합니다.
        // Firestore.firestore()를 사용하여 Firestore Database에 접근하고,
        // collection("users")를 통해 "users" 컬렉션을 선택합니다.
        // document(currentUid)를 사용하여 현재 사용자의 UID에 해당하는 문서를 선택합니다.
        // updateData(["profileImageUrl": imageUrl])를 사용하여 프로필 이미지 URL을 업데이트합니다.
        try await Firestore.firestore().collection("users").document(currentUid).updateData(["profileImageUrl": imageUrl])
        // 현재 사용자의 프로필 이미지 URL을 업데이트합니다.
        self.currentUser?.profileImageUrl = imageUrl
    }
}

