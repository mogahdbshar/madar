# MADAR Build Policy

## GitHub Actions
Build workflows must use `workflow_dispatch` only.

No:
- push-triggered builds
- pull-request builds that consume build minutes
- automatic release builds

## Manual build
When a stable milestone is ready, the user will manually run the workflow from GitHub Actions.

## Reason
Conserve GitHub Actions quota while keeping reproducible builds available.
