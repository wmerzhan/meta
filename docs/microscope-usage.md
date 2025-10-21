# Microscope Usage Guide

<!-- Powered by BMAD™ Core -->

**Document Version:** 1.0
**Last Updated:** 2025-10-20
**Applies to:** Microscope v1.0

---

## What is Microscope?

**Microscope** is MAestro's structured prompt template for **systematic data extraction from individual research papers** using Claude Code. It guides you through a rigorous three-stage workflow that produces standardized, version-controlled data cards ready for meta-analysis.

### The Microscope Workflow

```
┌─────────────────────────────────────────────────────────────┐
│                     MICROSCOPE WORKFLOW                     │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. SCREENING DECISION                                      │
│     → Should this paper be included?                        │
│     → Assess relevance, design, data availability           │
│     → Output: Include/Exclude with rationale               │
│                                                             │
│  2. QUALITY ASSESSMENT                                      │
│     → Evaluate methodological rigor                         │
│     → Rate 5 domains: Selection, Measurement, Confounding, │
│       Attrition, Transparency                               │
│     → Output: Low/Medium/High risk ratings                  │
│                                                             │
│  3. DATA EXTRACTION                                         │
│     → Extract study data with source labels                 │
│     → Apply three-color transparency system                 │
│     → 🟢 Direct quotes | 🟡 Computed | 🔴 Uncertain       │
│     → Output: Complete data card with YAML + markdown       │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Microscope in the MAestro Ecosystem

Microscope is the first tool in the MAestro research workflow:

- **Microscope** (MVP Phase - Manual) → Extract single paper → Produces data card
- **Compiler** (Epic 2 - Future) → Aggregate all data cards → Produces compiled CSV
- **Oracle** (Epic 3 - Future) → Validate compiled data → Produces validation report

**Current Phase:** MVP - Manual workflow using Claude Code conversations

**Future Phase:** CROS - Command-line automation via Python CLI

---

## How to Use Microscope with Claude Code

### Prerequisites

- **Claude Code** installed and running (any compatible version)
- **Research paper** in one of these formats:
  - PDF (Claude Code can read PDFs directly)
  - Plain text (copy-pasted from paper)
  - Markdown (if paper is already in markdown format)
- **Microscope prompt template** from `prompts/microscope/microscope_v1.0.md`

### Step-by-Step Instructions

#### Step 1: Prepare Your Research Paper

**Option A: PDF File**
1. Save your research paper PDF to an accessible location
2. Note the file path for loading into Claude Code

**Option B: Text Extraction**
1. Open the PDF in a PDF reader
2. Select all text (Ctrl+A / Cmd+A)
3. Copy to clipboard (Ctrl+C / Cmd+C)
4. Keep in clipboard for Step 3

**Option C: Web-based Paper**
1. Access paper through journal website or repository
2. Copy full text including Methods and Results sections
3. Ensure you have complete paper, not just abstract

---

#### Step 2: Load Microscope Prompt Template

1. Open the file `prompts/microscope/microscope_v1.0.md` in a text editor
2. Select all content (Ctrl+A / Cmd+A)
3. Copy to clipboard (Ctrl+C / Cmd+C)

**Tip:** Keep the prompt template file open in a separate editor window for reference during extraction.

---

#### Step 3: Create Claude Code Conversation

1. Open Claude Code
2. Start a new conversation
3. Paste the Microscope prompt template into the message box
4. **Important:** Do not send yet - continue to Step 4

---

#### Step 4: Add Research Paper to Conversation

**If using PDF (Option A):**
1. In the same message box (after the Microscope prompt), type:
   ```
   Please analyze the following research paper:
   ```
2. Use Claude Code's file attachment feature to attach the PDF
3. Send the message

**If using copied text (Option B or C):**
1. In the same message box (after the Microscope prompt), type:
   ```
   Please analyze the following research paper:

   [PASTE FULL PAPER TEXT HERE]
   ```
2. Paste the complete paper text
3. Send the message

**Best Practice:** Keep prompt and paper in a single message for best results.

---

#### Step 5: Monitor AI Extraction Process

Claude Code will now:
1. Read and analyze the research paper
2. Make a screening decision (include/exclude)
3. Conduct quality assessment across 5 domains
4. Extract data with three-color source labels
5. Generate a complete data card

**Expected Time:** 2-5 minutes depending on paper length and complexity

**What to watch for:**
- Screening decision with clear rationale
- Quality ratings for all 5 domains
- Data tables with 🟢🟡🔴 labels on every data point
- Justifications with page number references

---

#### Step 6: Review AI-Generated Data Card

When Claude Code completes extraction, carefully review the output:

**Validation Checklist:**
- [ ] Screening decision is present (include/exclude) with rationale
- [ ] All 5 quality domains rated (selection_bias, measurement_validity, confounding_control, attrition_missing_data, reporting_transparency)
- [ ] Overall quality rating provided (high/medium/low)
- [ ] YAML frontmatter is valid syntax (check `---` delimiters)
- [ ] All required YAML fields populated (study_id, title, authors, year, extraction_date, etc.)
- [ ] Data tables are well-formed with proper markdown syntax
- [ ] **CRITICAL:** Every data point has a source label (🟢/🟡/🔴)
- [ ] Every source label has evidence (page numbers, calculations, explanations)
- [ ] Quality justifications cite specific page references

**Common Issues to Check:**
- Missing page numbers on 🟢 labels
- Calculations not shown for 🟡 labels
- Uncertainty not explained for 🔴 labels
- YAML syntax errors (invalid formatting, missing colons)

---

#### Step 7: Save Data Card

1. Copy the complete data card from Claude Code's response
2. Create a new file in your `data_cards/` directory
3. Name the file using the `study_id` from the data card:
   ```
   data_cards/[study_id].md
   ```
   Example: `data_cards/smith_2023_rct.md`

4. Paste the data card content
5. Save the file

**Git Workflow (Recommended):**
```bash
# After saving data card
git add data_cards/smith_2023_rct.md
git commit -m "Add data card: Smith et al. (2023) RCT on mindfulness"
git push
```

---

#### Step 8: Validate and Iterate (Optional)

If you identify issues in the AI-generated data card:

1. **Minor corrections:** Edit the data card file directly
   - Fix typos, adjust formatting
   - Add missing page numbers
   - Clarify ambiguous evidence

2. **Major issues:** Ask Claude Code for corrections
   - "Please recalculate Cohen's d for the primary outcome"
   - "The intervention group size appears incorrect - can you verify from Table 1?"
   - "Can you provide more detail on the quality assessment for confounding control?"

3. **Complete re-extraction:** Start a new conversation if fundamental problems exist

---

## Understanding the Output

### Data Card Structure

A complete data card consists of two main parts:

```markdown
---
[YAML FRONTMATTER]
Contains metadata: study info, extraction details, screening decision, quality scores
---

