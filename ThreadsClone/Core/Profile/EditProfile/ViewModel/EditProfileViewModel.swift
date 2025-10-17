import Foundation
import SwiftUI
import _PhotosUI_SwiftUI
import Combine
class EditProfileViewModel: ObservableObject {
    
    // 업로드 중 발생할 수 있는 오류를 정의합니다.
    enum UploadError: Error, LocalizedError { // .timeout 케이스를 제거합니다.
        case imageUploadFailed
        
        // 각 오류에 대한 사용자 친화적인 설명을 제공합니다.
        var errorDescription: String? {
            switch self {
            case .imageUploadFailed: return "이미지 업로드에 실패했습니다. 네트워크 연결을 확인하고 다시 시도해주세요."
            }
        }
    }
    @Published var selectedItem: PhotosPickerItem? {
        didSet {
            Task { await loadImage() }
        }
    }
    @Published var profileImage: Image?
    @Published var bio = ""
    @Published var errorMessage: String?
    
    private var uiImage: UIImage?
    private let user: User
    
    init(user: User) {
        self.user = user
        if let bio = user.bio {
            self.bio = bio
        }
    }
    
    func updateUserData() async throws {
        // 10초의 시간 제한을 설정합니다.
        let timeout: TimeInterval = 15.0
        
        try await withTimeout(seconds: timeout) {
            // 프로필 이미지와 바이오 정보를 순차적으로 업데이트합니다.
            try await self.updateProfileImage()
            try await self.updateBio()
        }
    }
    
    @MainActor
    private func loadImage() async {
        guard let item = selectedItem else {
            print("❌ selectedItem이 nil입니다")
            return
        }
        
        print("📸 이미지 로딩 시작...")
        
        do {
            guard let data = try await item.loadTransferable(type: Data.self) else {
                print("❌ loadTransferable 실패: 데이터가 nil입니다")
                errorMessage = "이미지 데이터를 로드할 수 없습니다"
                return
            }
            
            print("✅ 데이터 로드 성공: \(data.count) bytes")
            
            guard let uiImage = UIImage(data: data) else {
                print("❌ UIImage 변환 실패")
                errorMessage = "이미지 형식을 변환할 수 없습니다"
                return
            }
            
            print("✅ UIImage 변환 성공: \(uiImage.size)")
            
            self.uiImage = uiImage
            self.profileImage = Image(uiImage: uiImage)
            
            print("✅ 이미지 로딩 완료")
            
        } catch {
            print("❌ 이미지 로드 중 에러 발생: \(error.localizedDescription)")
            errorMessage = "이미지를 로드하는 중 오류가 발생했습니다: \(error.localizedDescription)"
        }
    }
    
    private func updateProfileImage() async throws {
        guard let image = self.uiImage else {
            print("⚠️ uiImage가 nil이므로 업로드하지 않습니다")
            return
        }
        
        print("📤 Firebase Storage 업로드 시작...")
        
        guard let imageUrl = try await ImageUploader.uploadImage(_image: image) else {
            print("❌ ImageUploader가 nil을 반환했습니다")
            throw UploadError.imageUploadFailed
        }
        
        print("✅ 업로드 성공: \(imageUrl)")
        
        try await UserService.shared.updateUserProfileImage(withImageUrl: imageUrl)
        
        print("✅ 프로필 이미지 URL 업데이트 완료")
    }
    
    private func updateBio() async throws {
        if !bio.isEmpty && user.bio != bio {
            print("📝 Bio 업데이트: \(bio)")
            try await UserService.shared.updateUserBio(bio)
        }
    }
}
