//
//  Timestamp.swift
//  ThreadsClone
//
//  Created by YOON on 8/11/25.
//

import Foundation
import FirebaseCore

// Timestamp는 Firebase에서 제공하는 날짜 및 시간 정보를 나타내는 구조체입니다.
// Timestamp는 Date와 유사하지만, Firebase Firestore에서 사용하는 날짜 및 시간 형식을
// 지원합니다.
extension Timestamp {
    
    func timestampString() -> String {
        // DateComponentsFormatter를 사용하여 Timestamp를 문자열로 변환합니다.
        // DateComponentsFormatter는 날짜 및 시간의 차이를 나타내는 문자열을 생성하는
        // 데이트 컴포넌트 포매터입니다.
        // allowedUnits는 표시할 단위를 설정합니다.
        // 여기서는 초, 분, 시간, 일, 주 단위를 허용합니다.
        // maximumUnitCount는 최대 단위 개수를 설정합니다.
        // 여기서는 1개 단위만 표시합니다.
        // unitsStyle은 문자열의 스타일을 설정합니다.
        // 여기서는 약어 스타일을 사용합니다.
        // string(from:to:) 메서드를 사용하여 현재 날짜와 Timestamp 사이의 차이를 문자열로 변환합니다.
        // dateValue() 메서드는 Firebase의 Timestamp를 Swfit의 Date로 변환합니다.
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: self.dateValue(), to: Date()) ?? ""
        
    }
}