[MARKDOWN BODY]
Contains extracted data: demographics, study design, outcomes, effect sizes, quality justifications
```

### YAML Frontmatter Fields

| Field | Description | Example |
|-------|-------------|---------|
| `study_id` | Unique identifier for this paper | `"smith_2023_rct"` |
| `title` | Full paper title | `"Effects of Mindfulness Training..."` |
| `authors` | List of author names | `["Smith J", "Doe A"]` |
| `year` | Publication year (integer) | `2023` |
| `doi` | Digital Object Identifier | `"10.1000/xyz123"` |
| `extraction_date` | When extraction performed | `"2025-10-20T14:30:00Z"` |
| `extractor` | Who performed extraction | `"Claude Code"` |
| `microscope_version` | Prompt version used | `"v1.0"` |
| `claude_model` | AI model used | `"claude-sonnet-4-5-20250929"` |
| `screening_decision` | Include or exclude | `"include"` |
| `quality_scores` | Quality assessment results | See below |

**Quality Scores Structure:**
```yaml
quality_scores:
  checklist_module: "generic_v1.0"
  selection_bias: "low"           # or "medium" or "high"
  measurement_validity: "low"
  confounding_control: "medium"
  attrition_missing_data: "low"
  reporting_transparency: "low"
  overall_quality: "medium"       # "high", "medium", or "low"
