# MADAR Architecture

## Target
Flutter/Dart, feature-first Clean Architecture + MVVM.

## Rules
- Presentation لا تحتوي منطق أعمال أو وصول مباشر للقاعدة.
- Domain مستقل عن Flutter قدر الإمكان.
- Data مسؤولة عن repositories/sources/local persistence.
- Platform code معزول خلف interfaces.
- المحتوى الديني versioned وموقّع/متحقق قدر الإمكان.
- لا network dependency للوظائف الأساسية بعد إعدادها.
- كل feature قابلة للاختبار.

## Initial package layout
`lib/core`, `lib/features`, `lib/data`, `lib/platform`.

## Database
Drift/SQLite مع migrations وFTS5 عند توفره. الجداول النهائية ستثبت بعد تصميم content schema.
