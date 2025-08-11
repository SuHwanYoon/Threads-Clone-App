//
//  FeedViewModel.swift
//  ThreadsClone
//
//  Created by YOON on 8/8/25.
//

import Foundation

@MainActor
class FeedViewModel: ObservableObject {
    @Published var threads = [Thread]()
    
    // 초기화시 fetchThreads 메서드를 호출하여
    // 스레드 데이터가 담긴 배열과
    // 각 스레드의 사용자 데이터를 가져옵니다.
    init() {
        Task{ try? await fetchThreads() }
    }
    
    // fetchThreads 메서드는 FeedViewModel이 초기화될 때 호출되어
    // self.threads 배열에 스레드 배열을 가져오고
    // fetchUserDataForThreads 메서드를 호출하여 각 스레드에 대한 User정보를 가죠옵니다
    func fetchThreads() async throws {
        self.threads = try await ThreadService.fetchThreads()
        try await fetchUserDataForThreads()
    }

    private func fetchUserDataForThreads() async throws {
        // 각 스레드에 대해 사용자 데이터를 가져옵니다.
        // threads 배열의 각 스레드에 대해 반복문을 실행합니다.
        // 각 스레드의 ownerUid를 사용하여 UserService를 통해 Firebase에서 사용자 데이터를 가져오고
        // Model객체 User로 변환한것을 return 받습니다.
        // 이렇게 하면 각 스레드에 대한 사용자 정보가 추가됩니다.
        for i in 0..<threads.count {
            let thread = threads[i]
            let ownerUid = thread.ownerUid
            let threadUser = try await UserService.fetchUser(withUid: ownerUid)
            
            threads[i].user = threadUser
        }
    }
}
