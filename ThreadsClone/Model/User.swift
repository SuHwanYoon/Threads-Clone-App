//
//  User.swift
//  ThreadsClone
//
//  Created by YOON on 7/3/25.
//

import Foundation

// User는 사용자 정보를 나타내는 구조체입니다.
// struct을 사용하는 이유는 값 타입으로, 사용자 정보를 간단하게 표현하고,
// 불변성을 유지하기 위해서입니다.
// Identifiable 프로토콜을 채택하여 각 사용자에 대한 고유한 식별자를 제공합니다.
// identifiable 프로토콜을 채택하면 SwiftUI에서 리스트나 그리드 등에서
// 각 사용자 항목을 식별할 수 있어서 id파라미터를 생략이 가능
// Codable 프로토콜을 채택하여 JSON 인코딩 및 디코딩을 지원합니다.
// var은 나중에 사용자가 변경할수 있고 선택적으로 사용하는 데이터에 사용
struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    let username: String
    var profileImageUrl: String?
    var bio: String?
}
