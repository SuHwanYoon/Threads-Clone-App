//
//  UserContentViewModel.swift
//  ThreadsClone
//
//  Created by YOON on 8/11/25.
//

import Foundation

// 외부 주입값 기반 viewModel
// 외부값에 의존하는 ViewModel로, UserContentListView에서 사용됩니다.
class UserContentListViewModel: ObservableObject {
    @Published var threads = [Thread]()
    
    let user: User
    
    init(user: User) {
        self.user = user
        Task { try? await fetchUserThreads() }
    }
    
    // ThreadService를 사용하여 특정 사용자의 스레드를 비동기적으로 가져오는 메서드입니다.
    @MainActor
    func fetchUserThreads() async throws {
        // 특정 사용자의 스레드를 최신순으로 Thread객체의 배열을 반환합니다.
        var threads : [Thread] = try await ThreadService.fetchUserThreads(uid: user.id)
        
        // 각 스레드에 대해 사용자 정보를 가져가져오고
        // 각 thread 객체 user 프로퍼티에 현재 user를 할당합니다.
        for i in 0..<threads.count {
            threads[i].user = self.user
        }
        
        // 가져온 스레드를 ViewModel의 threads 프로퍼티에 저장합니다.
        self.threads = threads
    }
    
}
