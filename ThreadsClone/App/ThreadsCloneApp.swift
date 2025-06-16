//
//  ThreadsCloneApp.swift
//  ThreadsClone
//
//  Created by YOON on 5/5/25.
//

import SwiftUI
import FirebaseCore

// AppDelegate는 UIApplicationDelegate 프로토콜을 채택하여 앱의 생명주기를 관리합니다.
//  FirebaseApp.configure()를 호출하여 Firebase를 초기화합니다.
//  이 코드는 앱이 시작될 때 Firebase를 설정하는 역할을 합니다.
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct ThreadsCloneApp: App {
    // @UIApplicationDelegateAdaptor는 SwiftUI 앱에서 UIKit의 UIApplicationDelegate를 사용하기 위해 필요한 어댑터입니다.
    // 이 어댑터를 사용하면 SwiftUI 앱에서 UIKit의 생명주기 메서드를 사용할 수 있습니다.
    // AppDelegate를 UIApplicationDelegateAdaptor로 지정하여 앱의 생명주기를 관리합니다.
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
