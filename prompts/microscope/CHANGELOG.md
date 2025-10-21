# Microscope Prompt Template - Changelog

## Version 1.0 (2025-10-20)

**Initial Release**

### Features

- Complete three-stage extraction workflow (Screening → Quality Assessment → Data Extraction)
- Integrated Generic Quality Checklist v1.0 with 5 methodological domains and 20 checklist items
- Comprehensive three-color source labeling system (🟢🟡🔴) with decision tree and examples
- Standardized data card output format specification with YAML frontmatter and markdown tables
- Edge case handling guidance for missing data, unclear reporting, conflicting values, and calculations
- Self-validation checklist for AI-generated data cards
- Tested for context window compatibility with 8,000-12,000 word research papers

### Compatible Models

- claude-sonnet-4-5 (primary, 200K context window)
- claude-opus-4 (alternative, 200K context window)
- claude-sonnet-3.5 (fallback, 200K context window)

### Technical Specifications

- **Word Count:** 4,296 words
- **Character Count:** 32,146 characters
- **Estimated Tokens:** ~5,700 tokens
- **Context Window Requirement:** <10,000 tokens combined with typical research paper

### Documentation

- Usage guide created: `docs/microscope-usage.md`
- Example data card updated: `examples/sample_data_card.md`
- Generic quality checklist reference: `modules/generic/generic_quality_checklist.md`

### Known Limitations

- Manual workflow (requires copy-paste into Claude Code conversations)
- Generic quality checklist only (specialized checklists planned for Phase 2)
- No automated validation (requires manual verification of source labels and calculations)

### Future Roadmap

- **Phase 2 (CROS):** CLI automation, automated YAML validation, specialized quality checklists (RoB2, Campbell, etc.)
- **Continuous Improvement:** User feedback integration, context window optimization, domain-specific examples

---

## Versioning Convention

Microscope follows semantic versioning: `vMAJOR.MINOR.PATCH`

- **MAJOR:** Breaking changes to output format or workflow
- **MINOR:** New features, additional guidance, improved instructions
- **PATCH:** Bug fixes, clarifications, typo corrections

**Important:** Always use the same Microscope version throughout a single meta-analysis project for consistency.

---

*Changelog maintained by MAestro Development Team*
