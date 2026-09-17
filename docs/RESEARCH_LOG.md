# MADAR Research Log

## 2026-09-17

### Flutter platform floor
Flutter 3.47.2 currently lists Android 24+ and iOS 15+ as supported deployment platforms. Android 23 and earlier, and iOS 14 and earlier, are unsupported by the current Flutter stable line. The final MADAR floor remains subject to dependency compatibility, but Android 24 / iOS 15 is the current baseline candidate. Source: https://docs.flutter.dev/reference/supported-platforms

### Android exact alarms
Android recommends inexact alarms whenever possible. Exact alarms require special handling on Android 12+ and, for fresh installs targeting Android 13+, SCHEDULE_EXACT_ALARM is not pre-granted. USE_EXACT_ALARM is intended for limited core use cases. MADAR will not request exact-alarm access merely to show ordinary notifications.
Sources: https://developer.android.com/develop/background-work/services/alarms and https://developer.android.com/about/versions/14/behavior-changes-all

### Notifications
iOS requires notification authorization and recommends checking the current authorization state before scheduling local notifications. MADAR will request notification permission in context, after explaining the feature.
Source: https://developer.apple.com/documentation/usernotifications/asking-permission-to-use-notifications

### Location
Location should be requested only when the user activates automatic location features. Background location is not part of the initial requirement and should not be declared unless a concrete feature proves it necessary.
Source: https://pub.dev/packages/geolocator

### Sensors / Qibla
sensors_plus currently supports Android and iOS and provides accelerometer, gyroscope and magnetometer access.
Source: https://pub.dev/packages/sensors_plus

### Audio
just_audio currently provides Android/iOS playback from URLs, files and assets, playlists, looping and speed control. Package licensing is separate from licensing of individual audio recordings.
Source: https://pub.dev/packages/just_audio

### Permission management
permission_handler 13.0.2 is currently available and provides cross-platform permission status/request APIs. iOS configuration must be restricted to permissions MADAR actually uses.
Source: https://pub.dev/packages/permission_handler

### GitHub reuse research
Initial candidates:
- IDRISIUMCorp/al-furkan-quran-flutter-app: useful implementation reference, but repository advertises a Waqf/Charity license and contains GPL-3.0 code in at least one component. Reference only until licensing is resolved.
- meypod/al-quran: application code is AGPL-3.0-only; its Quran text references Tanzil and CC BY 3.0. Reference/data provenance candidate, not code to copy blindly.
- Kabeer786786/adhkar: source code is MIT, while hosted audio/CDN endpoints have separate restrictions. Code and audio are treated separately.
- OvaisKhanday/qibla_director_flutter and AdnanNasr/Zad_Al-Muslim remain candidates for deeper inspection.

### Reuse rule
Before incorporating external code/data we record exact repository/commit, component, license, attribution requirements, redistribution/commercial restrictions, and NOTICE entry.

### Content policy
No Quran, Hadith, Tafsir, translation, dua, dhikr, scholarly statement, audio, book, image or other religious content enters the official core package until provenance and redistribution rights are verified.

### Current architecture status
The repository contains the Flutter foundation, feature/domain boundaries, Drift database foundation, location/sensor/notification/audio dependency foundations, and a manual-only Android build workflow.