```

---

### Three-Color Labeling System

Every extracted data point must have a source label explaining how it was derived:

#### 🟢 Green - Direct Quote/Observation

**Meaning:** Data taken directly from paper without interpretation

**Evidence Format:** Page number + section reference

**Example:**
```
| Total sample size (N) | 120 | 🟢 (p. 7, Methods: Participants section) |
```

**When you see this:** The value is exactly as reported in the paper. You can verify it by checking the cited page.

---

#### 🟡 Yellow - Computed/Inferred Value

**Meaning:** Data calculated or inferred from reported information

**Evidence Format:** Complete calculation + source page numbers

**Example:**
```
| Cohen's d | 0.61 | 🟡 (M1-M2)/SD_pooled = (42.3-38.1)/8.5 = 0.49 (Table 2, p. 10) |
```

**When you see this:** The value was not directly reported but was calculated from available data. The calculation formula shows how it was derived. You can verify by checking the source data and re-calculating.

---

#### 🔴 Red - Uncertain/Missing Data

**Meaning:** Data not clearly reported, ambiguous, or missing

**Evidence Format:** Explanation of what's uncertain/missing + impact

**Example:**
```
| Control group SD | Not reported | 🔴 Baseline SD not provided (p. 9, Table 1). Cannot calculate standardized effect size without author contact. |
```

**When you see this:** The data could not be reliably extracted. The explanation tells you what's missing and why it matters. These flags are critical for assessing data quality and identifying gaps.

---

### Interpreting Quality Assessment

#### Domain Ratings

Each of the 5 quality domains is rated as:
- **Low Risk** = High quality, minimal threats to validity
- **Medium Risk** = Acceptable quality, some limitations
- **High Risk** = Serious quality concerns

**The 5 Domains:**
1. **Selection Bias:** How participants were recruited and selected
2. **Measurement Validity:** Quality of outcome measures and instruments
3. **Confounding Control:** Management of alternative explanations
4. **Attrition/Missing Data:** Handling of dropout and incomplete data
5. **Reporting Transparency:** Completeness of methodological documentation

#### Overall Quality Rating

**High Quality:**
- Most domains (4-5/5) are Low Risk
- No High Risk domains
- Study has strong methodology with minor limitations

**Medium Quality:**
- Mix of Low and Medium Risk (typical: 2-3 Low, 2-3 Medium)
- OR one High Risk domain but others are Low
- Study has acceptable quality but notable limitations

**Low Quality:**
- Multiple High Risk domains (2+)
- OR one critical High Risk domain (e.g., severe confounding)
- Study has substantial methodological limitations

**Using Quality Ratings:**
- Consider **sensitivity analyses** excluding Low Quality studies
- Apply **quality-based weighting** in meta-analysis (if appropriate)
- Report **quality distribution** in your systematic review

---

## Common Issues and Troubleshooting

### Issue: Context Window Exceeded

**Symptom:** Claude Code returns an error about message being too long

**Cause:** Combined length of Microscope prompt + research paper exceeds context window

**Solutions:**
1. **Use a longer-context model** (Sonnet 4 has 200K context)
2. **Shorten the paper:**
   - Remove References section (usually not needed for extraction)
   - Remove lengthy Introduction or Discussion (focus on Methods and Results)
   - Extract only the sections needed for data extraction
3. **Split extraction into multiple conversations:**
   - First conversation: Screening + Quality Assessment only
   - Second conversation: Data Extraction only

**Prevention:** Microscope v1.0 is tested with 8,000-12,000 word papers and should work within Sonnet 4's context window.

---

### Issue: Missing Data in Paper

**Symptom:** Many 🔴 labels in extracted data card

**Cause:** Paper has incomplete reporting (common in published research)

**Response:**
1. **This is expected** - Not all papers report all data points
2. **The 🔴 labels are working correctly** - Flagging uncertainty is the goal
3. **Document the limitations:**
   - Keep the 🔴 labels in your data card
   - Note missing data in your systematic review
   - Consider contacting authors for missing information
4. **Assess impact:**
   - Can you still include the paper in meta-analysis?
   - Does missing data affect certain analyses only?
   - Should the paper be excluded due to insufficient data?

**Remember:** MAestro's three-color system is designed to make missing data transparent, not to eliminate it.

---

### Issue: Quality Assessment Unclear

**Symptom:** Uncertain how to interpret quality ratings or overall assessment

**Cause:** Quality assessment is inherently subjective; borderline cases exist

**Solutions:**
1. **Review the justifications:** Check the "Quality Assessment Justifications" section for detailed explanations with page references
2. **Consult the checklist:** Refer to `modules/generic/generic_quality_checklist.md` for full rating guidance
3. **Apply your meta-analysis standards:**
   - If your field has stricter standards, you can re-rate domains
   - Document any deviations from AI ratings and justify them
   - Consider dual independent extraction for quality ratings
4. **When in doubt, be conservative:** Rate lower quality if uncertain (err on side of caution)

**Best Practice:** Have two reviewers independently conduct quality assessment and resolve disagreements through discussion.

---

### Issue: Incorrect Data Extraction

**Symptom:** AI extracted wrong value or misunderstood paper content

**Cause:** Complex paper structure, ambiguous wording, or AI interpretation error

**Solutions:**
1. **Verify with source:** Check cited page numbers to confirm values
2. **Correct manually:** Edit the data card file directly if error is clear
3. **Ask Claude Code for re-extraction:** Provide specific guidance
   ```
   "Table 2 on page 10 shows intervention group N=64, not 74.
   Please correct and verify all values from Table 2."
   ```
4. **Re-run extraction:** If multiple errors, start fresh conversation with clearer instructions

**Prevention:**
- Use high-quality PDF text (not scanned images)
- Ensure paper text is complete and in correct order
- For complex papers, provide additional context in your conversation with Claude Code

---

### Issue: YAML Syntax Errors

**Symptom:** Data card won't parse or Git shows formatting issues

**Cause:** Invalid YAML syntax in frontmatter (missing colons, incorrect indentation, etc.)

**Solutions:**
1. **Validate YAML online:** Use a tool like yamllint.com
2. **Common fixes:**
   - Ensure `---` delimiters are on their own lines
   - Check for proper indentation (2 spaces, no tabs)
   - Quote strings containing special characters: `title: "A Study: Effects of..."`
   - Ensure lists use proper syntax: `authors: ["Smith J", "Doe A"]`
3. **Fix and re-validate:**
   ```yaml
   # WRONG
   authors: Smith J, Doe A

   # CORRECT
   authors: ["Smith J", "Doe A"]
   ```

---

## Best Practices

### Consistency

**Use the Same Microscope Version**
- All papers in one meta-analysis project should use the same Microscope prompt version
- Record which version you used (check `microscope_version` field)
- If upgrading versions mid-project, document which papers used which version

**Maintain a CHANGELOG**
- Track any manual corrections made to data cards
- Document reasoning for deviations from AI extraction
- Note papers requiring author contact for missing data

---

### Validation and Quality Control

**Dual Independent Extraction (Gold Standard)**
```
Reviewer 1: Extracts data using Microscope → data_cards/smith_2023_rct_reviewer1.md
Reviewer 2: Extracts data using Microscope → data_cards/smith_2023_rct_reviewer2.md
Both reviewers: Compare data cards, resolve discrepancies → data_cards/smith_2023_rct.md (final)
```

**Single Extraction with Validation (Practical)**
```
Researcher: Extracts data using Microscope → data_cards/smith_2023_rct.md
Researcher: Manually validates all 🟢🟡🔴 labels by checking cited pages
Researcher: Spot-checks calculations for 🟡 labels
Researcher: Confirms quality assessment ratings match paper content
```

**Pilot Testing (Before Full Project)**
```
1. Extract 3-5 representative papers
2. Validate extraction quality
3. Identify common issues
4. Adjust workflow or create project-specific guidelines
5. Proceed with full extraction
```

---

### Git Workflow Integration

**Recommended Git Practice:**

```bash
# 1. Create a feature branch for each extraction batch
git checkout -b extraction-batch-01

