//
//  User.swift
//  ThreadsClone
//
//  Created by YOON on 7/3/25.
//

import Foundation

// User는 사용자 정보를 나타내는 구조체입니다.
// User객체는 Firebase에서 가져온 사용자 정보를 User객체로 변환하여 사용합니다.
// struct을 사용하는 이유는 주로 데이터를 묶어서 하나의 단위로 관리할때, 값의 불변셩이 필요할때, API의 응답 모델을 정의할때 사용합니다.
// Identifiable 프로토콜을 채택하여 각 사용자에 대한 고유한 식별자를 제공합니다.
// identifiable 프로토콜을 채택하면 SwiftUI에서 리스트나 그리드 등에서
// 각 사용자 항목을 식별할 수 있어서 id파라미터를 생략이 가능
// Codable 프로토콜을 채택하여 JSON 인코딩 및 디코딩을 지원합니다.
// Hashable 프로토콜을 채택하여 사용자 객체를 해시 가능한 타입으로 만들어
// 사용자 객체를 Set이나 Dictionary와 같은 컬렉션에서 사용할 수 있도록 합니다.
// var은 나중에 사용자가 변경할수 있고 선택적으로 사용하는 데이터에 사용
// profileImageUrl과 bio는 선택적 속성으로, 사용자가 프로필 이미지 URL과 바이오를 제공하지 않을 수도 있기때문에 var, Stinrg?로 선언합니다.
// bio는 사용자의 간단한 자기소개를 나타내며, 선택적으로 제공될 수 있습니다.
struct User: Identifiable, Codable, Hashable {
    let id: String
    let fullname: String
    let email: String
    let username: String
    var profileImageUrl: String?
    var bio: String?
}
