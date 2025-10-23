# 🚀 Release v1.0.2 (25.08.29)

## 🍎 iOS Threads Clone App
## Key Features

▶︎ **Firebase Authentication**  
   - 회원가입, 로그인, 로그아웃, 회원탈퇴 기능 지원

▶︎ **하단 탭바 네비게이션**  
   - 🏠, 🔍, ➕, 👤 메뉴 전환 가능

▶︎ **🏠 홈 피드**  
   - 모든 유저가 작성한 스레드와 프로필 사진 표시  
   - TimeStamp 기반 작성 시간 표시  
   - 상단 스크롤을 통한 새로고침 지원

▶︎ **🔍 탐색 뷰**  
   - 현재 로그인 유저 제외 후 모든 유저 나열  
   - 특정 유저 프로필 터치 시 해당 프로필로 이동  
   - 해당 유저의 작성 스레드 확인 가능

▶︎ **➕ 스레드 작성**  
   - 스레드 텍스트 작성 및 등록  
   - Firestore DB에 유저/스레드 데이터 저장

▶︎ **👤 프로필 뷰**  
   - 프로필 사진 및 자기소개 수정 가능  
   - ⚙ 설정 메뉴를 통해 로그아웃, 회원탈퇴, 문의, 개인정보처리방침 접근 가능

▶︎ **App Store 출시**  
   - 클론 앱 기반 UI/기능 수정 후  
   - **'오늘의 일기장'** 앱 네임으로 App Store 출시 완료 ✅

# Tech Stack
- **UI**: SwiftUI
- **Backend**: Firebase (Firestore, Authentication, Storage)
- **Architecture**: MVVM
- **Library**: Kingfisher, Combine 

# ScreenShots

<div style="display: inline-block;">
    <img src="ScreenShots/login_view.png" alt="login_view" width="300"/>
    <img src="ScreenShots/registration_view.png" alt="registration_view" width="300"/>
</div>

<div style="display: inline-block;">
    <img src="ScreenShots/tab_feedview.png" alt="tab_feedview" width="300"/>
    <img src="ScreenShots/tab_exploreview.png" alt="tab_exploreview" width="300"/>
</div>

<div style="display: inline-block;">
    <img src="ScreenShots/tab_createview.png" alt="tab_createview" width="200"/>
    <img src="ScreenShots/tab_activityview.png" alt="tab_activityview" width="200"/>
    <img src="ScreenShots/tab_profileview.png" alt="tab_profileview" width="200"/>
</div>


<div style="display: inline-block;">
    <img src="ScreenShots/feedview_detail.png" alt="feedview_detail" width="300"/>
    <img src="ScreenShots/exploreview_detail.png" alt="exploreview_detail" width="300"/>
</div>

<div style="display: inline-block;">
    <img src="ScreenShots/thread_tap_select.png" alt="thread_tap_select" width="300"/>
    <img src="ScreenShots/repliles_tap_select.png" alt="repliles_tap_select" width="300"/>
</div>

<div style="display: inline-block;">
    <img src="ScreenShots/edit_prifileview1.png" alt="edit_prifileview1" width="300"/>
    <img src="ScreenShots/edit_prifileview2.png" alt="edit_prifileview2" width="300"/>
</div>


<div style="display: inline-block;">
    <img src="ScreenShots/create_threads_view1.png" alt="create_threads_view1" width="200"/>
    <img src="ScreenShots/create_threads_view2.png" alt="create_threads_view2" width="200"/>
    <img src="ScreenShots/create_threads_view3.png" alt="create_threads_view3" width="200"/>
</div>


<div style="display: inline-block;">
    <img src="ScreenShots/email-format-auth-fail.png" alt="email-format-auth-fail" />
    <img src="ScreenShots/password-char-auth-fail.png" alt="password-char-auth-fail" />
    <img src="ScreenShots/user-create-success.png" alt="user-create-success" />
    <img src="ScreenShots/firebase-auth-user.png" alt="firebase-auth-user" />
