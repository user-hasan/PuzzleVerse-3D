# API contract (proposed)

All endpoints below are proposed until implemented and reviewed.

`GET /health` is implemented in the foundation and returns `{ "status": "ok", "service": "puzzleverse-api" }`.

## Proposed endpoints

- `POST /api/v1/sessions` creates a session with `puzzle_type` and optional initial state.
- `POST /api/v1/sessions/{session_id}/events` records a validated move or hint event.
- `POST /api/v1/cube/validate` validates a manual or recognized cube configuration.
- `POST /api/v1/cube/solve` requests a deterministic solver solution for a valid configuration.
- `POST /api/v1/recommendations` returns a recommendation with model/version and explanation fields.

Errors should use a stable shape: `{ "code": "validation_error", "message": "...", "details": {} }`. Authentication is not implemented; before deployment, use a reviewed identity and authorization design. Versioning begins at `/api/v1` and breaking changes require a new version.
