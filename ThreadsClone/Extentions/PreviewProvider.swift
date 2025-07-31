//
//  PreviewProvider.swift
//  ThreadsClone
//
//  Created by YOON on 7/31/25.
//

import SwiftUI
extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}


class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    // User 객체를 생성하여 미리보기에서 사용할 수 있도록 합니다.
    // NSUUID().uuidString을 사용하여 고유한 ID를 생성합니다.
    let user = User(id: NSUUID().uuidString, fullname: "Yoon Suhwan", email: "yoon@gmail.com", username: "yoon_suhwan")

}

//
//#Preview {
//    PreviewProvider()
//}
