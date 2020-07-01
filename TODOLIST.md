# food_expiration_date_alarm TODO LIST

- Local Notification 라이브러리 세팅 및 테스트
    - [로컬 Notification 라이브러리 관련 글](https://medium.com/@riokim/flutter-%EC%97%90%EC%84%9C-notification-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0-ddce8af82123) 참고하여 테스트했지만, 동작이 안됨. 확인해볼 것. (해결)
    - 로컬 Notification에서 스케쥴 방식 알림 발송 안됨 -> [참고](https://pub.dev/documentation/flutter_local_notifications/latest/flutter_local_notifications/FlutterLocalNotificationsPlugin/schedule.html) schedule 혹은 periodicallyShow로 알림 발송 시 앱이 팅김. 해결할 것.
    - 내부 로컬 스토리지 데이터 읽어서 특정 시간에 특정 메시지로 알림 가도록 설정해볼 것.
- 로컬 스토리지 사용법 테스트
- 바코드 스캔 혹은 QR코드 스캔 라이브러리 검색
    - https://pub.dev/packages/flutter_barcode_scanner
    - https://pub.dev/packages/barcode_scan
    - https://m.blog.naver.com/chandong83/221872148573

