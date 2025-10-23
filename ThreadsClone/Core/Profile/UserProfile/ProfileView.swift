//
//  ProfileView.swift
//  ThreadsClone
//
//  Created by YOON on 5/7/25.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                ProfileHeaderView(user: user)
                
//                Button {
//                    // Follow logic
//                } label: {
//                    Text("Follow")
//                        .font(.subheadline)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.white)
//                        .frame(width: 352, height: 32)
//                        .background(Color.theme.accent)
//                        .cornerRadius(8)
//                }
                
                UserContentListView(user: user)
            }
            .padding(.horizontal)
        }
        .navigationTitle(user.username)
        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button {
//                    // More options action
//                } label: {
//                    Image(systemName: "ellipsis")
//                        .foregroundColor(Color.theme.accent)
//                }
//            }
//        }
        .background(Color.theme.background)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: dev.user)
    }
}
