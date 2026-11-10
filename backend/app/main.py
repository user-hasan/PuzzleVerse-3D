from fastapi import FastAPI

app = FastAPI(title="PuzzleVerse-3D API", version="0.1.0")

@app.get("/health", tags=["system"])
def health() -> dict[str, str]:
    return {"status": "ok", "service": "puzzleverse-api"}

@app.get("/api/v1", tags=["system"])
def api_root() -> dict[str, str]:
    return {"name": "PuzzleVerse-3D API", "status": "foundation"}
