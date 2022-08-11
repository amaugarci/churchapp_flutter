# app

GENERATE MODELS

flutter pub run build_runner build --delete-conflicting-outputs

flutter build apk --release

flutter build appbundle --target-platform android-arm,android-arm64

flutter build ios --release && bundle exec fastlane test_flight && bundle update fastlane
