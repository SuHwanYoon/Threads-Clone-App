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
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(0...10, id: \.self) { user in
                        VStack {
                            //UserCell은 사용자 정보를 표시하는 뷰입니다.
                            UserCell()
                            //HStack의 요소들 사이를 구분하는 선을 추가합니다.
                            Divider()
                                
                        }
                        // padding으로 여백을 주고 .vertical로 세로 여백을 줍니다.
                        .padding(.vertical, 4)
                    }
                }
            }
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
