//
//  AuthError.swift
//  ThreadsClone
//
//  Created by YOON on 7/29/25.
//

import Foundation

enum AuthError: Error {
    case loginFailed
    
    var description: String {
        switch self {
        case .loginFailed: return "이메일 또는 비밀번호가 올바르지 않습니다. 다시 확인해주세요."
        }
    }
}