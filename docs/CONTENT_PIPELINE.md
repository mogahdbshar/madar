# MADAR Content Pipeline

1. Discover candidate source.
2. Record exact URL/repository and retrieval date.
3. Separate code license from data/content license.
4. Verify redistribution terms.
5. Normalize into an internal import schema without changing religious source text.
6. Validate required provenance fields.
7. Validate record counts and identifiers.
8. Generate a package manifest with schema version and SHA-256.
9. Run structural and duplicate checks.
10. Review samples against the upstream source.
11. Record attribution in NOTICE.
12. Only then mark the package approved.
13. Import into the local Drift database.
14. Preserve source/version metadata for future audits.

Rejected content is kept out of the official package rather than silently substituted.
