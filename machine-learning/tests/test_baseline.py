from src.baseline import describe_experiment

def test_baseline_is_honestly_labeled() -> None:
    result = describe_experiment()
    assert result["status"] == "planned"