# 2. Extract papers and save data cards
# (use Microscope as described above)

# 3. Review changes before committing
git diff data_cards/

# 4. Commit each data card individually with descriptive messages
git add data_cards/smith_2023_rct.md
git commit -m "Add: Smith et al. (2023) - Mindfulness RCT, N=120, included"

git add data_cards/jones_2022_cohort.md
git commit -m "Add: Jones et al. (2022) - Cohort study, N=450, included"

git add data_cards/brown_2021_pilot.md
git commit -m "Add: Brown et al. (2021) - Pilot RCT, excluded (insufficient data)"

# 5. Push batch when complete
git push origin extraction-batch-01

# 6. Merge to main via pull request for review
```

**Benefits:**
- Version control for all data cards
- Audit trail of extraction process
- Easy rollback if errors discovered
- Facilitates peer review of extractions

---

### Handling Difficult Papers

**Very Long Papers (>15,000 words)**
- Remove non-essential sections before extraction (References, Acknowledgments, lengthy Discussion)
- Focus on Methods, Results, and relevant Results tables
- If still too long, split into two extractions (Quality + Screening first, then Data Extraction)

**Papers with Missing Data**
- Accept that 🔴 labels are expected and valuable
- Don't force data that isn't clearly reported
- Document what's missing for potential author contact
- Consider exclusion if too many critical data points are missing

**Complex Multi-Study Papers**
- Extract each study as a separate data card
- Use study_id naming: `author_year_study1`, `author_year_study2`
- Note the relationship between cards in "Additional Notes" section

**Non-English Papers**
- Translate to English before extraction (use translation tools)
- Note translation in `extractor` field: `"Claude Code (translated from Spanish)"`
- Be extra cautious with 🟢 labels (translation may alter wording)

---

## Frequently Asked Questions

### Can I customize the Microscope prompt for my specific research domain?

**Yes!** Microscope v1.0 uses the generic quality checklist, but you can:

1. **Add domain-specific quality criteria:**
   - Edit a copy of `microscope_v1.0.md`
   - Add custom checklist items relevant to your field
   - Save as `microscope_v1.0_custom_[domain].md`
   - Document your modifications

2. **Add custom data fields:**
   - Modify the data card template section in the prompt
   - Add tables or fields specific to your meta-analysis
   - Ensure AI is instructed to extract these new fields

3. **Use specialized quality checklists (Future):**
   - Phase 2 will include RoB2, Campbell, and other specialized checklists
   - You can manually integrate these into Microscope if needed now

**Important:** Document any customizations and use the same custom prompt version consistently across your project.

---

### How accurate is AI extraction compared to human extraction?

**Current Understanding:**
- AI extraction with Microscope is **generally accurate** for clearly reported data
- AI is **excellent** at systematic application of extraction protocols
- AI may **miss nuances** or **misinterpret ambiguous wording**

**Best Practice:**
- **Always validate** AI extractions by checking cited page numbers
- **Use dual extraction** for high-stakes systematic reviews
- **Leverage AI strengths:** Consistency, thoroughness, speed
- **Compensate for AI limitations:** Human validation, complex judgment calls

**The three-color labeling system helps:**
- 🟢 labels are usually reliable (direct quotes)
- 🟡 labels can be verified by checking calculations
- 🔴 labels flag uncertain data for human review

---

### What if my paper is only available as a scanned PDF (image-based)?

**Challenge:** Claude Code may struggle with image-based PDFs (OCR quality varies)

**Solutions:**
1. **Use OCR software** to convert to searchable PDF first
   - Adobe Acrobat Pro (commercial)
   - ABBYY FineReader (commercial)
   - Tesseract OCR (free, command-line)

2. **Copy text manually**
   - OCR the PDF yourself
   - Copy and paste text into Claude Code conversation
   - Verify accuracy of OCR output

3. **Re-source the paper**
   - Check if a text-based PDF is available from another source
   - Request text version from authors if needed

---

### Can I use Microscope for qualitative studies or non-empirical papers?

**Designed for:** Quantitative empirical studies with extractable data

**Can be adapted for:**
- **Mixed-methods studies:** Extract quantitative components only
- **Qualitative studies:** Heavily customize the data extraction section; three-color labeling still applies for quote traceability
- **Methodological reviews:** Customize quality assessment and data fields

**Not suitable for:**
- Purely conceptual/theoretical papers (no empirical data to extract)
- Literature reviews or meta-analyses (use these as sources for identifying primary studies instead)

---

## Additional Resources

### Related Documentation

- **Data Card Format Specification:** `docs/data-card-format.md`
- **Generic Quality Checklist:** `modules/generic/generic_quality_checklist.md`
- **Data Card Template:** `templates/data_card.md`
- **Example Data Card:** `examples/sample_data_card.md`

### MAestro Architecture

- **PRD:** `docs/prd.md`
- **Architecture Documentation:** `docs/architecture.md`
- **Core Workflows:** `docs/architecture/core-workflows.md`
- **Data Models:** `docs/architecture/data-models.md`

---

## Getting Help

### Troubleshooting Steps

1. **Check this guide** for common issues and solutions
2. **Review example data card** (`examples/sample_data_card.md`) for reference
3. **Validate YAML syntax** using online tools if formatting errors occur
4. **Consult generic quality checklist** for quality assessment questions

### Reporting Issues

If you encounter bugs, errors, or limitations in Microscope:

1. **Document the issue:**
   - Which paper caused the problem?
   - What was the error or unexpected behavior?
   - What did you expect to happen?

2. **Check if it's a known limitation:**
   - Review this guide's "Common Issues" section
   - Check if issue relates to paper quality (missing data → expected 🔴 labels)

3. **File an issue** (if applicable to your project setup):
   - Include Microscope version used
   - Include relevant excerpt from paper (if shareable)
   - Include excerpt from generated data card showing issue

---

**Version History:**

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2025-10-20 | Initial usage guide for Microscope v1.0 |

---

*End of Microscope Usage Guide*