</div>



<div style="display: inline-block;">
    <img src="ScreenShots/login_success.png" alt="login_success" />
    <img src="ScreenShots/login_success2.png" alt="login_success2" />
</div>


<div style="display: inline-block;">
    <img src="ScreenShots/signout_button.png" alt="signout_button" width="300"/>
    <img src="ScreenShots/signout_success.png" alt="signout_success" width="300"/>
</div>


<div style="display: inline-block;">
    <img src="ScreenShots/signup_firebase_database.png" alt="signup_firebase_database" />
</div>

## Update Profile with the information of the logged-in user
<!-- User: yoon , User: john login and profile view fetching Firebase -->
<div style="display: inline-block;">
    <img src="ScreenShots/john_login.png" alt="john_login" width="300"/>
    <img src="ScreenShots/john_profile.png" alt="john_profile" width="300"/>
</div>

<div style="display: inline-block;">
    <img src="ScreenShots/yoon_login.png" alt="yoon_login" width="300"/>
    <img src="ScreenShots/yoon_profile.png" alt="yoon_profile" width="300"/>
</div>

## Navigation from Explore View to Profile View

<div style="display: inline-block;">
    <img src="ScreenShots/navigation_to_profileview1.png" alt="navigation_to_profileview1" width="300"/>
    <img src="ScreenShots/navigation_to_profileview2.png" alt="navigation_to_profileview2" width="300"/>
</div>

## GuestUser Profile View    VS   Logged-in User Profile View
<div style="display: inline-block;">
    <img src="ScreenShots/button_guestuser_profile.png" alt="button_guestuser_profile" width="300"/>
    <img src="ScreenShots/button_my_profile.png" alt="button_my_profile" width="300"/>
</div>

## Edit My Profile Photo Image
<div style="display: inline-block;">
    <img src="ScreenShots/edit_profile_process1.png" alt="edit_profile_process1" width="300"/>
    <img src="ScreenShots/edit_profile_process2.png" alt="edit_profile_process2" width="300"/>
</div>

<div style="display: inline-block;">
    <img src="ScreenShots/edit_profile_process3.png" alt="edit_profile_process3" width="300"/>
    <img src="ScreenShots/edit_profile_process4.png" alt="edit_profile_process4" width="300"/>
</div>

<div style="display: inline-block;">
    <img src="ScreenShots/edit_profile_process6.png" alt="edit_profile_process6" width="300"/>
        <img src="ScreenShots/explore_view_profileimage.png" alt="explore_view_profileimage" width="300"/>
</div>


<div style="display: inline-block;">
    <img src="ScreenShots/edit_profile_process_firebase1.png" alt="edit_profile_process_firebase1" />
    <img src="ScreenShots/edit_profile_process_firebase2.png" alt="edit_profile_process_firebase2" />
</div>


## Post New Thread Feature
<div style="display: inline-block;">
    <img src="ScreenShots/upload_thread_process1.png" alt="upload_thread_process1" />
</div>

## Threads List in Feed View
<div style="display: inline-block;">
    <img src="ScreenShots/feching_user_thread_document_process1.png" alt="feching_user_thread_document_process1" />
</div>

## Navigation from navigation view to profile view of user touched
<div style="display: inline-block;">
    <img src="ScreenShots/navigate_from_expore_to_profile1.png" alt="navigate_from_expore_to_profile1" width="300"/>
    <img src="ScreenShots/navigate_from_expore_to_profile2.png" alt="navigate_from_expore_to_profile2" width="300"/>
</div>

## Scroll Down Refresh Feature in Feed View
<div style="display: inline-block;">
    <img src="ScreenShots/scroll-down-refresh1.png" alt="scroll-down-refresh1" width="300"/>
    <img src="ScreenShots/scroll-down-refresh2.png" alt="scroll-down-refresh2" width="300"/>
</div>
