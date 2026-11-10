# System architecture

The proposed architecture uses a Flutter client, a FastAPI REST service, a relational persistence layer, deterministic puzzle services, an OpenCV computer-vision boundary, and Python ML experiments. The API is the integration boundary; the client should remain usable for local puzzle state when network access is unavailable.

```mermaid
flowchart TB
  Client[Flutter client] --> Gateway[FastAPI API v1]
  Gateway --> Sessions[Session service]
  Gateway --> Recommendations[Recommendation service]
  Gateway --> Solver[Deterministic solver service]
  Gateway --> Vision[OpenCV CV service]
  Gateway --> ML[ML inference boundary]
  Sessions --> DB[(Relational database)]
  Recommendations --> DB
  Vision --> Validation[Cube configuration validator]
  Solver --> Validation
```

All ML and CV components are proposed boundaries. They must be implemented and measured before they are described as operational.
