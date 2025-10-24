# RAAA Usage Guide: Implementing Transparent AI-Assisted Meta-Analysis Documentation

**Version:** 1.0
**Last Updated:** October 23, 2025
**Status:** Ready for use

---

## Quick Start (5 Minutes)

### I'm in a hurry—what's the minimum I need to do?

1. **Copy template** → `templates/raaa_appendix.md` to your project
2. **Fill placeholders** → Complete {{SECTIONS}} for your meta-analysis
3. **Verify checklist** → Run compliance check at bottom of template
4. **Submit** → Include completed appendix with manuscript

**Time:** 20-30 minutes
**Result:** Publication-ready transparency documentation

---

## Full Guide (30 Minutes)

### Step 1: Understand RAAA Purpose

RAAA = **Reproducible AI-Assisted Analysis** appendix template

**Why you need it:**
- Journal editors (Nature, Lancet, JAMA) increasingly require AI transparency disclosure
- Peer reviewers want to understand how AI extraction was validated
- Readers need confidence in data quality before trusting your results
- Transparent documentation enables publication and replication

**What it does:**
- Documents your AI tools (Claude version, MAestro tools)
- Shows how human reviewers validated AI outputs
- Reports data quality distribution (🟢/🟡/🔴)
- Enables exact reproducibility via GitHub commit hashes

### Step 2: Gather Your Metadata

Before starting, collect this information:

**AI Tools Used:**
- [ ] Claude model version (e.g., "Claude 3.5 Sonnet v20241022")
- [ ] Release date
- [ ] MAestro tool versions (Microscope, Compiler, Oracle)
- [ ] Any other tools (Python, R libraries, Excel, etc.)

**Validation Approach:**
- [ ] Who validated? (Name, expertise, affiliation)
- [ ] How many papers? (3 of 14? 5 of 20?)
- [ ] What method? (Manual re-extraction? Expert review?)
- [ ] What was the agreement rate? (98%? 95%?)
- [ ] Any discrepancies? (Describe 1-2 examples)

**Data Quality:**
- [ ] Total data points extracted (e.g., 246)
- [ ] Count in each category: 🟢 (209), 🟡 (27), 🔴 (10)
- [ ] Quality breakdown by paper (optional but recommended)

**Prompts:**
- [ ] GitHub commit hashes for Microscope, Compiler, Oracle
- [ ] Did you modify prompts? (Yes/No)
- [ ] If modified: Describe changes and justification

### Step 3: Choose Your Venue

| Venue | Format | Prompt Strategy | Time |
|-------|--------|-----------------|------|
| **Journal Article** | 2-4 page appendix | Use GitHub links (short) | 20 min |
| **Preprint** | Unlimited supplement | Include full prompts | 30 min |
| **Thesis** | 5-10 page appendix | Include full prompts | 30 min |

