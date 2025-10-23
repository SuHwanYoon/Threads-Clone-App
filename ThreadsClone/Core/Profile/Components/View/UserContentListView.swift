//
//  UserContentListView.swift
//  ThreadsClone
//
//  Created by YOON on 8/3/25.
//

import SwiftUI

struct UserContentListView: View {
    @StateObject var viewModel: UserContentListViewModel
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace private var animation
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return (UIScreen.main.bounds.width) / count - 16
    }
    
    init(user: User){
        self._viewModel = StateObject(wrappedValue: UserContentListViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            HStack {
                // .allCases는 열거형의 모든 케이스를 가져오는 것입니다.
                ForEach([ProfileThreadFilter.threads]) { filter in
                    VStack {
                        // filter.title은 열거형의 각 케이스에 대한 제목을 가져옵니다.
                        // selectedFilter가 filter와 같으면 선택된 필터입니다.
                        // filter는 ProfileThreadFilter의 각 케이스입니다.
                        // 현재필터가 선택된 필터인경우 폰트 굵기 조정
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(selectedFilter == filter ? .semibold : .regular)
                            .foregroundColor(Color.theme.primaryText)
                        
                        // 선택된 필터에 따라 색상을 변경합니다.
                        if selectedFilter == filter {
                            Rectangle()
                                .foregroundColor(Color.theme.primaryText)
                                .frame(width: filterBarWidth, height: 1)
                                .matchedGeometryEffect(id: "item", in: animation)
                        } else {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: filterBarWidth, height: 1)
                        }
                    }
                    // 탭 요소에 대한 동작
                    // onTapGesture는 사용자가 탭했을 때 동작하는 것입니다.
                    // withAnimation .spring()은 애니메이션을 적용하는 것입니다.
                    // spring()은 스프링 애니메이션을 적용하는 것입니다.
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedFilter = filter
                        }
                    }
                }
            }
            // LazyVStack은 스크롤이 필요할 때만 뷰를 생성하는 것입니다.
            LazyVStack {
                ForEach(viewModel.threads) { thread in
                    ThreadCell(thread: thread)
                }
            }
        }
        .padding(.vertical, 8)
    }
}

struct UserContentListView_Previews: PreviewProvider {
    static var previews: some View {
        // UserContentListView의 미리보기를 위한 프리뷰
        // User 객체를 주입하여 미리보기 생성
        UserContentListView(user: dev.user)
    }
}