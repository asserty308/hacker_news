flutter clean
flutter pub get
flutter build macos --obfuscate --split-debug-info=build/app/outputs/symbols
# flutter build ipa --obfuscate --split-debug-info=build/app/outputs/symbols
# cd ios
# fastlane beta
# cd ..
# flutter build appbundle --obfuscate --split-debug-info=build/app/outputs/symbols
# cd android
# fastlane internal
# cd ..