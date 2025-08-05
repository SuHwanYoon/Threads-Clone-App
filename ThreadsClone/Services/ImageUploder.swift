//
//  ImageUploder.swift
//  ThreadsClone
//
//  Created by YOON on 8/5/25.
//

import Foundation
import Firebase
import FirebaseStorage

// ImageUploader는 Firebase Storage에 이미지를 업로드하는 기능을 제공합니다.
// 이 구조체는 비동기적으로 이미지를 업로드하고, 업로드된 이미지 의 다운로드 URL을 반환합니다.
// Firebase Storage를 사용하여 이미지를 업로드하는 기능을 구현합니다.
// ImageUploader 구조체는 값타입으로, 데이터 전달용, 복사해도 독립적으로 유지됩니다.
struct ImageUploader {
    // uploadImage 메서드는 UIKit의 UIImage를 파라미터로 받아 Firebase Storage에 업로드하고
    // 업로드된 이미지의 다운로드 URL을 반환합니다.
    static func uploadImage(_image: UIImage) async throws -> String?{
        // imageData는 UIImage를 JPEG 형식으로 변환한 데이터입니다.
        // compressionQuality는 이미지 압축 품질을 나타내며, 0.25 값은 이미지의 품질을 25%로 압축합니다.
        // UIImage의 jpegData 메서드를 사용하여 UIImage를 JPEG 형식으로 변환 합니다.
        // 이 메서드는 UIImage를 JPEG 형식으로 변환하고, 변환된 데이터를 반환합니다.
        // 만약 변환이 실패하면 nil을 반환합니다.
        guard let imageData = _image.jpegData(compressionQuality: 0.25) else { return nil }
        // UUid를 사용하여 고유한 파일 이름을 생성합니다.
        let filename = NSUUID().uuidString
        // Firebase Storage의 이미지 저장 경로를 지정합니다.
        // "images/\(filename).jpg" 형식으로 저장됩니다.
        let storageRef = Storage.storage().reference(withPath: "images/\(filename).jpg")
        
        do {
            // let _ = 는 해당 작업의 결과를 사용하지 않음을 나타냅니다.
            // 사용하지 않음에도 변수를 선언하는 이유는 컴파일러가 경고를 발생시킬 수 있기 때문입니다.
            // putDataAsync 메서드를 사용하여 파라미터로 전달받고 압축한 이미지 데이터를 Firebase Storage에 업로드합니다.
            // 업로드가 완료되면 downloadURL 메서드를 사용하여 업로드된 이미지의 다운로드 URL을 가져옵니다.
            // 이 URL은 Firebase Storage에 저장된 이미지에 접근할 수 있는 링크입니다.
            // 만약 업로드나  다운로드 URL 가져오기 과정에서 오류가 발생하면 catch 블록으로 이동합니다.
            let _ = try await storageRef.putDataAsync(imageData , metadata: nil)
            let url = try await storageRef.downloadURL()
            return url.absoluteString
        } catch {
            // 업로드 중 오류가 발생하면 오류를 처리합니다.
            // error.localizedDescription을 사용하여 오류 메시지를 출력합니다.
            // 이 메시지는 이미지 업로드 실패의 원인을 나타냅니다.
            // nil을 반환하여 이미지 업로드가 실패했음을 나타냅니다.
            print("Debug: Image upload failed with error: \(error.localizedDescription)")
            return nil
        }
    }
}

