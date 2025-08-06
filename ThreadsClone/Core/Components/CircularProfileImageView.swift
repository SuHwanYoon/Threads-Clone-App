//
//  CircularProfileImageView.swift
//  ThreadsClone
//
//  Created by YOON on 5/17/25.
//

import SwiftUI
import Kingfisher

// ProfileImageSize는 프로필 이미지의 크기를 정의하는 열거형입니다.
// 이 열거형은 프로필 이미지의 크기를 지정하는 데 사용됩니다.
enum ProfileImageSize{
    case xxSmall // 28
    case xSmall  // 32
    case small   // 40
    case medium  // 48
    case large   // 64
    case xLarge  // 88
    
    // 크기를 반환하는 메서드
    // CGFloat 타입은 부동 소수점 숫자를 나타내는 타입입니다.
    // CGSize는 Core Graphics에서 사용되는 크기를 나타내는 구조체입니다.
    var dimensions: CGFloat {
        switch self {
            case .xxSmall: return 28
            case .xSmall: return 32
            case .small: return 40
            case .medium: return 48
            case .large: return 64
            case .xLarge: return 88
        }
    }
}

// 이 이미지의 뷰는 프로필 이미지를 원형으로 표시하는 뷰입니다.
struct CircularProfileImageView: View {
    // 사용자 정보를 받을 수 있는 변수, 기본값은 nil
    // 이 변수는 사용자 프로필 이미지를 표시하기 위해 사용되고
    // 한 사용자가 여러가지 사진을 가질 수 있기 때문에
    // var로 선언되어 있습니다.
    var user: User?
    let size: ProfileImageSize
    
    // 이 구조체의 초기화 메서드입니다.
    // user는 User 타입의 옵셔널로 선언되어 있으며,
    // size는 ProfileImageSize 열거형의 기본값을 small로 설정합니다.
    // 호출시 user값을 지정해서 전달하거나 nil로 설정할 수 있습니다.
    // ?라고 해도 = nil 이 되어있지 않으면 argument자체를 전달하지 않으면 오류가 발생합니다.
    // size는 전달하지 않으면 기본값으로 small을 사용합니다.
    // 전달하면 원하는 size를 사용할 수 있습니다.
    init(user: User?, size: ProfileImageSize = .small) {
        self.user = user
        self.size = size
    }
    
    var body: some View {
        // profileImageUrl이 있는 경우, Kingfisher를 사용하여 이미지를 비동기로 로드합니다.
        if let imageUrl = user?.profileImageUrl {
             KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: size.dimensions, height: size.dimensions)
                .clipShape(Circle())
        }else{
            // 프로필 이미지가 없을 경우 기본 회색 프로필 이미지를 표시합니다.
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimensions, height: size.dimensions)
                .foregroundColor(Color(.systemGray4))
        }
            
    }
}

// PreviewProvider는 SwiftUI에서 미리보기를 제공하는 프로토콜입니다.
// 이 구조체는 CircularProfileImageView의 미리보기를 제공합니다.
struct CircularProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        // CircularProfileImageView를 미리보기로 표시합니다.
        CircularProfileImageView(user: dev.user)
    }
}

//
//#Preview {
//    CircularProfileImageView(user: User?)
//}
