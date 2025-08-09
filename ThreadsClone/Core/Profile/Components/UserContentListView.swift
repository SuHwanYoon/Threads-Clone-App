//
//  UserContentListView.swift
//  ThreadsClone
//
//  Created by YOON on 8/3/25.
//

import SwiftUI

// UserContentListView는 프로필의 콘텐츠 목록을 표시하는 뷰입니다.
// 이 뷰는 프로필의 스레드, 좋아요, 북마크 등의 콘텐츠를 표시합니다.
// ProfileView, CurrentUserProfileView에서 사용됩니다.
struct UserContentListView: View {
    // selectedFilter는 현재 선택된 필터를 나타냅니다.
    // Threads탭이 선택되었을때의 상태를 나타냅니다.
    // @Namespace는 뷰간의 애니메이션 전환을 위한 프로퍼티 래퍼
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace private var animation
    
    // filterBarWidth는 필터 바의 너비를 계산하는 프로퍼티입니다.
    // CGFloat는 부동 소수점 숫자를 나타내는 타입입니다.
    // count는 ProfileThreadFilter의 모든 케이스의 개수를 가져옵니다.
    // UIScreen.main.bounds.width는 화면의 너비를 가져옵니다.
    // count - 16은 필터 바의 너비를 계산하는 것입니다.
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return (UIScreen.main.bounds.width) / count - 16
    }
    var body: some View {
        VStack {
            HStack {
                // .allCases는 열거형의 모든 케이스를 가져오는 것입니다.
                ForEach(ProfileThreadFilter.allCases) { filter in
                    VStack {
                        // filter.title은 열거형의 각 케이스에 대한 제목을 가져옵니다.
                        // selectedFilter가 filter와 같으면 선택된 필터입니다.
                        // filter는 ProfileThreadFilter의 각 케이스입니다.
                        // 현재필터가 선택된 필터인경우 폰트 굵기 조정
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(
                                selectedFilter == filter
                                ? .semibold : .regular
                            )
                        
                        // 선택된 필터에 따라 색상을 변경합니다.
                        if selectedFilter == filter {
                            Rectangle()
                                .foregroundColor(.black)
                                .frame(width: filterBarWidth, height: 1)
                                .matchedGeometryEffect(
                                    id: "item",
                                    in: animation
                                )
                            
                        } else {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: filterBarWidth, height: 2)
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
                ForEach(0...10, id: \.self) { thread in
//                    ThreadCell(thread: nil)
                }
            }
        }
        .padding(.vertical, 8)

    }
}

#Preview {
    UserContentListView()
}
