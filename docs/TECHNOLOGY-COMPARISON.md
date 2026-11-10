# 3D technology comparison

| Option | Strengths | Risks | Current recommendation |
|---|---|---|---|
| Flutter-compatible 3D package | Single app shell and simpler deployment | Ecosystem maturity and rendering limits require proof | Validate with a small cube interaction POC |
| Unity embedded with Flutter | Mature 3D tooling and strong rendering | Larger build/integration complexity and platform maintenance | Keep as fallback if Flutter POC misses requirements |
| Other engine/web view | Potentially flexible and portable | Additional bridge and performance uncertainty | Consider only with explicit evidence |

Decision rule: compare a measurable cube interaction prototype for rendering quality, frame rate, platform fit, developer effort, and maintenance. The foundation does not silently commit to Unity or a Flutter package.
