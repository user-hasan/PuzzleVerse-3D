# Decision record

## ADR-001 — Keep 3D engine open

**Status:** Proposed. **Decision:** do not commit to Unity or a Flutter 3D package before a proof of concept. **Reason:** the project requires evidence about rendering quality, performance, platform compatibility, and maintenance. **Consequence:** the frontend remains a documented boundary in this foundation.

## ADR-002 — Separate deterministic solving from ML

**Status:** Proposed. **Decision:** solver outputs and ML recommendations have distinct services and documentation. **Reason:** deterministic search is an algorithmic component, while player intelligence and vision are empirical ML/CV research directions.
