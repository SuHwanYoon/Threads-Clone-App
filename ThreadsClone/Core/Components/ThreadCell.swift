//
//  ThreadCell.swift
//  ThreadsClone
//
//  Created by YOON on 5/15/25.
//

import SwiftUI

struct ThreadCell: View {
    // ThreadCell에 Thread 모델을 개체 주입
    let thread: Thread
    
    var body: some View {
        VStack {
            // HStack는 수평으로 배치하는 뷰
            HStack(alignment: .top, spacing: 12) {
                // scaledToFill은 이미지를 비율에 맞춰서 채우는 것
                // frame은 이미지의 크기를 지정하는 것
                // clipShape은 이미지를 자르는 것
                // Circle()은 원형으로 자르는 것
                CircularProfileImageView(user: thread.user, size: .small)
                    
                    
                // .leading은 왼쪽 정렬
                // .top은 위쪽 정렬
                // .trailing은 오른쪽 정렬
                // .bottom은 아래쪽 정렬
                // .center는 가운데 정렬
                //spacing값의 의미는  HStack의 요소들 사이의 간격
                VStack(alignment: .leading, spacing: 4) {

                    // 프로필 이름
                    HStack {
                        Text(thread.user?.username ?? "")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        // Spacer()는 빈 공간을 채우는 것
                        // Spacer()로 인해 HStack의 요소들 사이에 빈 공간이 생김
                        Spacer()
                        // 프로필 사진 아래에 위치하는 시간
                        Text(thread.timestamp.timestampString())
                            .font(.caption)
                            .foregroundColor(Color(.systemGray3))

                        // ellipsis 버튼은 점 3개 버튼
                        Button {
                            // 버튼 클릭 시 동작
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(Color(.darkGray))
                        }

                    }

                    Text(thread.caption)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)

                    // 가로 버튼 스택
                    // heart, comment, share, send 버튼
                    HStack(spacing: 16) {
                        Button {

                        } label: {
                            Image(systemName: "heart")
                        }

                        Button {

                        } label: {
                            Image(systemName: "bubble.left")
                        }

                        Button {

                        } label: {
                            Image(systemName: "arrow.rectanglepath")
                        }

                        Button {

                        } label: {
                            Image(systemName: "paperplane")
                        }

                    }
                    .foregroundColor(Color(.black))
                    // vertical은 위쪽요소에서 세로 방향으로 여백을 주는 것
                    .padding(.vertical, 8)

                }
            }
            // Divider()는 구분선을 만드는 것
            // 구분선의 색상은 시스템 회색으로 설정
            Divider()
                
        }
        // padding으로 전체 VStack에 여백을 줌
        .padding()
    }
}

// PreviewProvider로 ThreadCell의 미리보기를 제공합니다.
struct ThreadCell_Previews: PreviewProvider {
    static var previews: some View {
        ThreadCell(thread: dev.thread)
    }
}

//#Preview {
//    ThreadCell()
//}

