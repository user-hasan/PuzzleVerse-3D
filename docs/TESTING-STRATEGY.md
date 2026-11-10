# Testing strategy

Unit tests cover cube state validation, solver invariants, feature extraction, and schema validation. API tests cover status codes and error contracts. Integration tests cover client/API/session boundaries. CV tests use labeled fixtures and lighting strata. ML tests cover deterministic preprocessing, leakage checks, and metric calculations. End-to-end tests should cover configure → validate → solve → record session. The current foundation includes backend and ML baseline tests only.
