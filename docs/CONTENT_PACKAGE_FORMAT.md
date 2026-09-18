# صيغة حزم محتوى مَدار

الحزمة ليست مجرد JSON عشوائي. يجب أن يكون لها manifest واضح، مصدر، ترخيص، إصدار، schemaVersion وSHA-256.

## manifest

```json
{
  "manifest": {
    "id": "quran-core",
    "version": "1.0.0",
    "schemaVersion": 1,
    "sha256": "<sha256>",
    "license": "<license>",
    "source": "<source>"
  }
}
```

## مجموعات البيانات المدعومة

- sources
- quranSurahs
- quranAyahs
- quranTranslations
- tafsir
- hadithCollections
- hadith
- hadithGradings
- adhkar
- duas
- namesOfAllah
- library
- audio

كل سجل ديني يجب أن يحمل sourceId، وتفاصيل المصدر والترخيص محفوظة في sources.

## قاعدة أمان المحتوى

1. تحقق SHA-256 قبل الاستيراد.
2. ارفض manifest الناقص.
3. لا تستورد محتوى مجهول المصدر.
4. لا تعتبر وجود السجل دليلاً على صحة دينية مستقلة.
5. يحتفظ التطبيق بمعلومات المصدر والإصدار.
6. المحتوى غير المرخص لا يدخل الحزمة الرسمية.

## الصوت

الصوت اختياري ولا يُضمّن افتراضياً بكميات ضخمة داخل APK. السجل يحفظ URI والمصدر والترخيص، ويمكن تنزيله أو تشغيله عند الحاجة.
