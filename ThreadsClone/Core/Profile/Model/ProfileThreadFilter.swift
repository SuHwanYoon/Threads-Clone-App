//
//  ProfileThreadFilter.swift
//  ThreadsClone
//
//  Created by YOON on 5/22/25.
//

import Foundation

// enum은 Swift에서 열거형을 정의하는 데 사용되는 키워드입니다.
// enum ProfileThreadFilter는 프로필 스레드 필터를 정의하는 열거형입니다.
// 이 열거형은 스레드와 답글을 필터링하는 데 사용됩니다.
// CaseIterable 프로토콜을 채택하여 모든 케이스를 순회할 수 있도록 합니다.
// Identifiable 프로토콜을 채택하여 각 케이스에 대한 고유한 식별자를 제공합니다.
// 각 케이스는 Int 타입의 원시값을 가지며, threads와 replies로 정의됩니다.
// 각 케이스는 스레드와 답글을 나타냅니다.
enum ProfileThreadFilter: Int, CaseIterable, Identifiable {
    // case예약어는 열거형의 각 케이스를 정의하는 데 사용됩니다.
    // rawValue는 열거형의 각 케이스에 대한 원시값을 정의하는 데 사용됩니다.
    // Int값으로 참조되는 원시값을 가지며, threads는 0, replies는 1로 정의됩니다.
    case threads  // rawvalue 0
    case replies  // rawvalue 1

    // 각 케이스에 대한 문자열을 반환하는 프로퍼티
    // self로 ProfileThreadFilter의 인스턴스를 참조합니다.
    // switch문을 사용하여 케이스에 따라 다른 문자열을 반환합니다.
    // threads 케이스를 참조하면 "Threads" 문자열을 반환하고,
    // replies 케이스를 참조하면 "Replies" 문자열을 반환합니다.
    var title: String {
        switch self {
        case .threads:
            return "나의 일기"
        case .replies:
            return "답글"
        }

    }

    // id 프로퍼티는 Identifiable 프로토콜을 준수하기 위해 필요합니다.
    // 각 케이스에 대한 고유한 식별자를 반환합니다.
    var id: Int {return self.rawValue}
    
    
}
