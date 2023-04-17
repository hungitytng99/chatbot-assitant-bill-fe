# ihz_bql

# Run app
Edit configurations
![](https://i.imgur.com/LpMKEzj.jpg)

# Build Android
## Run command before build
```
flutter pub run intl_utils:generate
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter build apk --release --flavor dxg
```
## Build APK
Step 1:
![](https://i.imgur.com/8ap2r5O.png)
Step 2:
![](https://i.imgur.com/4rxCQ6g.png)
Step 3:
![](https://i.imgur.com/cbXHZ8X.png)

# Build iOS
## Run command before build
```
flutter pub run intl_utils:generate
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter build ios --release --flavor dxg
```
## Upload TestFlight
Step 1: Confige scheme
![](https://i.imgur.com/g5pSUE5.png)
Step 2: Archive and Upload

# Fastlane
## Install Fastlane
```
sudo gem install fastlane
```
## Install App Distribution
```
fastlane add_plugin firebase_app_distribution
```
## Build Android
```
cd android
fastlane dxg_th_firebase
fastlane dxg_staging_firebase
```
## Build iOS
```
cd ios
fastlane dxg_th_firebase
fastlane dxg_staging_firebase
```

## Quick Build & Upload to Firebase Distribution
```
./build_th.sh
```
```
./build_staging.sh
```
