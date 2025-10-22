#!/usr/bin/env python3
"""Validate prompt template metadata and basic markdown formatting."""

from __future__ import annotations

import argparse
import re
import sys
from datetime import datetime
from pathlib import Path
from typing import Iterable, List

REQUIRED_METADATA = {
    "version": re.compile(r"^\*\*Version:\*\*\s*(?P<value>.+)$", re.MULTILINE),
    "created": re.compile(
        r"^\*\*Created:\*\*\s*(?P<value>\d{4}-\d{2}-\d{2})$", re.MULTILINE
    ),
    "template_type": re.compile(
        r"^\*\*Template Type:\*\*\s*(?P<value>.+)$", re.MULTILINE
    ),
    "compatible_models": re.compile(
        r"^\*\*Compatible Claude Models:\*\*$", re.MULTILINE
    ),
}


def find_prompt_files(root: Path) -> Iterable[Path]:
    """Yield markdown prompt files under the prompts directory."""
    for path in sorted(root.rglob("*.md")):
        if path.is_file() and path.name.lower() != "changelog.md":
            yield path


def validate_metadata(text: str, path: Path) -> List[str]:
    """Validate prompt metadata fields."""
    errors: List[str] = []

    for key, pattern in REQUIRED_METADATA.items():
        match = pattern.search(text)
        if not match:
            errors.append(f"missing required metadata field '{key}'")
            continue

        if key == "version":
            value = match.group("value").strip()
            if not re.fullmatch(r"\d+\.\d+", value):
                errors.append("version must follow semantic format 'major.minor'")

        if key == "compatible_models":
            # Expect at least one bullet immediately following the header line.
            header_end = match.end()
            bullet_block = text[header_end:].lstrip()
            if not bullet_block.startswith("- "):
                errors.append(
                    "compatible models list must include at least one bullet item"
                )

        if key == "created":
            value = match.group("value").strip()
            try:
                datetime.strptime(value, "%Y-%m-%d")
            except ValueError:
                errors.append("created date must be ISO formatted (YYYY-MM-DD)")

    return [f"{path}: {error}" for error in errors]


def validate_markdown(text: str, path: Path) -> List[str]:
    """Perform lightweight markdown syntax checks."""
    errors: List[str] = []

    fence_count = text.count("```")
    if fence_count % 2 != 0:
        errors.append("contains unbalanced code fences")

    return [f"{path}: {error}" for error in errors]


def validate_prompt(path: Path) -> List[str]:
    """Validate a single prompt file."""
    text = path.read_text(encoding="utf-8")
    errors = []
    errors.extend(validate_metadata(text, path))
    errors.extend(validate_markdown(text, path))
    return errors


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Validate prompt metadata and markdown."
    )
    parser.add_argument(
        "--prompts-dir",
        type=Path,
        default=Path("prompts"),
        help="Path to the prompts directory (default: ./prompts)",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    prompts_dir = args.prompts_dir

    if not prompts_dir.exists():
        print(f"Prompts directory not found: {prompts_dir}", file=sys.stderr)
        return 1

    all_errors: List[str] = []
    for prompt_path in find_prompt_files(prompts_dir):
        all_errors.extend(validate_prompt(prompt_path))

    if all_errors:
        for error in all_errors:
            print(error, file=sys.stderr)
        return 1

    print("All prompt templates passed validation.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
