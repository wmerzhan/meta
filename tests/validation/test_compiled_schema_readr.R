# Validation script for ensuring readr compatibility with the compiled schema.
# Run from the repository root with:
#   Rscript tests/validation/test_compiled_schema_readr.R

suppressPackageStartupMessages(library(readr))

dataset_path <- file.path(
  "examples",
  "sample_meta_analysis",
  "compiled",
  "sample_compiled_data.csv"
)

if (!file.exists(dataset_path)) {
  stop("Compiled dataset not found at: ", dataset_path)
}

compiled_data <- readr::read_csv(dataset_path, show_col_types = FALSE)

required_columns <- c(
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
  "outcome_timepoint"
)

missing_cols <- setdiff(required_columns, names(compiled_data))
if (length(missing_cols) > 0) {
  stop("Missing expected columns: ", paste(missing_cols, collapse = ", "))
}

valid_labels <- c("\U0001F7E2", "\U0001F7E1", "\U0001F534")
if (!all(compiled_data$source_color_label %in% valid_labels, na.rm = TRUE)) {
  stop("Unexpected source_color_label detected.")
}

message("readr compatibility check passed: compiled dataset schema is intact.")
