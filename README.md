# Sample Flutter

## 명령어

flutter create XXX

## 필수 익스텐션

Dart, Flutter 설치

## To-Do list

[X] Dribble 보고 똑같이 .. 디자인 연습 만들어보기
  > <https://dribbble.com/shots/20166390--29-Mobile-App-Concept>
[X] 뽀모도로 만든거 연습 해보기 (타이머앱)
  > <https://www.behance.net/gallery/153414411/Timer>
  > <https://dribbble.com/shots/12024270-Countdown-Timer-DailyUI014>
[ ] 공공데이터 API로 데이터 fetch 연습
  > 날씨 데이터 활용
  > 전국 날씨 조회
  > 날씨 조회 상세보기 클릭 시 상세데이터 조회
  > 폰트 바꾸기
  > 하단바 추가해보기
  > 그리고 뭔가 하나더...
  > <https://dribbble.com/shots/15208692-Weather-App>

## References

[명명 규칙]<https://dart.dev/tools/pub/pubspec#name> </br>
[빌드에러대응]<https://hijigoo.github.io/flutter/2021/05/05/error-tip-01/>
[ListView]<https://dalgonakit.tistory.com/104> </br>

## 강의내용 정리

### 2.2 Running Flutter

- lib/main.dart 가 메인파일
- os별로 폴더가 나눠져 있음
- vscode에서 오른쪽 상단에 있는 디버그 버튼을 눌러서 실행함
- 제대로 동작하는지 확인하기 위해서 main.dart의 color 코드 수정

### 2.3 Hello World

- widget을 사용해서 화면 구성
- 앱의 테마를 정해야함(MaterialApp, CupertinoApp)
- 각각 안드로이드, iOS테마인데 구글에서 플러터를 만들다보니 MateriApp이 더 깔끔함
- 모든 화면은 Scaffold 안에 들어가야함

### 3.0 Header

