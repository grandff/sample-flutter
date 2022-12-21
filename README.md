# Sample Flutter

## 명령어

flutter create XXX

## 필수 익스텐션

Dart, Flutter 설치

## To-Do list

[ ] Dribble 보고 똑같이 .. 만들어보기

## 프로젝트 명령어 참조

[명명 규칙](https://dart.dev/tools/pub/pubspec#name) </br>

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
