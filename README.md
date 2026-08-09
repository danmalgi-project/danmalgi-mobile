# Danmalgi Mobile

Danmalgi의 Flutter 모바일 클라이언트입니다. 이 문서는 저장소를 처음 받은 개발자가
Windows 또는 macOS에서 Android/iOS 앱을 실행하기 위해 필요한 초기 설정을 설명합니다.

## 프로젝트 설정 요약

| 항목 | 현재 프로젝트 설정 |
| --- | --- |
| Dart SDK | `^3.9.2` |
| 지원하는 모바일 플랫폼 | Android, iOS |
| Proto 원본 | `proto/` Git 서브모듈 |
| gRPC 생성 결과 | `lib/core/generated/` |
| Freezed 생성 결과 | 각 모델 옆의 `*.freezed.dart` |
| Firebase 프로젝트 ID | `danmalgi` |
| Android application ID | `com.danmalgi.mobile` |
| iOS bundle ID | `com.danmalgi.mobile` |
| iOS deployment target | `17.6` |

> Windows에서는 Android 앱을 개발하고, macOS에서는 Android와 iOS 앱을 개발할 수
> 있습니다. iOS 빌드와 실행은 Xcode가 필요하므로 macOS에서만 가능합니다.

## 시작하기 전에 준비할 정보

프로젝트 관리자에게 다음 권한과 값을 요청합니다.

- Firebase 프로젝트 `danmalgi` 접근 권한
- Google OAuth의 Server Client ID, Server Client Secret, iOS Client ID
- API, Chat, Voice gRPC 서버의 호스트와 포트
- 실제 iPhone에서 실행할 경우 Apple Developer Team 접근 권한

`.env`, Firebase 설정 파일 및 인증서는 Git에 커밋하지 않습니다.

## 저장소 받기

`proto/`가 Git 서브모듈이므로 가능하면 처음부터 서브모듈을 함께 clone합니다.

```bash
git clone --recurse-submodules <repository-url>
cd danmalgi-mobile
```

이미 clone한 저장소라면 프로젝트 루트에서 다음 명령을 실행합니다.

```bash
git submodule update --init --recursive
```

`proto/` 아래에 `auth`, `chat`, `dm`, `friend`, `relationship`, `signaling`,
`user` 등의 디렉터리가 생성되었는지 확인합니다.

---

## Windows 설정

Windows 환경에서는 PowerShell을 기준으로 설명합니다.

### 1. Flutter 및 Android 개발 환경

다음을 설치합니다.

