# Sample Flutter

## 명령어
flutter create XXX

## 필수 익스텐션
Dart, Flutter 설치

## To-Do list
[ ] Dribble 보고 똑같이 .. 만들어보기

## 프로젝트 명령어 참조 
(명명 규칙)[https://dart.dev/tools/pub/pubspec#name] </br>

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
- 디자인을 직접 구현 (http://dribbble.com/shots/19858341-Finnancial-Mobile-IOS-App)
- appBar 삭제하기
  - appBar의 속성을 보면 ?가 붙어있음.. 필수가 아니란 뜻