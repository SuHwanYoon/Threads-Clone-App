//
//  ProfileView.swift
//  ThreadsClone
//
//  Created by YOON on 5/7/25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
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
        NavigationStack{
            // showsIndicators: false는 스크롤바를 숨깁니다.
            // showsIndicators: true는 스크롤바를 표시합니다.
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    // Vstack + Text + Text를 포함하는 HStack
                    // 왼쪽 요소들은.top 이 있어도 없어도 위치변화 없음
                    // CircularProfileImageView는 높이가 1줄로 구성되어 있어 .top으로 인해 위로 올라감
                    HStack(alignment: .top) {
                        // .leading은 왼쪽 정렬을 의미합니다.
                        // [프로필, 아이디] , 직업, 팔로워 수를 포함하는 VStack
                        // Profile name과 나머지 요소 사이의 간격을 12로 설정합니다.
                        VStack(alignment: .leading, spacing: 12) {
                            // Yoon Suhwan과 yoon_suhwan 사이의 간격을 4로 설정합니다.
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Yoon SuHwan")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                
                                Text("yoon_suhwan")
                                    .font(.subheadline)
                                
                            }
                            
                            Text("Developer")
                                .font(.footnote)
                            
                            Text("2 followers")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                        }
                        
                        // Spacer()는 빈 공간을 채우는 것
                        // Spacer()로 인해 HStack의 요소들 사이에 빈 공간이 생김
                        Spacer()
                        
                        CircularProfileImageView()
                        
                    }
                    // follow 버튼
                    Button {
                        // 버튼 클릭 시 동작
                    } label: {
                        Text("Follow")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 352, height: 32)
                            .background(.black)
                            .cornerRadius(8)
                    }
                    
                    // user content list view
                    // UserContentListView는 사용자 콘텐츠 목록을 표시하는 뷰입니다.
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
                                ThreadCell()
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
                
            }
            .toolbar{
                // ToolbarItem은 툴바에 아이템을 추가하는 것입니다.
                // placement는 아이템이 툴바의 어느 위치에 배치될지를 정의합니다.
                // topBarTrailing은 툴바의 오른쪽 상단에 배치됩니다.
                // 우측 상단에 로그아웃되는 메뉴 버튼을 추가합니다.
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        // sign out image button
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            
                            
                        
                        
                    }
                    
                    
                }
            }
            // showsIndicators속성의 기본값은 true입니다.
            // .padding(.horizontal)은 좌우 여백을 주는 것
            .padding(.horizontal)
            
        }
    }
}

#Preview {
    ProfileView()
}