**Decision:** Which venue are you targeting?
- [ ] Journal
- [ ] Preprint (bioRxiv, arXiv)
- [ ] Thesis (Master's/PhD)
- [ ] Multiple venues (plan sequential publication)

### Step 4: Open Template and Fill Placeholders

1. Copy `templates/raaa_appendix.md` to your project directory
2. Open in text editor (VS Code, Google Docs, etc.)
3. Search for `{{PLACEHOLDER}}`
4. Replace with your values

**Key sections to complete:**
- {{PROJECT_TITLE}}, {{NUMBER_OF_PAPERS}}, {{RESEARCH_QUESTION}}
- {{CLAUDE_MODEL_NAME}}, {{RELEASE_DATE}}
- {{VALIDATOR_NAME}}, {{VALIDATOR_EXPERTISE}}
- {{TOTAL_COUNT}}, {{GREEN_COUNT}}, {{YELLOW_COUNT}}, {{RED_COUNT}}
- {{GITHUB_LINKS}} for data and code
- All GitHub commit hashes for prompts

### Step 5: Run Compliance Checklist

At bottom of template, verify ALL items:

```
✅ Checklist Items (mark if complete):
- [ ] Claude model version + release date documented
- [ ] MAestro tools listed (Microscope, Compiler, Oracle)
- [ ] Validator credentials + expertise specified
- [ ] Validation coverage reported (N of X papers)
- [ ] 🟢/🟡/🔴 counts + percentages provided
- [ ] GitHub commit hashes for all prompts
- [ ] GitHub URLs tested and working
- [ ] No red flags detected (see below)
```

**If any item unchecked:** Return to relevant section and complete it.

### Step 6: Address Any Red Flags

**🛑 Critical Red Flags:**

1. **Data quality <70% green** → Add sensitivity analysis excluding red data
2. **Validation coverage <20%** → Increase to minimum 20-25%
3. **AI-human agreement <90%** → Investigate disagreement source
4. **No GitHub links** → Locate and test all commit hashes
5. **Prompt modifications undocumented** → Provide full text of changes

**If any red flag present:** Mitigate before submission

### Step 7: Format for Venue

**Journal Article (2-4 pages):**
- Keep short and focused
- Use GitHub links for prompts (not full text)
- Include 1 quality visualization (pie chart)
- References section optional

**Preprint (unlimited):**
- Include full prompt text
- Extended validation details
- All 14 papers quality breakdown (not sample)
- Additional sensitivity analyses

**Thesis:**
- Integrate with methodology chapter (100-200 word summary)
- Full RAAA in appendix (5-10 pages)
- Include detailed validation for all papers

### Step 8: Have Colleague Review

Before submission, ask a peer reviewer to read your RAAA section:
- "Does this explain clearly what AI was used?"
- "Are you convinced the validation was rigorous?"
- "Do you understand what the data quality means?"
- "Could you reproduce this analysis with this information?"

**If answers are "yes" → Ready to submit**
**If any "no" → Revise relevant section**

---

## Common Scenarios & Solutions

### Scenario 1: I validated only 1 of 14 papers (7% coverage)

**Problem:** Validation coverage too low for publication-grade confidence

**Solutions:**
1. **Increase validation:** Validate 3 more papers (reach 28% coverage minimum)
2. **Adjust claims:** Label analysis as "exploratory" rather than definitive
3. **Sensitivity analysis:** Rerun analysis excluding non-validated papers
4. **Transparency:** Clearly document limitation in RAAA section

**Timeframe:** 2-4 hours to validate 3 additional papers

---

### Scenario 2: My agreement rate is only 85% (AI and human disagreed on 15% of data points)

**Problem:** Systematic disagreement suggests extraction issues

**Solutions:**
1. **Investigate:** What types of data caused disagreement? (Ambiguous reporting? Prompt issues?)
2. **Increase sample:** Validate more papers to quantify true disagreement rate
3. **Improve prompt:** Modify Microscope prompt to clarify ambiguous data types
4. **Document:** Explain disagreement source in RAAA; plan sensitivity analysis

**Timeframe:** 1-2 hours investigation

---

### Scenario 3: I modified the MAestro Microscope prompt

**Problem:** Modified prompts cannot claim reproducibility at standard version

**Solutions:**
1. **Document modifications:** Show exact changes (e.g., "Added: 'Extract funding source'")
2. **Justify changes:** Explain why standard prompt was insufficient
3. **Provide full text:** Include modified prompt in appendix (not just GitHub links)
4. **Sensitivity analysis:** Compare standard vs. modified extraction on subset of papers
5. **Transparency:** Acknowledge this reduces reproducibility claims

**Example language:**
```markdown
"The standard Microscope v1.0 prompt was modified to extract
funding source and conflict of interest disclosures (Appendix B).
This modification improved data comprehensiveness but reduces
exact reproducibility. Sensitivity analysis comparing standard vs.
modified extraction on 3 papers showed 96% agreement, confirming
core extraction unchanged."
```

---

### Scenario 4: Our data quality is only 65% green (too much yellow and red data)

**Problem:** Insufficient direct evidence for publication-grade meta-analysis

**Solutions:**
1. **Assess appropriateness:** Is this exploratory or definitive analysis?
2. **Contact authors:** Request missing data directly from original researchers
3. **Sensitivity analysis:** Rerun including only green data; how much do results change?
4. **Honest labeling:** Mark analysis as "preliminary" or "hypothesis-generating"
5. **Transparent limitations:** Discuss in paper why high-quality data was limited

**Example language:**
```markdown
"Data quality analysis revealed 65% directly reported data (green),
25% computed/inferred (yellow), 10% uncertain (red). The high
proportion of computed data reflects heterogeneous outcome reporting
across studies. Sensitivity analysis restricting to green data only
(N=X studies) yielded similar point estimates (HR 2.87 vs. 2.94),
confirming robustness. We recommend caution in interpreting this
exploratory synthesis; definitive meta-analysis awaits standardized
outcome reporting."
```

---

## Advanced Topics

### Topic 1: Creating Data Quality Visualizations

**Goal:** Generate pie chart and heatmaps from compiled CSV

**Resources:**
- Python script: `.bmad-core/task-outputs/task6_data_quality_visualization.md`
- R examples: ggplot2 code for charts by paper and variable
- Output: Publication-ready PNG/PDF figures

**Time:** 15 minutes

**Example output:**
```
🟢 85% (209 points) ██████████████████
🟡 11% (27 points)  ██
🔴 4% (10 points)   █
```

### Topic 2: Finding and Verifying GitHub Commit Hashes

**Goal:** Locate permanent links to exact prompt versions

**Commands:**
```bash
cd /path/to/maestro
git log --oneline prompts/microscope/microscope_v1.0.md | head -1
# Output: a3f7e2c Add Microscope v1.0 prompt
```

**Verification:**
Visit GitHub: `https://github.com/maestro-meta/maestro/blob/a3f7e2c/prompts/microscope_v1.0.md`

Confirm commit hash matches and prompt text is correct.

### Topic 3: Integrating RAAA with Multi-Venue Publication Strategy

**Sequence (6 months total):**

| Month | Action | Venue |
|-------|--------|-------|
| Month 1 | Develop methodology; collect metadata | Local work |
| Month 2 | Complete RAAA in full detail | Internal documentation |
| Month 3 | Post to preprint (bioRxiv) with full RAAA | bioRxiv.org |
| Month 4 | Condense RAAA for journal format; submit to Nature/Lancet | Journal review |
| Month 5-6 | Address peer review comments; finalize publication | Journal publication |

**Benefits:**
- Preprint gets feedback early
- Full documentation visible while journal review pending
- Journal references preprint as reproducibility anchor

---

## Troubleshooting FAQ

**Q: How specific does the Claude version need to be?**

A: Very specific. Examples:
- ✅ Good: "Claude 3.5 Sonnet v20241022"
- ❌ Bad: "Claude 3.5" (which release date?)
- ❌ Bad: "Claude Sonnet" (which version? multiple exist)

Release date is essential because Claude's behavior can shift within patch versions.

---

**Q: Can I use Claude 3 Opus instead of Claude 3.5 Sonnet?**

A: Yes, but document clearly:
- Model used: Claude 3 Opus
- Version: {{VERSION}}
- Release date: {{DATE}}
- Any differences from other Claude versions: {{NOTE}}

Different models may produce slightly different extractions. Document what you used.

---

**Q: What if my validator is co-author on the meta-analysis?**

A: Disclose conflicts explicitly in RAAA:

```markdown
Validator: Dr. Sarah Chen
Affiliation: [Institution]
Expertise: [Credentials]
Conflicts of Interest: Co-author on this meta-analysis paper
```

Disclosure doesn't prevent validation from being valid; it just ensures transparency.

---

**Q: Do I need to include full prompt text if using GitHub links?**

A: Depends on venue:
- **Journal article:** GitHub links sufficient (save space)
- **Preprint:** Include full text (transparency; some readers won't click links)
- **Thesis:** Include full text (permanence; institution archives)

For journal, link becomes permanent via commit hash. Readers can access anytime.

---

**Q: What if the GitHub commit hash changes?**

A: Commit hashes never change. They're permanent identifiers. GitHub has made a public commitment that URLs like:

`https://github.com/maestro-meta/maestro/blob/a3f7e2c/prompts/microscope_v1.0.md`

...will remain accessible indefinitely, even if repository is archived.

---

**Q: Can I submit RAAA to a journal that doesn't ask for it?**

A: Yes! Include it as supplementary material or mention in methods:

```markdown
Methods: "Complete RAAA documentation including validation
procedures, data quality metrics, and prompt versions is available
in Appendix A."
```

Most journals welcome transparent documentation. Some may ask you to move RAAA to main text rather than appendix.

---

## Real-World Examples

### Example 1: Esophageal Cancer CTC Meta-Analysis

**Status:** ✅ Publication-ready RAAA completed

**Key Metrics:**
- Papers: 14
- Data points: 246
- Quality: 85% green (publication-grade)
- Validation: 3 papers, 98% agreement
- Result: HR 2.94 (95% CI 2.15-4.02)

**See:** `.bmad-core/task-outputs/task3_completed_example_appendix.md`

---

### Example 2: Journal Article Format (Nature)

**Status:** ✅ Space-optimized version created

**Format:**
- Length: 2.5 pages
- Tables: 3 (tools, validation, quality metrics)
- Figures: 1 (pie chart)
- Prompt strategy: GitHub links only

**See:** `docs/stories/3.3.design-raaa-transparency-appendix-template.md`

---

## Next Steps After Completing RAAA

1. **Peer review:** Have colleague review RAAA section (10 min)
2. **Format check:** Ensure compliance with journal/venue style
3. **Link testing:** Click all GitHub URLs; confirm they work
4. **Final read:** Proofread for clarity and completeness
5. **Submit:** Include completed RAAA with manuscript

---

## Getting Help

### Questions About RAAA Template?

1. **Check this guide** — Most common questions answered in FAQ section
2. **Review examples** — Esophageal cancer case study shows completed version
3. **Read story 3.3** — Full documentation at `docs/stories/3.3.design-raaa-transparency-appendix-template.md`

### Issues with Implementation?

1. **GitHub issues:** https://github.com/maestro-meta/maestro/issues
2. **Discussion forum:** [Link to MAestro community board]
3. **Email:** [Contact]

---

## Related Documentation

- **Quick Start Guide:** `docs/quickstart.md`
- **Best Practices:** `docs/best-practices.md`
- **Data Quality Visualization:** `.bmad-core/task-outputs/task6_data_quality_visualization.md`
- **Developer Integration:** `.bmad-core/task-outputs/task8_developer_integration.md`
- **Standards Alignment:** `.bmad-core/task-outputs/task7_standards_alignment.md`

---

**End of RAAA Usage Guide**

**Last Updated:** October 23, 2025
**Version:** 1.0
**Status:** Ready for use

