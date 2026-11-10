# Backend

Proposed FastAPI service boundary. The current implementation is intentionally small: it exposes a health endpoint and a versioned API root so CI and future frontend work have a real baseline.

Run with `uvicorn app.main:app --reload` from this directory.
