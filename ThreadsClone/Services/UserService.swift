//
//  UserService.swift
//  ThreadsClone
//
//  Created by YOON on 7/26/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

// UserService는 Firebase에서 현재 사용자의 정보를 가져오는 기능을 제공하는 서비스입니다.
// 이 서비스는 싱글톤 패턴을 사용하여 애플리케이션 전역에서 단일 인스턴스를 공유합니다.
class UserService {
    // @Published 프로퍼티를 사용하여 현재 사용자 정보를 저장하고, SwiftUI에서 이 정보를 구독할 수 있도록 합니다.
    @Published var currentUser: User?
    // 싱글톤 인스턴스를 생성하여 애플리케이션 전역에서 UserService를 사용할 수 있도록 합니다.
    static let shared = UserService()
    
    // 초기화 메서드입니다. UserService의 인스턴스를 생성할 때 호출됩니다.
    // 이 메서드는 fetchCurrentUser()를 호출하여 현재 사용자의 정보를 가져옵
    // Task를 사용하여 비동기적으로 데이터를 가져옵니다.
    init() {
        Task {try await fetchCurrentUser()}
            
    }
    
    // 이 메서드는 앱이 시작될 때 한 번만 호출되는 이유는 싱글톤 패턴을 사용하기 때문입니다.
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
        self.currentUser = user
        
        // 현재 사용자 정보를 출력합니다.
        print("Debug: User is \(user)")
            
        
    }
}

