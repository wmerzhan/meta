# Standardized Compiled Dataset Schema

This document defines the canonical CSV/TSV schema produced by the Compiler engine.
All automation that aggregates DataCards **must** emit tabular data that matches
these columns, order, and data typing rules so downstream tooling (R, Python,
Excel, SPSS) can consume the dataset without additional munging.

The schema aligns with the **CompiledDataset** model described in
`docs/architecture/data-models.md` and preserves the three‑color evidence
labelling contract originating from individual DataCards (`templates/data_card.md`).

## Required Columns

| Column | Type | Required | Description |
| --- | --- | --- | --- |
| `study_id` | `string` | ✅ | Stable identifier that matches DataCard front matter (`study_id`). Use lower snake case (e.g., `nakashima_2003_cohort`). |
| `authors` | `string` | ✅ | Primary author surname(s) and “et al.” pattern exactly as found in the DataCard metadata. |
| `year` | `integer` | ✅ | Publication year; four-digit numeric string that downstream readers can coerce to integer. |
| `sample_size` | `integer` | ✅ | Total analyzed sample size for the specific outcome. When treatment and control sizes differ, store aggregated N and expose arm-level Ns in optional columns (see [Optional Columns](#optional-columns)). |
| `intervention` | `string` | ✅ | Canonicalized intervention label. Should mirror DataCard intervention taxonomy. |
| `comparison` | `string` | ✅ | Comparator description (placebo, usual care, etc.). |
| `outcome_measure` | `string` | ✅ | Human-readable outcome label (e.g., “Pain reduction at 12 weeks”). |
| `effect_size` | `number` | ✅ | Numeric effect estimate. Use decimals for continuous metrics and natural log values for ratio-based metrics (OR/RR/HR). |
| `effect_size_type` | `string` | ✅ | Enumerated outcome family. Allowed values: `continuous_mean_diff`, `continuous_smd`, `dichotomous_or`, `dichotomous_rr`, `dichotomous_hr`, `correlation`, `other`. |
| `effect_size_metric` | `string` | ✅ | Statistical metric or transformation used (e.g., `Hedges_g`, `Cohen_d`, `log_or`, `pearson_r`). |
| `confidence_interval_lower` | `number` | ✅ | Lower bound of the 95% confidence interval in the same scale as `effect_size`. |
| `confidence_interval_upper` | `number` | ✅ | Upper bound of the 95% confidence interval in the same scale as `effect_size`. |
| `quality_score` | `number` | ✅ | Study-level quality numeric value (0–1 or 0–100 depending on DataCard definition). See [Quality Guidance](#quality-and-labels). |
| `source_color_label` | `string` | ✅ | Source fidelity emoji. Allowed values: `🟢`, `🟡`, `🔴`. |
| `data_card_file` | `string` | ✅ | Relative path to the source DataCard markdown file (e.g., `data_cards/nakashima_2003_cohort.md`). |
| `extraction_date` | `date` (ISO 8601) | ✅ | Date the extraction was performed, formatted `YYYY-MM-DD`. |
| `extractor_name` | `string` | ✅ | Name or agent identifier that produced the extraction (`Microscope`, `AnalystName`, etc.). |
| `compiler_version` | `string` | ✅ | Semantic version of the compiler tool that generated the row (e.g., `compiler_v1.1`). |

## Optional Columns

| Column | Type | When to Use |
| --- | --- | --- |
| `treatment_n` / `control_n` | `integer` | Provide when per-arm sample sizes are needed. |
| `effect_size_standard_error` | `number` | Supply when CI bounds are not available but SE is. |
| `p_value` | `number` | Include if reported alongside the effect size. |
| `evidence_reference` | `string` | Cite page/figure/table references for traceability. |
| `notes` | `string` | Short free-text remark for heterogeneity or adjustments. |
| `imputed` | `boolean` | Flag when values were calculated or imputed downstream. |
| `outcome_timepoint` | `string` | Capture follow-up window (e.g., `12_weeks`). |

Optional columns **must** appear after the required set when exporting to CSV/TSV.
Downstream parsers should treat absent optional columns as legitimately missing.

## Quality and Labels

- `source_color_label` carries the original 🟢 / 🟡 / 🔴 designation from DataPoints.
  Keep the literal emoji so downstream visualization tools remain consistent.
- `quality_score` should map directly to the DataCard’s reported quality metrics.
  Normalize scores to a 0–1 float when possible; if a different scale is necessary,
  document the rule in the `notes` column and in release notes.

## Handling Outcome Families

1. **Continuous metrics**: Store raw or standardized mean differences in `effect_size`
   and note the exact metric (e.g., `mean_difference`, `Hedges_g`) in `effect_size_metric`.
   Maintain consistent units (e.g., all pain scores scaled 0–100). If normalization is performed,
   document the method in `notes`.
2. **Dichotomous metrics**: Emit log-transformed ratios (`log_or`, `log_rr`, `log_hr`) in
   `effect_size`, ensuring CI bounds are log-transformed as well.
3. **Correlation metrics**: Store Fisher transformed values (`z_r`) when available; otherwise,
   provide raw `pearson_r` and set `effect_size_metric` accordingly.
4. **Other metrics**: Use `effect_size_type = other` and detail the structure in `notes`.
   Always provide enough metadata for analysts to back-transform the result.

## Missing Values & Heterogeneous Structures

- Use empty strings for unknown string fields and blank numeric cells for missing numbers.
  Do **not** write `NA` or `NULL`; let downstream readers apply their own missing logic.
- When a study omits CI information, populate `effect_size_standard_error` if derivable.
  Otherwise, leave CI columns blank and mark `notes = "CI not reported"`.
- For multi-arm or multi-outcome studies, emit separate rows per outcome/timepoint.
  Include `notes` or `outcome_timepoint` to disambiguate.
- Imputed or transformed data should set `imputed = true` and describe the method in `notes`
  (e.g., “Calculated standard deviation from standard error”).

## File Format Expectations

- **Delimiter**: Default to comma-separated values for `.csv`. Provide `.tsv` variants for tooling
  that struggles with commas in textual fields. Column order must remain identical across formats.
- **Encoding**: UTF-8 with BOM omitted. This ensures emoji labels remain intact.
- **Header row**: Always present; column names must exactly match the identifiers above.
- **Line endings**: `\n` (Unix) preferred; tools should tolerate `\r\n`.

## Compatibility Guidance

- **Python**: `pandas.read_csv(..., dtype={ "year": "Int64", "sample_size": "Int64" })` correctly
  preserves nullable integers. Provide a helper loader in `tests/validation/` (see associated tests).
- **R**: `readr::read_csv(show_col_types = FALSE)` reads the dataset without manual schema hints.
  Use `col_integer()` for `year`/`sample_size` and `col_double()` for numeric metrics.

## Provenance & Cross-links

- Source DataCards live under project-specific `data_cards/` directories. Always populate
  `data_card_file` with a path relative to the compiled project root so analysts can trace a row.
- Refer to `templates/data_card.md` for the authoritative field list that feeds this schema.
- Tie quality and evidence guidance back to `modules/generic/generic_quality_checklist.md`
  and `docs/architecture/components.md#component-4-compiler-engine` when updating logic.

## Sample Dataset & Validation Artifacts

- A reference dataset is available at `examples/sample_meta_analysis/compiled/sample_compiled_data.csv`
  (duplicated at `examples/sample_compiled_data.csv` for quick access). It demonstrates aggregation
  from both gold-standard and automated DataCards across five studies.
- Python compatibility is covered by `pytest` via `tests/validation/test_compiled_schema_io.py`,
  which exercises `pandas.read_csv` with nullable integer dtypes and emoji handling.
- R compatibility requires a local `Rscript` CLI with the `readr` package installed
  (e.g., `Rscript -e "install.packages('readr', repos='https://cloud.r-project.org')"`)
  and can be verified by running
  ```bash
  Rscript tests/validation/test_compiled_schema_readr.R
  ```
  which loads the schema with `readr::read_csv()` and confirms column integrity.

## Change Management

Any schema changes must:

1. Bump `compiler_version`.
2. Update this document and the sample dataset.
3. Regenerate validation tests to cover new columns or constraints.
4. Announce changes in release notes or `CHANGELOG.md`.
