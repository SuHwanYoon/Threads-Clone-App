//
//  ThreadService.swift
//  ThreadsClone
//
//  Created by YOON on 8/7/25.
//

import Foundation
import Firebase
import FirebaseFirestore

// ThreadService는 스레드 관련 작업을 처리하는 서비스입니다.
struct ThreadService {
    // uploadThread 메서드는 새로운 스레드를 Firestore에 업로드하는 기능을 제공합니다.
    // 외부파라미터는 _ 로 생략하여 메서드를 호출할때 파라미터이름 명시없이 uploadThread(parapaterName)의 방식으로 사용가능합니다.
    // 만약 _로 생략하지 않으면, uploadThread(thread:)와 같이 내부파라미터 이름을 명시해서 사용해야 합니다.
    // 이 메서드는 비동기적으로 작동하며, 스레드 객체를 매개변수로 받아 Firestore에 저장합니다.
    // Firestore.Encoder()를 사용하여 스레드 객체를 Firestore에 저장할 수 있는 데이터 형식으로 인코 딩합니다.
    // Firestore.firestore().collection("threads").addDocument(data:)를 사용하여 Firestore 에 스레드 데이터를 추가합니다.
    static func uploadThread(_ thread: Thread) async throws{
        guard let threadData = try? Firestore.Encoder().encode(thread) else { return }
        try await Firestore.firestore().collection("threads").addDocument(data: threadData)
    }
    
    // fetchThreads 메서드는 Firestore에서 스레드 데이터를 가져오는 기능을 제공합니다.
    static func fetchThreads() async throws -> [Thread] {
        // Firestore에서 "threads" 컬렉션을 가져오고, "timestamp" 필드를 기준으로 내림차순으로 정렬합니다.
        // descending이 ture이면 내림차순으로 정렬됩니다.
        // descending이 false이면 오름차순으로 정렬됩니다.
        // getDocuments() 메서드를 사용하여 스레드 데이터를 가져옵니다.
        let snapshot = try await Firestore.firestore().collection("threads")
                        .order(by: "timestamp", descending: true).getDocuments()
        
        
        // snapshot.documents는 Firestore에서 가져온 문서들의 배열입니다.
        // compactMap을 사용하여 각 문서를 Thread 객체가 담긴 배열로 변환합니다.
        // try?를 사용하여 변환이 실패할 경우 nil을 반환하고, compactMap을 사용하여 Thread타입객체로 변화하지 못해 nil로 반환된 값을 제외합니다.
        // 따라서 최종적으로 [Thread] 타입의 배열을 반환합니다.
        return snapshot.documents.compactMap { try? $0.data(as: Thread.self) }
    }
}

