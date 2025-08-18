import SwiftUI
import PhotosUI

class EditProfileViewModel: ObservableObject {
    
    // PhotosPickerItem은 사용자가 선택한 사진이나 비디오를 나타내는 타입입니다.
    // Image는 SwiftUI에서 이미지를 나타내는 타입입니다.
    
    @Published var selectedItem: PhotosPickerItem?{
        // didSet으로인해 selectedItem이 변경될 때마다
        // 즉 유저가 사진을 선택할 때마다
        // loadImage 메서드를 호출하여
        // 선택된 사진을 로드합니다.
        // didSet은 동기 프로퍼티 옵저버이기때문에
        // loadImage 메서드를 비동기로 호출하기 위해
        // Task를 사용합니다.
        // Task는 비동기 컨텍스트를 생성하고
        // 컨텍스트안에서 await를 사용할 수 있게 해줍니다.
        didSet {
            Task { await loadImage() }
        }
    }
    @Published var profileImage: Image?
    // bio를 Published 프로퍼티로 선언하여 View와 바인딩합니다.
    @Published var bio = ""
    
    // uiImage UIKit의 요소이며 실제 이미지 데이터를 가짐
    // Firebase Storage와 같은 외부 스토리지에 업로드하려면 반드시 UIImage 타입이어야 합니다.
    // SwiftUI의 Image 타입은 UIImage나 이름기반으로 이미지를 표시하는 데 사용되지만,
    // Firebase Storage에 이미지를 업로드하려면 UIImage 타입이 필요합니다.
    private var uiImage: UIImage?
    // 현재 사용자 정보를 저장하기 위한 프로퍼티입니다.
    private let user: User
    
    // user 객체를 받아 viewModel을 초기화합니다.
    init(user: User) {
        self.user = user
        // 사용자의 기존 bio 정보를 bio 프로퍼티에 할당합니다.
        if let bio = user.bio {
            self.bio = bio
        }
    }
    
    // updateUserData 메서드는 사용자의 프로필 데이터를 업데이트하는 함수들의 묶음
    // 현재는 updateProfileImage 메서드만 포함되어 있지만,
    // 추후에 다른 프로필 관련 업데이트 메서드를 추가할 수 있습니다.
    func updateUserData() async throws {
        // 프로필 이미지와 바이오 정보를 순차적으로 업데이트합니다.
        try await updateProfileImage()
        try await updateBio()
    }
    
    // loadImage 메서드는 사용자가 선택한 사진을 비동기적으로 로드합니다
    // loadImage 메서드는 async 메서드로 선언되어 있으며,
    // 비동기적으로 선택된 사진을 로드합니다.
    @MainActor
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
        // Firebase Storage에 업로드하기 위해 UIKit의 uiImage 프로퍼티에 저장합니다.
        self.uiImage = uiImage
        // View에 보기기 위해 UIImage를 SwiftUI의 Image로 변환합니다.
        self.profileImage = Image(uiImage: uiImage)
    }
    
    // updateProfileImage 메서드는 선택된 프로필 이미지를 업로드합니다.
    // 이 메서드는 비동기적으로 작동하며, 선택된 이미지가 있는 경우에만 실행됩니다.
    private func updateProfileImage() async throws {
        // uiImage 프로퍼티와 같은 nil일수 있는 옵셔널 프로퍼티를 사용할 때는
        // guard let 구문을 사용하여 uiImage가 nil이면 return으로 함수를 종료합니다.
        guard let image = self.uiImage else { return }
        guard let imageUrl = try await ImageUploader.uploadImage(_image: image) else {return}
        try await UserService.shared.updateUserProfileImage(withImageUrl: imageUrl)
    }
    
    // MARK: - Bio Update
    
    // 이 함수는 사용자의 바이오 정보를 업데이트합니다.
    private func updateBio() async throws {
        // bio가 비어있지 않고, 기존의 bio와 다른 경우에만 업데이트를 수행합니다.
        if !bio.isEmpty && user.bio != bio {
            try await UserService.shared.updateUserBio(bio)
        }
    }
}
