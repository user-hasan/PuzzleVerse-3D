# Algorithms and solver

A deterministic solver maps a valid cube state to a move sequence. It is not an ML model. Candidate methods include a two-phase solver or IDA* with admissible heuristics and pattern databases. The implementation should report solution length, search time, resource use, and invalid-state handling. Korf’s work is a reference for IDA* and pattern databases; the project should choose an implementation only after a proof-of-concept comparison.
