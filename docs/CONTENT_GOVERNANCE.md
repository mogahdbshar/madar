# MADAR Content Governance

كل محتوى ديني يمر بمراحل:
1. Source discovery
2. License verification
3. Provenance capture
4. Normalization without altering protected original text
5. Structural validation
6. Cross-check where possible
7. Human/source review
8. Packaging
9. Versioning + checksum
10. In-app attribution

حقول المصدر الأساسية:
- source_id
- source_name
- source_url
- dataset/version
- license
- license_url
- collected_at
- checksum
- modification_policy
- verification_status
- notes

ممنوع:
- اختراع نص ديني.
- تعديل نص محمي دون إذن.
- نسب قول بلا مصدر.
- اعتبار API متاحًا دليلًا على السماح بإعادة التوزيع.
