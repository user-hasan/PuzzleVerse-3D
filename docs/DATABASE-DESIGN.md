# Database design (proposed)

This schema is a proposal for backend review, not a finalized implementation.

```mermaid
erDiagram
  USER ||--o| PLAYER_PROFILE : has
  USER ||--o{ GAME_SESSION : starts
  PUZZLE_TYPE ||--o{ GAME_SESSION : categorizes
  GAME_SESSION ||--o{ PERFORMANCE_EVENT : records
  GAME_SESSION ||--o{ RECOGNITION_RESULT : may_have
  GAME_SESSION ||--o{ DIFFICULTY_RECOMMENDATION : informs
```

Candidate tables are `users`, `player_profiles`, `puzzle_types`, `game_sessions`, `performance_events`, `recognition_results`, and `difficulty_recommendations`. Store the minimum data needed for progress and evaluation. Retention, deletion, indexing, and anonymization decisions require backend and privacy review.
