//
//  ContentViewModel.swift
//  ThreadsClone
//
//  Created by YOON on 7/1/25.
//

// Combine는 Apple의 프레임워크로, 비동기 이벤트를 처리하고 데이터 흐름을 관리하는 데 사용됩니다.
import Foundation
import Combine
import Firebase
import FirebaseAuth

// ObervableObject는 SwiftUI에서 상태를 관리하기 위해 사용되는 프로토콜입니다.
// 이 프로토콜을 채택한 클래스는 SwiftUI 뷰에서 상태가 변경될 때 자동으로 업데이트됩니다.
class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    // Set<AnyCancellable>는 Combine에서 제공하는 타입으로, 구독을 저장하고 관리하는 데 사용됩니다.
    private var cancellables = Set<AnyCancellable>()
    
    init () {
        setupSubscribers()
    }
    
    
    // 이 메서드는 AuthService.shared.$userSession를 구독하여 userSession의 변경 사항을 감지합니다.
    // 변경 사항을 감지하면, userSession 프로퍼티를 업데이트합니다.
    // 이 메서드는 AuthService의 userSession 프로퍼티가 변경될 때마다 호출됩니다.
    // sinks는 Combine 프레임워크에서 제공하는 메서드로, 데이터 변화감시
    // store(in:) 메서드는 구독을 Set<AnyCancellable>에 저장하여, 데이터 변화상태를 저장
    private func setupSubscribers(){
        AuthService.shared.$userSession
            .sink { [weak self] userSession in
                self?.userSession = userSession
            }.store(in: &cancellables)
    }
    
}

