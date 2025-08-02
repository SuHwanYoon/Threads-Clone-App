//
//  ExploerViewModel.swift
//  ThreadsClone
//
//  Created by YOON on 7/31/25.
//

import Foundation

// ExploreViewModel은 Explore 화면에서 사용되는 데이터를 관리합니다.
class ExploreViewModel: ObservableObject {
    // @Published 프로퍼티 래퍼를 사용하여 users 배열이 변경될 때마다
    // SwiftUI 뷰가 자동으로 업데이트되도록 합니다.
    // User타입의 배열[]로, User들을 한줄로 담은 배열
    // users: [User] = [] 또는 아래와 같이 선언할 수 있습니다.
    // users에서는 Firebase Firestore에서 가져온 사용자들의 정보를 리스트로 저장합니다.
    @Published var users = [User]()
    
    // fetchUsers 메서드는 ExploreViewModel이 초기화될 때 호출되어
    // 사용자 데이터를 비동기적으로 가져옵니다.
    // Firebase Firestore에서 사용자 데이터를 가져오는 기능이니까 비동기
    init() {
        Task { try await fetchUsers() }
    }
    
    // fetchUsers 메서드는 사용자 데이터를 가져오는 기능을 제공합니다.
    @MainActor
    private func fetchUsers() async throws {
        // UserService.fetchUsers()를 호출하여 Firestore에서 사용자 데이터를 가져옵니다.
        // fetchUsers() 메서드를 호출하여 users 배열에 사용자 데이터를 저장합니다.
        self.users = try await UserService.fetchUsers()
    }
    
    
}
