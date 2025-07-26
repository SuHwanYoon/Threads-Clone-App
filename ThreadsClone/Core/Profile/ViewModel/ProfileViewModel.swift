//
//  ProfileViewModel.swift
//  ThreadsClone
//
//  Created by YOON on 7/26/25.
//

import Foundation
// Combine은 Swift에서 반응형 프로그래밍을 지원하는 프레임워크입니다.
import Combine

// ProfileViewModel은 프로필 화면에서 사용자 정보를 관리하는 ViewModel입니다.
// ObservableObject 프로토콜을 채택하여 SwiftUI에서 상태 변화를 감지할
// 수 있도록 합니다.
class ProfileViewModel: ObservableObject {
     @Published var currentUser: User?
    // Combine을 사용하여 비동기적으로 데이터를 처리하기 위해
    // AnyCancellable을 사용하여 구독을 관리합니다.
     private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    // setupSubscribers 메서드는 UserService의 currentUser 프로퍼티를 구독하여
    // 현재 사용자의 정보를 업데이트합니다.
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
            print("Debug: User in view model from combine is: \(user)")
        }.store(in: &cancellables)
    }
}
