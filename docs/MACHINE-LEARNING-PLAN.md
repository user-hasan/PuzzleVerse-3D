# Machine learning plan

## Direction 1: player intelligence

Problem: estimate a coarse skill or challenge recommendation from session features. Candidate features include completion time, move count, hint count, error count, puzzle type, and prior-session aggregates. Establish a simple interpretable baseline first, use player-level splits to reduce leakage, and report accuracy/F1 for classification or MAE/RMSE for regression. Risks include sparse data, label subjectivity, and confusing correlation with ability.

## Direction 2: computer vision

Problem: detect cube faces and classify sticker colors under camera and lighting variation. Candidate stages are capture guidance, face localization, color-space conversion, sticker sampling, classification, and configuration validation. Report per-color precision/recall, whole-cube validity rate, and failure cases by lighting/device. Do not train or claim accuracy until data consent/licensing, labels, splits, and evaluation scripts exist.

## Experimental method

Record hypotheses, dataset version, preprocessing, model version, random seeds, metrics, and limitations in an experiment report. Prefer a baseline that can be reproduced on a student laptop before adding deep models.
