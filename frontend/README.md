# Frontend

## Flutter prototype

The Android application is in [`app/`](app/). Version 0.1.0 is a local, interactive Rubik's Cube practice prototype. It renders the cube in a rotatable 3D-style view, implements face turns, scramble, undo, reset, and includes unit/widget tests.

```bash
cd app
flutter pub get
flutter test
flutter run
```

The prototype does not yet scan a physical cube, solve a scrambled cube, persist player history, call the FastAPI service, or provide ML recommendations. Its current Android build uses a development signing key and is for testing only, not Google Play distribution. Store release needs production signing, device testing, privacy/legal review, and a tested end-to-end feature set.