- [Git for Windows](https://git-scm.com/download/win)
- [Flutter SDK](https://docs.flutter.dev/get-started/install/windows/mobile)
- Android Studio와 Android SDK
- Google Play 이미지로 만든 Android Emulator 또는 USB 디버깅이 활성화된 Android 기기
- Firebase CLI를 npm으로 설치할 경우 [Node.js 18 이상](https://nodejs.org/)

Flutter SDK의 `bin` 디렉터리를 사용자 `Path`에 추가한 뒤 새 PowerShell을 열고
설치를 확인합니다.

```powershell
flutter --version
dart --version
flutter doctor -v
flutter doctor --android-licenses
```

`flutter doctor -v`의 Android toolchain 항목에 오류가 있다면 먼저 해결합니다.

### 2. 프로젝트 의존성 설치

프로젝트 루트에서 실행합니다.

```powershell
git submodule update --init --recursive
flutter pub get
```

### 3. `.env` 생성

```powershell
Copy-Item .env_example .env
```

생성된 `.env`의 값을 개발 환경에 맞게 수정합니다. 모든 키 이름은 유지해야 합니다.

```dotenv
DANMALGI_API_HOST=10.0.2.2
DANMALGI_API_PORT=50000

DANMALGI_CHAT_HOST=10.0.2.2
DANMALGI_CHAT_PORT=50002

DANMALGI_VOICE_HOST=10.0.2.2
DANMALGI_VOICE_PORT=50003

GID_SERVER_CLIENT_ID=<server-client-id>
GID_SERVER_CLIENT_SECRET=<server-client-secret>
GID_IOS_CLIENT_ID=<ios-client-id>
```

Android Emulator에서 개발 PC의 로컬 서버에 접속할 때는 `localhost` 대신
`10.0.2.2`를 사용합니다. 실제 Android 기기에서는 개발 PC의 LAN IP를 사용하고,
PC 방화벽과 백엔드의 listen 주소도 확인해야 합니다.

### 4. protoc와 Dart protoc 플러그인 설치

Protocol Buffers 컴파일러를 설치합니다.

```powershell
winget install protobuf
```

설치 후 새 PowerShell을 열어 `protoc`을 확인합니다.

```powershell
protoc --version
```

Dart 코드 생성 플러그인을 설치합니다.

```powershell
dart pub global activate protoc_plugin
```

Dart 전역 실행 파일 경로를 Windows 사용자 환경 변수 `Path`에 추가합니다.

```text
%LOCALAPPDATA%\Pub\Cache\bin
```

설정 방법은 `시스템 속성` → `고급` → `환경 변수` → 사용자 변수의 `Path` →
`새로 만들기`입니다. 환경 변수를 적용하려면 열려 있던 터미널과 IDE를 모두 닫고
다시 엽니다.

현재 PowerShell 세션에만 즉시 적용하려면 다음 명령을 사용할 수 있습니다.

```powershell
$env:Path += ";$env:LOCALAPPDATA\Pub\Cache\bin"
```

플러그인이 검색되는지 확인합니다.

```powershell
Get-Command protoc-gen-dart
```

### 5. gRPC 코드 생성

프로젝트에 포함된 PowerShell 스크립트는 모든 `proto/**/*.proto` 파일을 읽어
`lib/core/generated/`에 Dart 메시지와 gRPC 클라이언트를 생성합니다.

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\generate_proto.ps1
```

생성되는 주요 파일은 다음과 같습니다.

- `*.pb.dart`
- `*.pbenum.dart`
- `*.pbgrpc.dart`
- `*.pbjson.dart`

이 저장소는 gRPC 생성 결과를 Git으로 추적합니다. Proto가 변경되어 생성 결과가
달라졌다면 `proto` 서브모듈 커밋과 `lib/core/generated/`의 변경 내용을 함께
커밋합니다.

### 6. Freezed 코드 생성

Freezed 생성 파일은 Git에서 제외되므로 새로 clone한 환경에서는 반드시 생성합니다.

```powershell
dart run build_runner build --delete-conflicting-outputs
```

모델을 수정하면서 생성기를 계속 실행하려면 다음 명령을 사용할 수 있습니다.

```powershell
dart run build_runner watch --delete-conflicting-outputs
```

### 7. Firebase 설정

Firebase CLI와 FlutterFire CLI를 설치합니다.

```powershell
npm install -g firebase-tools
firebase login
dart pub global activate flutterfire_cli
```

`flutterfire`도 Dart 전역 실행 파일 경로를 사용합니다. 명령을 찾지 못하면 4단계의
`%LOCALAPPDATA%\Pub\Cache\bin` PATH 설정을 다시 확인합니다.

로그인한 계정에 프로젝트가 표시되는지 확인합니다.

```powershell
firebase projects:list
```

프로젝트 루트에서 FlutterFire 설정을 실행합니다.

```powershell
flutterfire configure --project=danmalgi
```

설정 화면에서는 다음 항목을 선택하거나 기존 앱과 연결합니다.

- 플랫폼: `android`
- Firebase 프로젝트: `danmalgi`
- Android application ID: `com.danmalgi.mobile`

완료 후 아래 파일이 존재하는지 확인합니다.

```text
lib/firebase_options.dart
android/app/google-services.json
```

두 파일은 현재 `.gitignore`에 포함되어 있습니다. `firebase_options.dart`가 없으면
`lib/main.dart`의 import에서 컴파일 오류가 발생합니다.

설정 후 `git diff -- firebase.json android`로 FlutterFire가 기존 프로젝트 설정을
의도치 않게 변경하지 않았는지 확인하고, 자동 변경을 검토 없이 커밋하지 않습니다.

> 이 저장소에는 이미 FlutterFire가 만든 `firebase.json`과 Android Gradle
> Google Services 플러그인 설정이 있습니다. 이 앱을 처음부터 다시 초기화하는
> `firebase init`은 실행하지 마세요.

### 8. Android 앱 실행

```powershell
flutter devices
flutter run
```

특정 기기로 실행하려면 다음과 같이 기기 ID를 지정합니다.

```powershell
flutter run -d <device-id>
```

---

## macOS 설정

macOS 기본 셸인 zsh를 기준으로 설명합니다.

### 1. Flutter, Android 및 iOS 개발 환경

다음을 설치합니다.

- [Flutter SDK](https://docs.flutter.dev/get-started/install/macos/mobile-ios)
- Android Studio와 Android SDK
- App Store의 Xcode
- [Homebrew](https://brew.sh/)
- Firebase CLI를 npm으로 설치할 경우 [Node.js 18 이상](https://nodejs.org/)

Xcode를 처음 설치했다면 초기 설정을 완료합니다.

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -license accept
xcodebuild -downloadPlatform iOS
```

CocoaPods를 설치합니다.

```bash
brew install cocoapods
```

Flutter SDK의 `bin` 디렉터리를 `~/.zshrc`의 `PATH`에 추가한 뒤 새 터미널을 열고
설치를 확인합니다.

```bash
flutter --version
dart --version
flutter doctor -v
flutter doctor --android-licenses
```

Apple Silicon Mac에서 도구가 Rosetta를 요구하면 다음 명령으로 설치합니다.

```bash
sudo softwareupdate --install-rosetta --agree-to-license
```

### 2. 프로젝트 의존성 설치

프로젝트 루트에서 실행합니다.

```bash
git submodule update --init --recursive
flutter pub get
```

### 3. `.env` 생성

```bash
cp .env_example .env
```

생성한 `.env`에서 API 주소와 Google OAuth 값을 개발 환경에 맞게 수정합니다.

```dotenv
DANMALGI_API_HOST=127.0.0.1
DANMALGI_API_PORT=50000

DANMALGI_CHAT_HOST=127.0.0.1
DANMALGI_CHAT_PORT=50002

DANMALGI_VOICE_HOST=127.0.0.1
DANMALGI_VOICE_PORT=50003

GID_SERVER_CLIENT_ID=<server-client-id>
GID_SERVER_CLIENT_SECRET=<server-client-secret>
GID_IOS_CLIENT_ID=<ios-client-id>
```

iOS Simulator에서 Mac의 로컬 서버에 접속할 때는 `127.0.0.1`을 사용할 수 있습니다.
Android Emulator를 실행한다면 Windows와 마찬가지로 `10.0.2.2`를 사용합니다.
실제 모바일 기기에서는 Mac의 LAN IP를 사용해야 합니다.

### 4. protoc와 Dart protoc 플러그인 설치

```bash
brew install protobuf
protoc --version

dart pub global activate protoc_plugin
```

Dart 전역 실행 파일 디렉터리가 PATH에 없다면 `~/.zshrc`에 다음 한 줄을 추가합니다.

```bash
export PATH="$PATH:$HOME/.pub-cache/bin"
```

변경한 설정을 현재 터미널에 적용하고 플러그인을 확인합니다.

```bash
source ~/.zshrc
command -v protoc-gen-dart
```

### 5. gRPC 코드 생성

```bash
./scripts/generate_proto.sh
```

실행 권한 오류가 발생한 경우 한 번만 다음 명령을 실행한 뒤 다시 시도합니다.

```bash
chmod +x scripts/generate_proto.sh
./scripts/generate_proto.sh
```

스크립트는 `proto/`의 모든 proto 파일을 읽어 `lib/core/generated/`에 생성합니다.
Proto가 변경되었다면 `proto` 서브모듈 커밋과 생성 결과를 함께 커밋합니다.

### 6. Freezed 코드 생성

```bash
dart run build_runner build --delete-conflicting-outputs
```

개발 중 생성기를 계속 실행하려면 다음 명령을 사용합니다.

```bash
dart run build_runner watch --delete-conflicting-outputs
```

### 7. Firebase 설정

```bash
npm install -g firebase-tools
firebase login
dart pub global activate flutterfire_cli
firebase projects:list
```

프로젝트 루트에서 실행합니다.

```bash
flutterfire configure --project=danmalgi
```

설정 화면에서 기존 Firebase 앱과 다 같이 연결합니다.

- 플랫폼: Android와 iOS
- Firebase 프로젝트: `danmalgi`
- Android application ID: `com.danmalgi.mobile`
- iOS bundle ID: `com.danmalgi.mobile`

완료 후 아래 파일을 확인합니다.

```text
lib/firebase_options.dart
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
```

세 파일은 현재 `.gitignore`에 포함되어 있습니다. FlutterFire가 플랫폼 설정 파일을
생성하지 못했다면 Firebase Console의 기존 Android/iOS 앱에서 파일을 내려받아 위
경로에 배치합니다.

설정 후 `git diff -- firebase.json android ios`로 FlutterFire가 기존 프로젝트
설정을 의도치 않게 변경하지 않았는지 확인하고, 자동 변경을 검토 없이 커밋하지
않습니다.

> 기존 `firebase.json`을 유지해야 하므로 `firebase init`은 실행하지 마세요.

### 8. CocoaPods와 iOS 서명 설정

Flutter 의존성을 받은 후 iOS Pod을 설치합니다.

```bash
cd ios
pod install
cd ..
```

실제 iPhone에서 실행하려면 Xcode workspace를 열어 서명을 확인합니다.

```bash
open ios/Runner.xcworkspace
```

Xcode의 `Runner` → `Signing & Capabilities`에서 접근 가능한 Apple Developer Team을
선택합니다. 프로젝트의 iOS deployment target은 `17.6`입니다. Firebase Cloud
Messaging을 실제 기기에서 사용하려면 해당 앱 ID와 프로비저닝 설정에 Push
Notifications 및 Background Modes 권한도 준비되어 있어야 합니다.

### 9. 앱 실행

iOS Simulator를 열고 실행합니다.

```bash
open -a Simulator
flutter devices
flutter run
```

Android Emulator나 특정 iPhone을 지정하려면 다음 명령을 사용합니다.

```bash
flutter run -d <device-id>
```

## 생성 파일 관리

| 파일 | 생성 명령 | Git 관리 |
| --- | --- | --- |
| `lib/core/generated/**/*.pb*.dart` | `scripts/generate_proto.ps1` 또는 `.sh` | 커밋 |
| `**/*.freezed.dart`, `**/*.g.dart` | `dart run build_runner build` | 커밋하지 않음 |
| `lib/firebase_options.dart` | `flutterfire configure` | 커밋하지 않음 |
| `android/app/google-services.json` | `flutterfire configure` 또는 Firebase Console | 커밋하지 않음 |
| `ios/Runner/GoogleService-Info.plist` | `flutterfire configure` 또는 Firebase Console | 커밋하지 않음 |
| `.env` | `.env_example`을 복사해 직접 작성 | 커밋하지 않음 |

## 설정 완료 확인

아래 명령이 모두 성공하면 기본 개발 환경 설정이 끝난 것입니다.

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
flutter devices
```

추가로 다음 파일과 명령을 확인합니다.

- `.env`가 존재한다.
- `lib/firebase_options.dart`가 존재한다.
- Android 실행 시 `android/app/google-services.json`이 존재한다.
- iOS 실행 시 `ios/Runner/GoogleService-Info.plist`가 존재한다.
- `protoc --version`이 정상 출력된다.
- `protoc-gen-dart`가 PATH에서 검색된다.

## 자주 발생하는 문제

### `protoc-gen-dart: program not found or is not executable`

Dart 전역 실행 파일 디렉터리가 PATH에 없을 때 발생합니다.

- Windows: `%LOCALAPPDATA%\Pub\Cache\bin`
- macOS: `$HOME/.pub-cache/bin`

PATH를 수정한 뒤 터미널과 IDE를 다시 시작합니다.

### `Target of URI hasn't been generated` 또는 Freezed 파일을 찾지 못함

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### `firebase_options.dart`를 찾지 못함

Firebase CLI에 프로젝트 접근 권한이 있는 계정으로 로그인한 뒤 다시 생성합니다.

```bash
firebase login
flutterfire configure --project=danmalgi
```

### 앱은 실행되지만 로컬 gRPC 서버에 연결되지 않음

실행 환경에 맞는 `.env` 호스트를 확인합니다.

- Android Emulator → `10.0.2.2`
- iOS Simulator → `127.0.0.1`
- 실제 기기 → 개발 PC/Mac의 LAN IP

또한 백엔드가 해당 네트워크 인터페이스에서 요청을 받고 있는지와 방화벽에서 포트
`50000`, `50002`, `50003`을 허용하는지 확인합니다.

## 참고 문서

- [Flutter 설치](https://docs.flutter.dev/get-started/install)
- [Dart 전역 패키지와 PATH](https://dart.dev/tools/pub/cmd/pub-global)
- [Protocol Buffers 컴파일러 설치](https://protobuf.dev/installation/)
- [Dart protoc plugin](https://pub.dev/packages/protoc_plugin)
- [FlutterFire 설정](https://firebase.google.com/docs/flutter/setup)
- [Firebase CLI 설치](https://firebase.google.com/docs/cli)
