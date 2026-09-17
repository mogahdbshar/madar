# MADAR Research Log

## 2026-09-17

### Platform floor
Flutter 3.47.2 currently supports Android 24+ and iOS 15+. This is the current baseline candidate for MADAR, subject to final dependency locking. Source: https://docs.flutter.dev/reference/supported-platforms

### Android scheduling and notifications
Exact alarms must only be used when a user-facing function genuinely needs precise timing. Android 13+ requires explicit handling for exact alarm permissions, and Android 14 denies SCHEDULE_EXACT_ALARM by default for many fresh installs. MADAR will not request exact-alarm access merely for ordinary reminders. Sources:
- https://developer.android.com/develop/background-work/services/alarms
- https://developer.android.com/about/versions/14/behavior-changes-all

Android 14 also restricts USE_FULL_SCREEN_INTENT to eligible high-priority use cases such as calling/alarm scenarios. MADAR will not assume full-screen notification access for ordinary adhan notifications. Source:
- https://developer.android.com/about/versions/14/behavior-changes-14

### iOS notifications
iOS requires authorization for notification interactions and recommends requesting it in context. Local notifications can be scheduled and delivered while the app is not running, subject to system behavior and authorization. Sources:
- https://developer.apple.com/documentation/usernotifications/asking-permission-to-use-notifications
- https://developer.apple.com/documentation/usernotifications/scheduling-a-notification-locally-from-your-app

### Quran data
Tanzil states that its Quran text is Creative Commons Attribution 3.0, may be copied/distributed verbatim, must not be changed, must clearly attribute Tanzil, and must link to tanzil.net. This means MADAR must preserve a verbatim source copy and keep any search normalization in a separate internal field. Sources:
- https://tanzil.net/docs/Text_License
- https://tanzil.net/docs/Quran_Metadata

The mjmirza/quran-dataset project publishes its own dataset/schema under CC BY 4.0 and explicitly retains Tanzil attribution for the underlying source edition. It is a useful structural/validation candidate, but source provenance remains part of the data model. Source:
- https://github.com/mjmirza/quran-dataset

### Hadith data
AhmedBaset/hadith-json contains about 50,884 hadiths across 17 books and includes Arabic/English, but its README says the data was scraped from Sunnah.com. It must therefore be treated as a provenance candidate, not automatically redistributable content. Source:
- https://github.com/AhmedBaset/hadith-json

Jaguar16/open-hadith-data provides a structured dataset with SQLite/JSON/CSV, source references, grading fields, and separates code/data licensing. Its README states code is MIT and structured data CC0, while English translations sourced from Sunnah.com have separate redistribution terms. This separation is exactly the model MADAR should follow. Source:
- https://github.com/Jaguar16/open-hadith-data

### Adhkar / Names
UmmahLibrary documents provenance for its 99 Names and Adhkar datasets and records separate upstream licenses. It is a candidate for ingestion research, not an automatic approval. Source:
- https://github.com/UmmahLibrary/ummah-library/blob/main/packages/data/ATTRIBUTION.md

### GitHub reuse
Initial candidates inspected:
- IDRISIUMCorp/al-furkan-quran-flutter-app: useful reference, but mixed licensing including GPL-3.0 code and a Waqf/Charity repository license. Do not copy blindly.
- meypod/al-quran: AGPL-3.0 application; Tanzil-based Quran text. Reference only unless licensing is deliberately accepted.
- Kabeer786786/adhkar: MIT source code, but hosted audio/CDN has separate restrictions.
- OvaisKhanday/qibla_director_flutter: candidate for further Qibla implementation study.
- AdnanBaset/Zad_Al-Muslim: candidate for further feature/content study.

### Reuse rule
For every external component record repository, exact commit/tag, path, code/data distinction, license, attribution, redistribution/commercial restrictions, and NOTICE requirements before incorporation.

### Non-negotiable content rule
No Quran, Hadith, Tafsir, translation, dua, dhikr, scholarly quote, audio, book, image, or other religious content enters the official core package without provenance and redistribution review.
