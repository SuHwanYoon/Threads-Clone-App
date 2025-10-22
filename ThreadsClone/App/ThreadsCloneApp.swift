//
//  ThreadsCloneApp.swift
//  ThreadsClone
//
//  Created by YOON on 5/5/25.
//

import SwiftUI
import FirebaseCore
import FirebaseAppCheck // ✨ FirebaseAppCheck 모듈 임포트

// ✨ 1. FirebaseAppCheckProviderFactory를 구현합니다.
// 이 Factory는 앱 체크가 어떤 Provider(여기서는 App Attest)를 사용할지 Firebase에 알려줍니다.
class YourAppCheckProviderFactory: NSObject, AppCheckProviderFactory {
    func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
        // #if targetEnvironment(simulator) 전처리 지시문을 사용하여 시뮬레이터 환경을 감지합니다.
        #if targetEnvironment(simulator)
        // 시뮬레이터에서는 App Attest를 사용할 수 없으므로 DebugAppCheckProvider를 사용합니다.
        let provider = AppCheckDebugProvider(app: app)

        // 중요: Debug Token을 콘솔에 출력합니다. 이 토큰을 Firebase Console에 등록해야 합니다.
        print("Firebase App Check debug token (simulator): \(provider?.localDebugToken() ?? "" )")

        return provider
        #else
        // 물리 기기에서는 기존 로직을 유지합니다.
        if #available(iOS 14.0, *) {
            // iOS 14.0 이상에서는 AppAttestProvider를 사용합니다.
            return AppAttestProvider(app: app)
        } else {
            // iOS 14.0 미만에서는 DeviceCheckProvider를 사용합니다.
            return DeviceCheckProvider(app: app)
        }
        #endif
    }
}

// AppDelegate는 UIApplicationDelegate 프로토콜을 채택하여 앱의 생명주기를 관리합니다.
// FirebaseApp.configure()를 호출하여 Firebase를 초기화합니다.
// 이 코드는 앱이 시작될 때 Firebase를 설정하는 역할을 합니다.
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      // ✅ 환경 변수 확인 코드 추가
      if let storageDebug = ProcessInfo.processInfo.environment["FIREBASE_STORAGE_DEBUG_ENABLED"] {
          print(">>> Environment Check: FIREBASE_STORAGE_DEBUG_ENABLED = \(storageDebug)")
      } else {
          print(">>> Environment Check: FIREBASE_STORAGE_DEBUG_ENABLED not found in environment.")
      }
      if let appCheckDebug = ProcessInfo.processInfo.environment["FIREBASE_APP_CHECK_DEBUG_VERBOSE"] {
          print(">>> Environment Check: FIREBASE_APP_CHECK_DEBUG_VERBOSE = \(appCheckDebug)")
      } else {
          print(">>> Environment Check: FIREBASE_APP_CHECK_DEBUG_VERBOSE not found in environment.")
      }
      if let analyticsDebug = ProcessInfo.processInfo.environment["FIREBASE_ANALYTICS_DEBUG_ENABLE"] {
          print(">>> Environment Check: FIREBASE_ANALYTICS_DEBUG_ENABLE = \(analyticsDebug)")
      } else {
          print(">>> Environment Check: FIREBASE_ANALYTICS_DEBUG_ENABLE not found in environment.")
      }

    // ✨ 2. IMPORTANT: FirebaseApp.configure() 호출 전에 App Check 공급자 팩토리를 등록해야 합니다.
    // 이 줄을 FirebaseApp.configure() 호출보다 먼저 추가합니다.
    AppCheck.setAppCheckProviderFactory(YourAppCheckProviderFactory())

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
            ContentView()
        }
    }
}
