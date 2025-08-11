//
//  FeedView.swift
//  ThreadsClone
//
//  Created by YOON on 5/7/25.
//

import SwiftUI

struct FeedView: View {
    // FeedViewModel은 Feed 화면에서 사용되는 thread를 가져옮니다
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        // NavigationStack 앱의 네비게이션의 상태를 관리하는 구조체
        // 앱의 네이게이션 상태란 사용자가 어떤 화면을 보고 있는지를 나타내는 상태입니다.
        // NavigationStack을 사용하면 앱의 네비게이션 상태를 쉽게 관리할 수 있습니다.
        // LazyVStack 수직으로 스크롤 가능한 뷰를 생성하는 구조체
        // LazyVStack을 사용하는 이유는 스크롤이 필요할 때만 뷰를 생성하여 성능을 최적화하기 위함입니다.
        NavigationStack {
            // ScrollView는 앱의 스크롤 가능한 뷰를 생성하는 구조체
            // showIndicators 스크롤바의 표시 여부를 결정하는 속성
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    // 0에서 10 까지의 범위 즉 11번 반복
                    // id: \.self 각 반복마다 고유한 ID를 생성하는 속성
                    // self는 각 반복의 인덱스를 나타냅니다.
                    // 여기서의 viewModel.threads은 view에서 수정하는 부분이 아니기때문에 $로 바인딩하지 않습니다.
                    ForEach(viewModel.threads) { threadIndex in
                        // 만들어 놓은 ThreadCell 뷰를 반복적으로 생성
                        ThreadCell(thread: threadIndex)
                    }
                }
            }
            .refreshable {
                // 사용자가 스크롤을 내려 새로고침을 할 때 실행되는 코드
                // 실제로는 서버에서 데이터를 가져오는 등의 작업을 수행할 수 있습니다.
                Task { try await viewModel.fetchThreads() }
//                print("새로고침 완료")
            }
            .navigationTitle("Threads")  // 네비게이션 바의 제목을 설정
            .navigationBarTitleDisplayMode(.inline)  // 네비게이션 바의 제목 표시 모드를 설정
        }
        .toolbar {
            // 툴바에 추가할 버튼을 설정
            ToolbarItem(placement: .navigationBarTrailing) {
                // 오른쪽 툴바에 추가할 버튼을 설정
                Button {

                } label: {
                    // 버튼의 레이블을 설정
                    Image(systemName: "arrow.counterclockwise")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        // FeedView를 미리보기로 설정
        // NavigationStack을 사용하여 FeedView를 감싸줍니다.
        // 이렇게 하면 FeedView가 네비게이션 스택의 일부로 표시됩니다.
        FeedView()
    }
}
