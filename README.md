#  T!mer app

to-do list
- [x] 설정페이지 세팅하기 => iOS 13.2 종특 에러 ***씨발***
- [x] 아이패드 해상도 대응하기
- [x] 버그 있는지 더 살펴보기
- [x] 광고
인앱결제(인앱결제는 법인 등록 후 개발자 등록 후 처리)
- [x] 백그라운드에서도 시간이 가도록 처리 => 완전히 처리 완료!!!
- [x] launchscreen 만들기 (되도록 애니메이션)
- [x] check notification sound
- [x] isTimerStarted == false 될때 색 상의 하기
- [x] Foreground에서 Notification 실행 다시 알아보기 => 앱이 실행될때 실행 순서 파악 완료를 통한 Fix.
- [x] 중간에 onLongPressGesture 과정 할때 작아지고 진동 일으키는 애니메이션 완성하기 => 진동은 완성, shrink animation은 글쎄?
- [x] 각도가 변할 때 진동 울리는것 포기! => 너무 느려서 포기!
- [x] 백그라운드로 나가면 진동 없어지는 오류 고치기

google admob Apple ID
    Unique ID : ca-app-pub-4942689053880729~6950693605
    
google admob Apple Test ID
    banner ads : ca-app-pub-3940256099942544/2934735716
    interstial ads : ca-app-pub-3940256099942544/4411468910

googld admob Android ID
    ca-app-pub-4942689053880729~6195196896


Debug Simulator

Current Path-Way
1. 백그라운드 나갈 때 MainController에 있는 oldTime을 저장함 + UserSettings에 있는 backgroundTimeIntervalSynchronized를 false로 전환
2. ~~~~~~~~
3. Foreground로 들어올 때 SceneDelegate에서 작업 없음 => backgroundTimeIntervalSynchronized가 false일 때 newDate변수에 현재 시간 구함
4. 현재시간과 과거시간의 차이 구함 => UserSettings에 있는 timeInterval에 시간 차이 저장함.
5. 

~~~개편안~~~
1. UserNotification:completeHandler에서 Notification이 delevered되면 backgroundTimeIntervalSynchronized를 false로 변환
1. isForeground 변수 추가 해서 조건 추가.
2. 정제된 restOfTime변수를 그 자체 매개로 씀 => 새로운 변수인 storedReservationTime을 쓰자
3. storedReservationTime은 (타이머 시작할때 현재 시간 + storedReservationTime)으로 timer 예약.

개편안 2
1. 타이머 설정시 initialNotificationTime을 설정(고정값)
2. Notification 시간은 Date() + initialNotificationTime => 알림 시간
3. timeInterval = (notificationTime) - (Date()) => restOfTime by asynchronous

