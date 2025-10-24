"""Validation tests for compiled dataset schema ingestion with pandas."""
from __future__ import annotations

from pathlib import Path

import pandas as pd


DATASET_PATH = (
    Path(__file__).resolve().parents[2]
    / "examples"
    / "sample_meta_analysis"
    / "compiled"
    / "sample_compiled_data.csv"
)


def test_pandas_can_read_compiled_schema() -> None:
    """Ensure pandas ingests the compiled dataset without coercion issues."""
    assert DATASET_PATH.exists(), f"Test fixture missing: {DATASET_PATH}"

    df = pd.read_csv(
        DATASET_PATH,
        dtype={
            "year": "Int64",
            "sample_size": "Int64",
            "treatment_n": "Int64",
            "control_n": "Int64",
        },
    )

    expected_columns = {
        "study_id",
        "authors",
        "year",
        "sample_size",
        "intervention",
        "comparison",
        "outcome_measure",
        "effect_size",
        "effect_size_type",
        "effect_size_metric",
        "confidence_interval_lower",
        "confidence_interval_upper",
        "quality_score",
        "source_color_label",
        "data_card_file",
        "extraction_date",
        "extractor_name",
        "compiler_version",
        "treatment_n",
        "control_n",
        "effect_size_standard_error",
        "p_value",
        "evidence_reference",
        "notes",
        "imputed",
        "outcome_timepoint",
    }
    assert set(df.columns) == expected_columns

    # Verify emoji labels survive UTF-8 encoding and remain in the allowed set.
    assert df["source_color_label"].isin({"🟢", "🟡", "🔴"}).all()

    # Confirm numeric columns parse without producing NaN for required entries.
    numeric_columns = [
        "effect_size",
        "quality_score",
    ]
    for column in numeric_columns:
        assert df[column].notna().all(), f"Numeric column {column} contains NaN"

    # Optional CI bounds should be floats when present.
    if df["confidence_interval_lower"].notna().any():
        assert pd.api.types.is_float_dtype(df["confidence_interval_lower"])
    if df["confidence_interval_upper"].notna().any():
        assert pd.api.types.is_float_dtype(df["confidence_interval_upper"])