- 여러 위젯들을 써볼거임
- 디자인을 직접 구현 (<http://dribbble.com/shots/19858341-Finnancial-Mobile-IOS-App>)
- appBar 삭제하기
  - appBar의 속성을 보면 ?가 붙어있음.. 필수가 아니란 뜻

### 3.1 Developer Tools

- debug에서 Wiget Inspect 모드에서 레이아웃을 조절할 수 있음

### 3.2 Buttons Section

- 중간의 Total Balance 작업 시작

### 3.3 VSCode Settings

- vscode 쓰면서 생기는 파란줄 처리
- user settings.json 파일 수정
- 아래 설정을 통해 저장하면 자동으로 const가 필요한부분들을 수정해줌

```json
  // settings.json 
  "editor.codeActionsOnSave": {
    "source.fixAll": true
  },
  "dart.previewFlutterUiGuides": true,  // 소스코드 내에서 어떤 부모 객체에 들어간 요소인지 나오게 됨
```

### 3.4 Code Actions

- 코드 리팩토링 기능
- 왼쪽의 전구를 클릭해서 Widget 감싸기를 자동으로 처리 가능
- 단축키는 Control + .

### 3.5 Resuable Widgets

- 추가 설정 하기
- 코드 저장할때마다 자동 포멧팅해주는거
- Error Lens도 설치하기

```json
  "editor.formatOnSave": true,
  "editor.formatOnType": true,
```

- 버튼을 재사용할 수 있도록 별도 위젯 추가하기
- Code Actions의 Extract를 사용할 수 있지만 여기서는 익숙해질때까지 사용하진 않을거임
- lib/widgets/buttons.dart 추가(소문자로)
- 속성만 추가해서 재사용이 가능한 버튼으로 만들기

### 3.6 Card

- 샘플 디자인의 카드 아이콘 생성
- Row의 main과 cross 축은 각각 가로, 세로임. Column은 그 반대.

### 3.7 Icons and Transforms

- 카드에 아이콘 추가하기
- 디자인 예시처럼 overflow가 되기 위해 Transform과 clipBehavior 사용

### 3.8 Reusable Cards

- 카드 디자인 재활용을 위해 위젯 생성(currency_card.dart)
- 여러 카드를 추가했을 경우 overflow 즉 화면레이아웃을 넘겨버려서 별도 처리가 필요함
- 유저로 하여금 스크롤링이 가능하도록 처리해줘야함
- 위치는 body 분에서 Padding을 사용하기전에 스크롤 추가
- 마무리로 Transform.translate로 카드 포개기

### 3.9 Code Challenge

- Transform.translate와 Offset까지 widget으로 처리해보기
- order라는 새로운 프로퍼티를 추가해서 offset 제어해보기

### 4.0 State

- 데이터가 변경되면서 반영되는 실시간 위젯이 StateFullWidget

### 4.1 setState

- 상태를 변경하고 setState를 통해서 플러터를 다시 빌드 시킴

### 4.3 BuildContext

- 앱의 모든 스타일을 한곳에서 지정할 수 있는 기능을 제공함(테마)
- 테마를 생성했다면 테마에 접근해야함. 이때 사용하는게 BuildContext.. 부모 요소에 접근해야함
- context는 모든 상위요소에 대한 정보가 담겨있음

### 4.4 Widget Lifecycle

- StatefulWidget은 라이프사이클이 존재함
- initState라는게 있는데 빌드 하기전에 항상 호출되야하고 딱 한번 호출됨
- 빌드를 하기전에 데이터를 받아와야할때.. 등등 선택해서 사용
- dispose는 위젯이 스크린에서 제거될때 호출되는 메서드임
- 위젯 트리에서 제거되기 전에 무언가 취소할떄 사용

### 5.0 User Interface

> 참고디자인[https://www.behance.net/gallery/98918603/POMO-UIKIT?tracking_source=search_projects%7Cpomo+uikit]

- 뽀모도로앱 만드는거 실습 시작
- StatelessWidget으로 만들고 screens폴더 생성
- home_screen.dart 생성
- home_screen에는 Flexible 위젯 사용. UI를 비율에 기반하여 더 유연하게 만들어줌.
  - flex 속성을 통해 위젯별로 차지하는 비율 설정

### 5.1 Timer

- 타이머 기능 추가(거꾸로)
- state를 카운트할 시간으로 초기화

### 5.2 Pause Play

- 타이머를 일시정지할 수 있는 기능 추가

### 5.3 Date Format

- 1500을 분:초 형태로 변경하기 위해 dart에 내장된 Duration 클래스 사용

### 6.1 App Bar

- App Bar 추가하기

### 6.2 Data Fetching

- http 패키지 설치(flutter pub add http)

### 6.3 fromJson

- 전달받은 데이터를 json 형식으로 변환

### 6.4 Recap

### 6.5 waitForWebToons

- static으로 변경
- 플러터에서 데이터를 보여주는 방법은 두가지가 있음
- 이번시간에 할거는 state를 통해서 설정

### 6.6 FutureBuilder

- 6.5에서 state를 썼지만 사실 쓰는걸 권장하지 않음
- 이번에 할거는 statelessWidget인 상태에서 fetch할 수가 있음
- futurebuilder를 통해서 데이터 fetch 하기

### 6.7 ListView

- list 형태의 데이터를 표현하기 위해 listview 사용
- ListView / ListView.builder / ListView.separated 사용

### 6.8 Webtoon Card

- 빌더가 너무 많으므로 따로 추출하기(widget 위에서 해야 method 됨)
- 카드 형태의 디자인 생성

### 6.9 Detail Screen

- 상세 페이지로 이동하는거 추가
- 클릭을 감지하기 위해 GestureDetector 추가하기

### 6.10 Hero

- 화면 전환을 할때 애니메이션을 제공함
- 화면이 스크롤되는게 아닌 클릭 했을때 화면이 확대되는 형식으로 애니메이션 제공
- 위젯과 이동할 화면의 hero tag가 동일해야함

### 6.12 ApiService

- url api에 id를 넣어서 상세조회 기능 구현

### 6.13 Futures

- detail 은 다른 방식으로 써야함 futurebuilder가 아닌
- id 값이 필요하기 때문..
- stateless -> stateful로 변경하고 initstate를 통해 데이터 받아오기 처리

### 6.14 Detail Info

- 상세 화면 설정

### 6.15 Episodes

- 특정 데이터에 의존해서 데이터를 받아오는 경우 statefulwidget으로 사용
- 그게 아니라면 statelesswidget으로도 가능
- home_screen의 경우에는 stateless, detail은 stateful로 한 이유
- episodes를 보여주는 공간 생성

### 6.16 Url Launcher

- flutter 에서 브라우저를 열거임
- url_launcher 설치하기
  
> flutter pub add url_launcher

- 설정을 몇가지 더해줘야함. ios하고 andorid에 따라 달라짐
- 설정을 하고 flutter를 아예 다시 시작해야함

### 6.17 Favorites

- favoirte 기능 추가
- shared_preferences 패키지 설치

> flutter pub add shared_preferences

- 핸드폰 저장소에 데이터를 저장하기 위해 사용
