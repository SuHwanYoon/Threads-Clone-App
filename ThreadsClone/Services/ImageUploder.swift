import Foundation
import Firebase
import FirebaseStorage

struct ImageUploader {
    static func uploadImage(_image: UIImage) async throws -> String? {
        print("🔧 debug:photoUpload branch ImageUploader 시작")
        
        // ✅ IPv4 강제 설정 (테스트용)
        let config = URLSessionConfiguration.default
        config.multipathServiceType = .none
        
        guard let imageData = _image.jpegData(compressionQuality: 0.25) else {
            print("❌ JPEG 압축 실패")
            return nil
        }
        
        print("✅ JPEG 압축 성공: \(imageData.count) bytes")
        
        let filename = NSUUID().uuidString
        print("📝 파일명 생성: \(filename)")
        
        let storageRef = Storage.storage().reference(withPath: "images/\(filename).jpg")
        print("📂 Storage 참조 생성: images/\(filename).jpg")
        
        do {
            print("⏳ putDataAsync 호출 시작...")
            
            // 메타데이터 추가
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            // ✅ 수정 (반환값을 받음)
            // 1. 이미지 업로드에 10초 타임아웃 설정
            _ = try await withTimeout(seconds: 10.0) {
                try await storageRef.putDataAsync(imageData, metadata: metadata)
            }
            
            print("✅ putDataAsync 완료")
            print("⏳ downloadURL 가져오는 중...")
            
            // 2. URL 다운로드에 10초 타임아웃 설정
            let url = try await withTimeout(seconds: 10.0) {
                try await storageRef.downloadURL()
            }
            
            print("✅ downloadURL 획득: \(url.absoluteString)")
            
            return url.absoluteString
            
        } catch let error as NSError {
            print("❌ Firebase Storage 에러 발생")
            print("❌ Error Domain: \(error.domain)")
            print("❌ Error Code: \(error.code)")
            print("❌ Error Description: \(error.localizedDescription)")
            print("❌ Error UserInfo: \(error.userInfo)")
            
            if let underlyingError = error.userInfo[NSUnderlyingErrorKey] as? NSError {
                print("❌ Underlying Error: \(underlyingError)")
            }
            
            throw error
        } catch {
            print("❌ 알 수 없는 에러: \(error)")
            throw error
        }
    }
}
