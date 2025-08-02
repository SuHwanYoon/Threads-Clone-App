//
//  ProfileViewModel.swift
//  ThreadsClone
//
//  Created by YOON on 7/26/25.
//

import Foundation
// Combine은 Swift에서 반응형 프로그래밍을 지원하는 프레임워크입니다.
import Combine

// ProfileViewModel -> CurrentUserProfileViewModel로 리팩토링
// ObservableObject 프로토콜을 채택하여 SwiftUI에서 상태 변화를 감지할
// 수 있도록 합니다.
// @Published 프로퍼티 래퍼를 사용하여 currentUser가 변경될 때마다
// SwiftUI 뷰가 자동으로 업데이트됩니다.
class CurrentUserProfileViewModel: ObservableObject {
    // currentUser 프로퍼티의 타입이 User?로 선언되어 있는 이유는
    // 사용자가 로그인하지 않았을 때 nil이 될 수 있기 때문입니다.
     @Published var currentUser: User?
    // Combine을 사용하여 비동기적으로 데이터를 처리하기 위해
    // AnyCancellable을 사용하여 구독을 관리합니다.
     private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    // setupSubscribers 메서드는 UserService의 currentUser 프로퍼티를 구독하여
    // 현재 사용자의 정보를 업데이트합니다.
    // .sink는 Combine에서 이벤트를 구독하는 메서드로,
    // currentUser가 업데이트될 때마다 호출됩니다.
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
            print("Debug: User in view model from combine is: \(user)")
        }.store(in: &cancellables)
    }
}
