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
    // showCreateThreadsView는 CreateThreadsView를 모달로 표시할지 여부를 나타내는 상태 변수입니다.
    // 초기값은 false로 설정되어 있습니다.
    // 이 변수는 사용자가 업로드 탭을 클릭했을 때 true로 설정되어 CreateThreadsView가 표시됩니다.
    @State private var showCreateThreadsView = false
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
            // 업로드 탭 + 아이콘
            // 기본적으로 TapView의 각탭은 반드시 어떤 뷰를 표시해야 합니다.
            // 빈내용을 표시하고 싶어도 최소한의 뷰는 필요합니다.
            // 빈텍스트를 사용하고 아래에서  CreateThreadsView를 모달로 대신 표시.
            Text("")
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

//            ProfileView()
            // ProfileView대신 CurrentUserProfileView를 사용
              CurrentUserProfileView()
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
        // .onChange(of: selectedTab)는 selectedTab이 변경될 때마다 실행되는 이벤트 핸들러
        // oldValue는 변경전 탭의 인덱스 newValue는 변경후에 탭 인덱스입니다.
        // 사용자가 업로드 탭(+)을 탭하면 selectedTab이 2가 됨
        // 이때 showCreateThreadsView = true가 되어 CreateThreadsView가 모달로 표시됨
        // 다른 탭으로 이동하면 showCreateThreadsView = false가 되어 모달이 표시되지 않음
        .onChange(of: selectedTab) { oldValue, newValue in
            // 사용자가 업로드 탭을 선택했을 때
            // selectedTab == 2 -> true로 설정되어 showCreateThreadsView 상태변수에 할당
            showCreateThreadsView = selectedTab == 2
        }
        // .sheet는 모달 시트(아래에서 위로올라오는 UI)를표시하고 아래로 스와이프하여 닫을 수 있습니다.
        // isPresented는 시트가 어떻게 표시될지 여부를 결정하는 바인딩이고
        // 업로드 + (selectedTab == 2) 아이콘을 클릭하면 해당 뷰 표시
        // $showCreateThreadsView는 CreateThreadsView를 모달로 표시할지 여부를 결정하는 바인딩입니다.
        // 이 바인딩은 상태 변수(true,false)에 연결되어 있습니다.
        // isPresented는 모달 시트가 표시될 때 true로 설정되고,
        // onDismiss는 시트가 닫힐 때 실행되는 동작
        // 사용자가 시트를 닫으면 selectedTab을 0으로 설정되며 첫 번째 탭(홈탭)을 표시.
        // content는 모달 시트에 표시될 실제 뷰이고 createThreadsView()를 모달로 표시
        .sheet(
            isPresented: $showCreateThreadsView,
            onDismiss: { selectedTab = 0 },
            content: { CreateThreadsView() }
        )
        // .tint는 하단 아이콘들의 색상을 설정합니다.
        .tint(.black)
    }
}

#Preview {
    ThreadsTabView()
}
