//
//  ProfileViewModel.swift
//  ThreadsClone
//
//  Created by YOON on 7/26/25.
//

// Combine은 Swift에서 반응형 프로그래밍을 지원하는 프레임워크입니다.
// Combine을 사용하여 비동기 이벤트를 처리하고, 데이터 흐름을 관리할 수 있습니다.
// PhotosUI는 iOS에서 사진 및 비디오 선택을 위한 사용자 인터페이스를 제공하는 프레임워크입니다.
import Foundation
import Combine
import PhotosUI
import SwiftUI


// ProfileViewModel -> CurrentUserProfileViewModel로 리팩토링
// ObservableObject 프로토콜을 채택하여 SwiftUI에서 상태 변화를 감지할
// 수 있도록 합니다.
// @Published 프로퍼티 래퍼를 사용하여 해당 속성이 변경될때 마다
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
            guard let self = self else { return }
            self.currentUser = user
            
            // 신규 가입 직후 또는 데이터 로드 실패 시 currentUser가 nil이거나
            // fullname이 비어있는 상태일 수 있습니다.
            // 이 경우, UserService에서 최신 사용자 정보를 다시 가져오도록 시도합니다.
            // (user?.fullname ?? "").isEmpty는 user가 nil일 경우 ""를 반환하여 안전하게 체크합니다.
            if self.currentUser == nil || (self.currentUser?.fullname ?? "").isEmpty {
                print("Debug: Current user is nil or has incomplete data (fullname empty), attempting to refetch...")
                Task {
                    // UserService에 있는 fetchCurrentUser 함수를 호출하여 Firestore에서 최신 데이터를 다시 가져옵니다.
                    try? await UserService.shared.fetchCurrentUser()
                }
            }
        }.store(in: &cancellables)
    }
    

    
    
}
