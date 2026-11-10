# Software Requirements Specification

## User roles

- Player: configures, plays, solves, and reviews progress.
- Researcher/developer: runs experiments, evaluates models, and maintains datasets.
- Maintainer: reviews changes and protects the integration branch.

## Functional requirements

- **FR-001:** The system shall represent a puzzle session with puzzle type, start/end times, move events, and completion state.
- **FR-002:** The system shall allow manual Rubik's Cube color configuration before solver invocation.
- **FR-003:** The system shall validate a cube configuration before attempting a solution.
- **FR-004:** The system shall expose proposed versioned API endpoints for session and recommendation workflows.
- **FR-005:** The system shall separate deterministic solver outputs from ML recommendations.
- **FR-006:** The system should support a Number Puzzle module without changing the platform shell.

## Non-functional requirements

- **NFR-001:** API contracts shall be versioned and documented.
- **NFR-002:** Tests shall cover domain validation and API behavior.
- **NFR-003:** Camera images shall not be retained by default.
- **NFR-004:** Experimental claims shall include data provenance and metrics.
- **NFR-005:** The interface should support accessible contrast, keyboard/screen-reader semantics where applicable, and responsive layouts.

## Acceptance criteria

The MVP is acceptable when a reviewed vertical slice can configure a cube, validate it, call a deterministic solver, record a session, and show a measured ML baseline with reproducible evaluation. Criteria remain subject to team review.
