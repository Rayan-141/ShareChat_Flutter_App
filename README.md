# ShareChat

A Flutter social sharing app prototype with language-filtered trends, posts with image/video selection, creator profiles, a live screen, notifications, and a monetization demo.

## Run on a device

1. Install Flutter and Android Studio (for Android) or Xcode (for iOS).
2. From this folder, run `flutter pub get`.
3. Connect a phone or start an emulator, then run `flutter run`.

To build an Android install package (APK), run:

```sh
flutter build apk --release
```

The APK is written to `build/app/outputs/flutter-apk/app-release.apk`. To build an Android App Bundle for Play Console, run `flutter build appbundle --release`.

The current app stores posts, notifications, and withdrawal requests locally in memory. Withdrawal is a demo flow and does not transfer money; social content and notifications are sample data. A production release needs a backend, durable storage, real authentication, payment processing, and a production signing key.
