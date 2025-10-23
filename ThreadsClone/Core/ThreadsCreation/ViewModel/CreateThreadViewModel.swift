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
    
    // uploadThread 메서드는 View에서 사용자가 입력한 캡션을 사용하여 새로운 스레드를 업로드하는 기능을 제공합니다.
    func uploadThread(caption: String) async throws {
        try await withTimeout(seconds: 15.0) {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            let thread = Thread(ownerUid: uid, caption: caption, timestamp: Timestamp(), likes: 0)
            try await ThreadService.uploadThread(thread)
        }
    }
}
