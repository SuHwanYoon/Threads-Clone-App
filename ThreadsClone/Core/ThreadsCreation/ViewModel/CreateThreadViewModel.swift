//
//  CreateThreadViewModel.swift
//  ThreadsClone
//
//  Created by YOON on 8/7/25.
//

import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class CreateThreadViewModel : ObservableObject {
    
    // 업로드 중 발생할 수 있는 오류를 정의합니다.
    enum UploadError: Error, LocalizedError {
        case timeout
        
        // 각 오류에 대한 사용자 친화적인 설명을 제공합니다.
        var errorDescription: String? {
            switch self {
            case .timeout: return "요청 시간이 초과되었습니다. 네트워크 연결을 확인하고 다시 시도해주세요."
            }
        }
    }
    
    // uploadThread 메서드는 View에서 사용자가 입력한 캡션을 사용하여 새로운 스레드를 업로드하는 기능을 제공합니다.
    func uploadThread(caption: String) async throws {
        try await withTimeout(seconds: 10.0) {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            let thread = Thread(ownerUid: uid, caption: caption, timestamp: Timestamp(), likes: 0)
            try await ThreadService.uploadThread(thread)
        }
    }
    
    // 시간 제한을 적용하는 래퍼 함수
    private func withTimeout(seconds: TimeInterval, operation: @escaping () async throws -> Void) async throws {
        try await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask { try await operation() }
            group.addTask { try await Task.sleep(for: .seconds(seconds)); throw UploadError.timeout }
            try await group.next()
            group.cancelAll()
        }
    }
}
