#update version with build number = now()
now=$(date +"2%m%d%H%M")
perl -i -pe 's/^(version:\s+\d+\.\d+\.\d+\+)(\d+)$/$1.('$now')/e' pubspec.yaml
#build
flutter clean
flutter pub get
flutter pub run intl_utils:generate
flutter pub run build_runner build --delete-conflicting-outputs
cd android
fastlane dxg_th_firebase
cd ..
cd ios
fastlane dxg_th_firebase
cd ..
#reset update build number
git checkout ./pubspec.yaml