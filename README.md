# ox

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

// Create app icon
flutter pub run flutter_launcher_icons:main

- Build apk
 
flutter build apk --split-per-abi --no-tree-shake-icons

// Quick Clean Cache
flutter clean
flutter pub cache repair
flutter pub get

// Update Flutter to Channel Stable
flutter channel stable
flutter upgrade --force