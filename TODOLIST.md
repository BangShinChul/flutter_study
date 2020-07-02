# food_expiration_date_alarm TODO LIST

- Local Notification 라이브러리 세팅 및 테스트
    - [로컬 Notification 라이브러리 관련 글](https://medium.com/@riokim/flutter-%EC%97%90%EC%84%9C-notification-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0-ddce8af82123) 참고하여 테스트했지만, 동작이 안됨. 확인해볼 것. (해결)
    - 로컬 Notification에서 스케쥴 방식 알림 발송 안됨 
        - [참고](https://pub.dev/documentation/flutter_local_notifications/latest/flutter_local_notifications/FlutterLocalNotificationsPlugin/schedule.html) schedule 혹은 periodicallyShow로 알림 발송 시 앱이 팅김. 해결할 것. 
        - 문제 해결 완료. 원인은 debug/AndroidManifest.xml과 main/AndroidManifest.xml의 설정이 제대로 안되어 있어서 그랬던 거였음. 고쳐서 테스트 후 완료. 근데 5초뒤 알림이 너무 늦게옴. 한 15초 20초 정도 소요된 뒤 오는 것 같음.
    - debug 에서는 5초 후 알림 발송이 되었지만, release에서는 계속 앱이 팅기는 이슈가 발생함. 이를 위해 디바이스를 물려 디버깅함
        - `[ERROR:flutter/shell/platform/android/platform_view_android_jni.cc(39)] java.lang.AssertionError: java.lang.NoSuchFieldException: DrawableResource` 라는 에러 발생이 원인이였음. 
        - [관련 StackOverFlow](https://stackoverflow.com/questions/58134023/flutter-local-notification-causing-crash-only-in-the-apk-version)를 참고하여 해결 완료. 
        - 해결법 : 앱 빌드 시 --no-shirik 옵션 추가. [참고 링크:R8](https://flutter.dev/docs/deployment/android#r8)
    - 내부 로컬 스토리지 데이터 읽어서 특정 시간에 특정 메시지로 알림 가도록 설정해볼 것.
- 로컬 스토리지 사용법 테스트
- 바코드 스캔 혹은 QR코드 스캔 라이브러리 검색
    - https://pub.dev/packages/flutter_barcode_scanner
    - https://pub.dev/packages/barcode_scan
    - https://m.blog.naver.com/chandong83/221872148573

