//
//  ThreadsTabView.swift
//  ThreadsClone
//
//  Created by YOON on 5/7/25.
//

import SwiftUI

struct ThreadsTabView: View {
    // selectedTab은 TabView의 선택된 탭을 나타내는 상태 변수입니다.
    // 초기값은 0으로 설정되어 있습니다.
    // 0은 첫 번째 탭을 의미합니다.
    @State private var selectedTab = 0
    var body: some View {
        // TabView는 여러 개의 탭을 제공하는 뷰입니다.
        // selection 매개변수는 선택된 탭을 바인딩합니다.
        // $selectedTab을 사용하여 상태 변수를 바인딩합니다.
        // TabView 안에 여러 개의 탭을 추가할 수 있습니다.
        TabView(selection: $selectedTab) {
            FeedView()
                // tabItem은 각 탭의 아이콘과 레이블을 설정합니다.
                .tabItem {
                    // Image(systemName: "house")는 SF Symbols에서 house 아이콘을 사용합니다.
                    // selectedTab이 0일 때는 house.fill 아이콘을 사용하고,
                    // 그렇지 않으면 house 아이콘을 사용합니다.
                    // environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)는 아이콘의 변형을 설정합니다.
                    // selectedTab이 0일 때는 아이콘을 채운 형태로 표시하고,
                    // 그렇지 않으면 일반 형태로 표시합니다.
                    // onAppear는 뷰가 나타날 때 호출되는 메서드입니다.
                    // selectedTab을 0으로 설정하여 첫 번째 탭을 선택합니다.
                    // tag는 각 탭을 식별하는 데 사용되는 값입니다.
                    // 각 탭에 대해 고유한 태그 값을 설정합니다.
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .environment(
                            \.symbolVariants,
                            selectedTab == 0 ? .fill : .none
                        )
                }
                .onAppear { selectedTab = 0 }
                .tag(0)

            // 검색 탭
            // 검색탭은 상태변수에 따라 채우기 안채우기를 조절하지않음
            ExploreView()
                .tabItem {
                    Image(
                        systemName: "magnifyingglass"
                    )
                }
                .onAppear { selectedTab = 1 }
                .tag(1)
            // 업로드 탭
            // 업로드탭은 상태변수에 따라 채우기 안채우기를 조절하지않음
            CreateThreadsView()
                .tabItem {
                    Image(systemName: "plus")
                }
                .onAppear { selectedTab = 2 }
                .tag(2)

            ActivityView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "heart.fill" : "heart")
                        .environment(
                            \.symbolVariants,
                            selectedTab == 3 ? .fill : .none
                        )
                }
                .onAppear { selectedTab = 3 }
                .tag(3)

            ProfileView()
                .tabItem {
                    Image(
                        systemName: selectedTab == 4 ? "person.fill" : "person"
                    )
                    .environment(
                        \.symbolVariants,
                        selectedTab == 4 ? .fill : .none
                    )
                }
                .onAppear { selectedTab = 4 }
                .tag(4)
        }
        .tint(.black)
    }
}

#Preview {
    ThreadsTabView()
}
