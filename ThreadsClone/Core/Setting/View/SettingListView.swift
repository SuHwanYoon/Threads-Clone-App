//
//  SettingListView.swift
//  ThreadsClone
//
//  Created by YOON on 8/12/25.
//

import SwiftUI

struct SettingListView: View {
    var body: some View {
        // 로그아웃, 탈퇴하기, 개인정보처리방침 메뉴를 표시하는 설정 화면입니다.
        NavigationStack {
            ScrollView(showsIndicators: true){
                VStack(spacing: 20) {
                    // 로그아웃 버튼
                    Button(action: {
                        // 로그아웃 액션
                        AuthService.shared.signOut()
                        print("로그아웃")
                    }) {
                        Text("로그아웃")
                            .font(.headline)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    
                    // 탈퇴하기 버튼
                    Button(action: {
                        // 탈퇴하기 액션
                        print("탈퇴하기")
                    }) {
                        Text("탈퇴하기")
                            .font(.headline)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    
                    // 개인정보처리방침 링크
                    Link(destination: URL(string: "https://doc-hosting.flycricket.io/oneulyiilgi-gaeinjeongboceorijeongcaeg/b05dec6e-5211-4c49-a5e6-22f76564673b/privacy")!) {
                        Text("개인정보처리방침")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .padding()
                .navigationTitle("설정")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(false)
                
            }
        }
    }
}

#Preview {
    SettingListView()
}
