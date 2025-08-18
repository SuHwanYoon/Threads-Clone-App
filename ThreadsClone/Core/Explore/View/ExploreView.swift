//
//  ExploreView.swift
//  ThreadsClone
//
//  Created by YOON on 5/7/25.
//

import SwiftUI

struct ExploreView: View {
    // searchText는 사용자가 검색창에 입력한 텍스트를 저장하는 상태 변수입니다.
    // 이 변수를 사용하여 검색 기능을 구현할 수 있습니다.
    @State private var searchText: String = ""
    // StateObject로 ExploreViewModel을 생성합니다.
    @StateObject var viewModel = ExploreViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.users) { user in
                        // NavigationLink는 사용자가 클릭할 수 있는 링크를 생성합니다.
                        // value는 네비게이션 링크가 전달할 값을 설정합니다.
                        // 여기서는 user 객체를 전달합니다.
                        NavigationLink(value: user) {
                            VStack(spacing: 0) {
                                //UserCell은 사용자 정보를 표시하는 뷰입니다.
                                UserCell(user: user)
                                    .padding(.vertical, 8)
                                //HStack의 요소들 사이를 구분하는 선을 추가합니다.
                                Divider()
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            // 네비게이션 링크의 destination을 UserCell로 설정합니다.
            // navigationDestination은 NavigationLink의 목적지를 설정하는 데 사용됩니다.
            // 이 경우, 사용자가 UserCell을 클릭하면 ProfileView로 이동합니다.
            // User.self는 User 타입의 객체를 나타내며, navigationDestination은 해당 타입의 객체를 목적지로 설정합니다.
            // for: User.self는 User 타입의 객체를 대상으로 하는 네비게이션 링크를 설정합니다.
            .navigationDestination(for: User.self) { user in
                ProfileView(user: user)
            }
            .navigationTitle("다른 사용자들")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.theme.background)
        }
    }
}

#Preview {
    ExploreView()
}
