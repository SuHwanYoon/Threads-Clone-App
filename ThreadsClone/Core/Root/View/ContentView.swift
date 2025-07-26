//
//  ContentView.swift
//  ThreadsClone
//
//  Created by YOON on 5/5/25.
//

import SwiftUI

// contentView는 앱의 시작점으로, 로그인 상태에 따라 다른 뷰를 표시합니다.
// contentView는 userSession의 상태에 따라 ThreadsTabView 또는 LoginView를 표시합니다.
struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        // 앱의 시작점으로, 로그인 상태에 따라 다른 뷰를 표시합니다.
        // Group는 뷰를 그룹화하여 조건부로 표시할 수 있게 합니다.
        // viewModel.userSession이 nil이 아닌 경우 ThreadsTabView를 표시하고,
        // TheadsTabView는 login, signup시에 이동하는 탭 뷰입니다.
        // nil인 경우 LoginView를 표시합니다.
        Group{
            if viewModel.userSession != nil {
                ThreadsTabView()
            } else {
                LoginView()
            }
            
        }
    }
}


#Preview {
    ContentView()
}
