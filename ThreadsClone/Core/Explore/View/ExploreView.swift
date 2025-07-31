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
                        NavigationLink(value: user, label: {
                            VStack {
                                //UserCell은 사용자 정보를 표시하는 뷰입니다.
                                UserCell(user: user)
                                //HStack의 요소들 사이를 구분하는 선을 추가합니다.
                                Divider()
                                    
                            }
                        })
                        // padding으로 여백을 주고 .vertical로 세로 여백을 줍니다.
                        .padding(.vertical, 4)
                    }
                }
            }
            // 네비게이션 링크의 destination을 UserCell로 설정합니다.
            // navigationDestination은 NavigationLink의 목적지를 설정하는 데 사용됩니다.
            // 이 경우, 사용자가 UserCell을 클릭하면 ProfileView로 이동합니다.
            // User.self는 User 타입의 객체를 나타내며, navigationDestination은 해당 타입의 객체를 목적지로 설정합니다.
            // for: User.self는 User 타입의 객체를 대상으로 하는 네비게이션 링크를 설정합니다.
            .navigationDestination(for: User.self, destination: { user in
                ProfileView()
            })
            // searchable modifier를 사용하여 검색 기능을 추가합니다.
            // searchable modifier는 네비게이션바 아래에 검색창을 추가.
            // 사용자가 검색창에 입력한 텍스트는 searchText 변수에 저장됩니다.
            // prompt는 검색창에 표시되는 안내 문구입니다.
            .navigationTitle("Search")
            .searchable(text: $searchText, prompt: "Search")

        }
    }
}

#Preview {
    ExploreView()
}
