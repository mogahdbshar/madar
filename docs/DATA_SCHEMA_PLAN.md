# MADAR Data Schema Plan

The local database is designed around provenance-first content.

Core planned entities:
- content_sources
- content_packages
- quran_surahs
- quran_ayahs
- quran_translations
- tafsir_entries
- hadith_collections
- hadith_books
- hadith_chapters
- hadith_entries
- hadith_gradings
- adhkar
- dua_entries
- names_of_allah
- library_items
- audio_tracks
- bookmarks
- notes
- reading_progress
- worship_entries
- prayer_settings
- app_settings
- downloaded_packages

Rules:
1. Every religious content record points to a source.
2. Source and content version are retained.
3. Original religious text is immutable.
4. Search normalization is stored separately.
5. Migrations are explicit.
6. Content packages can be replaced independently of UI code when schema compatibility allows.
7. Large audio is never bundled by default.
