//
//  Thread.swift
//  ThreadsClone
//
//  Created by YOON on 8/7/25.
//

import Firebase
import FirebaseFirestore

// Thread는 스레드(게시물)의 정보를 나타내는 구조체입니다.
// identifiable 프로토콜을 채택하여 각 스레드에 대한 고유한 식별자를 제공합니다.
// Identifiable 프로토콜을 사용할경우 반드시 id 라는 이름으로 프로퍼티를 구현해야 합니다.
// Codable 프로토콜을 채택하여 JSON 인코딩 및 디코딩을 지원합니다.
struct Thread: Identifiable, Codable {
    // @DocumentID 프로퍼티 래퍼를 사용하여 Firestore에서 문서 ID를 자동으로 할당받습니다.
    @DocumentID var threadId: String?
    let ownerUid: String // 스레드를 작성한 사용자의 UID
    let caption: String // 스레드의 내용
    let timestamp: Timestamp // Timestamp는 Firebase에서 제공하는 날짜 및 시간 정보를 나타냅니다.
    var likes: Int
    
    // identifiable 프로토콜을 준수하기 위해 id 프로퍼티를 구현합니다.
    // computed property로 threadId가 nil인 경우 새로운 UUID를 생성하여 반환합니다.
    var id: String {
        // 스레드 ID가 nil인 경우  새로운 UUID를 생성하여 반환합니다.
        return threadId ?? NSUUID().uuidString
    }
    
    var user: User? // 스레드를 작성한 사용자의 정보를 포함하는 선택적 속성입니다.
}
