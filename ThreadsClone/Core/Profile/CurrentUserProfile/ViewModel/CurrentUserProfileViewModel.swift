//
//  ProfileViewModel.swift
//  ThreadsClone
//
//  Created by YOON on 7/26/25.
//

// Combine은 Swift에서 반응형 프로그래밍을 지원하는 프레임워크입니다.
// Combine을 사용하여 비동기 이벤트를 처리하고, 데이터 흐름을 관리할 수 있습니다.
// PhotosUI는 iOS에서 사진 및 비디오 선택을 위한 사용자 인터페이스를 제공하는 프레임워크입니다.
import Foundation
import Combine
import PhotosUI
import SwiftUI


// ProfileViewModel -> CurrentUserProfileViewModel로 리팩토링
// ObservableObject 프로토콜을 채택하여 SwiftUI에서 상태 변화를 감지할
// 수 있도록 합니다.
// @Published 프로퍼티 래퍼를 사용하여 해당 속성이 변경될때 마다
// SwiftUI 뷰가 자동으로 업데이트됩니다.
class CurrentUserProfileViewModel: ObservableObject {
    // currentUser 프로퍼티의 타입이 User?로 선언되어 있는 이유는
    // 사용자가 로그인하지 않았을 때 nil이 될 수 있기 때문입니다.
    // PhotosPickerItem은 사용자가 선택한 사진이나 비디오를 나타내는 타입입니다.
    // Image는 SwiftUI에서 이미지를 나타내는 타입입니다.
    @Published var currentUser: User?
    @Published var selectedItem: PhotosPickerItem?{
        // didSet으로인해 selectedItem이 변경될 때마다
        // 즉 유저가 사진을 선택할 때마다
        // loadImage 메서드를 호출하여
        // 선택된 사진을 로드합니다.
        // Task는 비동기 컨텍스트를 생성하고
        // 컨텍스트안에서 await를 사용할 수 있게 해줍니다.
        didSet {
            Task { await loadImage() }
        }
    }
    @Published var profileImage: Image?
    // Combine을 사용하여 비동기적으로 데이터를 처리하기 위해
    // AnyCancellable을 사용하여 구독을 관리합니다.
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    // setupSubscribers 메서드는 UserService의 currentUser 프로퍼티를 구독하여
    // 현재 사용자의 정보를 업데이트합니다.
    // .sink는 Combine에서 이벤트를 구독하는 메서드로,
    // currentUser가 업데이트될 때마다 호출됩니다.
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
            print("Debug: User in view model from combine is: \(user)")
        }.store(in: &cancellables)
    }
    
    // loadImage 메서드는 사용자가 선택한 사진을 비동기적으로 로드합니다
    // loadImage 메서드는 async 메서드로 선언되어 있으며,
    // 비동기적으로 선택된 사진을 로드합니다.
    private func loadImage() async {
        // selectedItem이 nil인 경우 메서드를 종료합니다.
        guard let item = selectedItem else { return }
        // PhotosPickerItem은 선택된 사진이나 비디오를 나타내는 타입입니다.
        // loadTransferable 메서드를 사용하여 선택된 아이템에서 데이터를 로드합니다.
        // type: Data.self는 로드할 데이터의 타입을 지정합니다.
        // await를 사용하여 비동기적으로 데이터를 로드합니다.
        // 로드된 데이터는 Data 타입으로 반환됩니다.
        // try? await로 비동기작업이 실패했을 경우 nil을 반환해서
        // 앱에 영향을 주지않고 조용하게 실패를 처리
        // 만약 try라면 호출하는 곳에서는 try await loadImage()를 해야하며
        // 오류도 반드시 처리해야합니다.
        // 그렇기 때문에 어떤 오류가 어디에서 발생했는지 알수있습니다.
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        // 로드된 데이터를 UIImage로 변환합니다.
        guard let uiImage = UIImage(data: data) else { return }
        // UIImage를 SwiftUI의 Image로 변환합니다.
        self.profileImage = Image(uiImage: uiImage)
    }
    
    
}
